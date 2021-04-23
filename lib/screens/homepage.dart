import 'package:buyerapp/main.dart';
import 'package:buyerapp/screens/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: Text('Products', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () {
                newUser.logOut().whenComplete(() => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => LogIn())));
              })
        ],
      ),
      body: Container(
        child: FutureBuilder(
            future: newUser.loadProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: MediaQuery.of(context).size.height*0.4,
                        crossAxisCount: 2, mainAxisSpacing: 30),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final product = snapshot.data[index];
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image(
                              fit: BoxFit.contain,
                              image: NetworkImage(product['image'])),
                            Text(product['name']),
                            Text(product['price']),
                          ],
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
