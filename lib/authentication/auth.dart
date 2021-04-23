import 'package:buyerapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final postref = FirebaseFirestore.instance.collection('posts');

  Future resgisterUser({Users users}) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: users.email, password: users.password);
    return userCredential.user;
  }

  Future logInUser({Users users, Function navToHome}) async {
    final User user = (await _auth.signInWithEmailAndPassword(
            email: users.email, password: users.password))
        .user;
    return user;
  }

  Future forgotPassword({String emailID}) async {
    await _auth.sendPasswordResetEmail(email: emailID);
  }

  Future logOut() async {
    await _auth.signOut();
  }

  Future loadProducts() async {
    QuerySnapshot querySnapshot = await postref.get();
    return querySnapshot.docs;
  }
}
