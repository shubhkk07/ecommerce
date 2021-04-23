import 'package:buyerapp/main.dart';
import 'package:buyerapp/models/user.dart';
import 'package:buyerapp/screens/SignUp.dart';
import 'package:buyerapp/validations/validation.dart';
import 'package:buyerapp/widget/exception.dart';
import 'package:buyerapp/widget/fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'homepage.dart';

//stack empty krr diyo login ke baad
class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController t1 = TextEditingController();

  TextEditingController t2 = TextEditingController();

  bool obstext = true;

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  void pressed() {
    setState(() {
      obstext = !obstext;
    });
  }

  String error;

  navigationToHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  String passwordValidation(String val) {
    if (val.length < 8) {
      return 'Enter a valid password';
    }
  }

  Future forgotPass(String email) async {
    try {
      await newUser.forgotPassword(emailID: email);
    } catch (e) {
      setState(() {
        error = 'user not exists';
      });
    }
  }

  Future signin(Users user) async {
    try {
      await newUser.logInUser(users: user);
      return navigationToHome();
    } on FirebaseException catch (e) {
      print(e);
      if (e.toString() == firebaseException) {
        return showException(context: context);
      }
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Incorrect'),
                content: Text('Invalid username or password'),
              ));
    } catch (e) {
      print(e);
      showException(context: context);
    }
  }

  String forgotpass =
      'If you need help resetting your password, we can help by sending you a link to reset it.';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
        ),
        Positioned(
            top: 0,
            left: 0,
            child: Container(
              color: Colors.teal,
              height: size.height * 0.3,
              width: size.width,
            )),
        Positioned(
            top: size.height * 0.25,
            left: 15,
            right: 15,
            child: Material(
              borderRadius: BorderRadius.circular(8),
              elevation: 12,
              child: Container(
                height: size.height * 0.68,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Form(
                    key: _key,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            height: size.height * 0.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.withOpacity(0.9)),
                                ),
                                TextEntry(
                                  validation: (val) => validateEmail(t1.text),
                                  borderr: true,
                                  controller: t1,
                                  iconData: Icons.mail,
                                  labeltext: 'Email-ID',
                                ),
                                TextEntry(
                                    validation: (val) =>
                                        passwordValidation(t2.text),
                                    borderr: true,
                                    controller: t2,
                                    iconData: Icons.lock,
                                    obscuretext: obstext,
                                    labeltext: 'Password',
                                    iconButton: IconButton(
                                        icon: Icon(Icons.visibility_outlined),
                                        onPressed: pressed)),
                              ],
                            ),
                          ),
                          SizedBox(height: size.height * 0.032),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      size.width * 0.55, size.height * 0.05),
                                  shape: StadiumBorder()),
                              child:
                                  Text('Login', style: TextStyle(fontSize: 20)),
                              onPressed: () async {
                                final FormState formState = _key.currentState;
                                if (formState.validate()) {
                                  final newUser =
                                      Users(email: t1.text, password: t2.text);
                                  signin(newUser);
                                }
                              }),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6),
                                        fontSize: 16),
                                    text: "Don't have a Account?",
                                    children: [
                                      TextSpan(
                                          text: ' Sign Up',
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignUp()));
                                            },
                                          children: [
                                            TextSpan(
                                                text: '\nForgot Password',
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () =>
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  content:
                                                                      Container(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            12,
                                                                        right:
                                                                            12),
                                                                    height: size
                                                                            .height *
                                                                        0.25,
                                                                    child: Form(
                                                                      key:
                                                                          _globalKey,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          Text(
                                                                              forgotpass),
                                                                          TextEntry(
                                                                            labeltext:
                                                                                'Email-ID',
                                                                            validation: (val) =>
                                                                                validateEmail(t1.text),
                                                                            borderr:
                                                                                true,
                                                                            controller:
                                                                                t1,
                                                                            iconData:
                                                                                Icons.email,
                                                                          ),
                                                                          
                                                                          MaterialButton(
                                                                            color:
                                                                                Colors.blue,
                                                                            hoverColor:
                                                                                Colors.white,
                                                                            hoverElevation:
                                                                                12,
                                                                            onPressed:
                                                                                () async {
                                                                              FormState formState = _globalKey.currentState;

                                                                              if (formState.validate()) {
                                                                                forgotPass(t1.text);
                                                                                setState(() {
                                                                                  Navigator.pop(context);
                                                                                  setState(() {
                                                                                    t1.clear();
                                                                                  });
                                                                                });
                                                                                await showException(context: context, exp: 'Reset link has been sent to given mail');
                                                                              }
                                                                            },
                                                                            child:
                                                                                Text('Send Link'),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  title: Text(
                                                                    'Forgot Password',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                );
                                                              })),
                                          ])
                                    ])),
                          )
                        ],
                      ),
                    )),
              ),
            ))
      ],
    )));
  }
}
