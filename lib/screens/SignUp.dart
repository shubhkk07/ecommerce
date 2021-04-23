import 'package:buyerapp/main.dart';
import 'package:buyerapp/models/user.dart';
import 'package:buyerapp/screens/login.dart';
import 'package:buyerapp/validations/validation.dart';
import 'package:buyerapp/widget/exception.dart';
import 'package:buyerapp/widget/fields.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController t1 = TextEditingController(text: '');

  TextEditingController t2 = TextEditingController();

  TextEditingController t3 = TextEditingController();

  TextEditingController t4 = TextEditingController();

  TextEditingController t5 = TextEditingController();

  bool obstext = true;

  void pressed() {
    setState(() {
      obstext = !obstext;
    });
  }

  navigationToLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LogIn()));
  }

  String confirmPasswordVal() {
    if (t4.text != t5.text) {
      return "passwords don't macth";
    }
  }

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.height * 0.8,
          width: size.width * 0.83,
          child: SafeArea(
            bottom: true,
            left: true,
            right: true,
            top: true,
            minimum: EdgeInsets.all(12),
            child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'REGISTER',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.withOpacity(0.7)),
                  ),
                  TextEntry(
                    controller: t1,
                    iconData: Icons.person,
                    labeltext: 'Name',
                    validation: (val) => validateName(t1.text),
                  ),
                  TextEntry(
                    controller: t2,
                    iconData: Icons.email_outlined,
                    labeltext: 'E-mail ID',
                    validation: (val) => validateEmail(t2.text),
                  ),
                  // TextEntry(
                  //   controller: t3,
                  //   iconData: Icons.phone,
                  //   labeltext: 'Mobile Number',
                  //   ktype: TextInputType.phone,
                  //   validation: (val) => phoneValidation(t3.text),
                  // ),
                  TextEntry(
                    controller: t4,
                    iconData: Icons.lock,
                    labeltext: 'Password',
                    iconButton: IconButton(
                        icon: Icon(Icons.visibility_outlined),
                        onPressed: pressed),
                    obscuretext: obstext,
                    validation: passwordValidator,
                  ),
                  TextEntry(
                    controller: t5,
                    validation: (val) => confirmPasswordVal(),
                    iconData: Icons.lock,
                    labeltext: 'Confirm Password',
                    obscuretext: obstext,
                    iconButton: IconButton(
                        icon: Icon(Icons.visibility_outlined),
                        onPressed: pressed),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            elevation: 10,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            primary: Colors.teal[500],
                          ),
                          onPressed: () async {
                            final FormState formState = _globalKey.currentState;
                            if (formState.validate()) {
                              formState.save();
                              final user = Users(
                                  name: t1.text,
                                  email: t2.text,
                                  // phone: int.parse(t3.text),
                                  password: t4.text);

                              final nuser = await newUser.resgisterUser(
                                users: user,
                              );

                              nuser != null
                                  ? showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: Text('Registered'),
                                            content: Text('Go to login page'),
                                          ))
                                  : showException(context:context);
                              formState.reset();
                            }
                          },
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(fontSize: 20),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: RichText(
                              text: TextSpan(
                                  text: 'Already have an account ?',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: 16),
                                  children: [
                                TextSpan(
                                    text: ' Log in',
                                    style: TextStyle(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => navigationToLogin())
                              ])),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
