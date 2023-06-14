import 'package:appproject/screen/addvalve.dart';
import 'package:appproject/screen/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/profile.dart';

//import '../presentation/my_flutter_app_icons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(username: '', email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Color(0xFFE6E6E6),
                body: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/background.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                      child: Column(children: [
                    Container(
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 180),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 25),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0,
                                      right: 30,
                                      left: 30,
                                      bottom: 8),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        hintText: "E-mail",
                                        hintStyle: TextStyle(fontSize: 20)),
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "กรุณาป้อนอีเมล"),
                                      EmailValidator(
                                          errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                                    ]),
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (email) {
                                      profile.email = email!;
                                    },
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, right: 30, left: 30, bottom: 8),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        hintText: "Password",
                                        hintStyle: TextStyle(fontSize: 20),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _isHidden = !_isHidden;
                                            });
                                          },
                                          icon: Icon(_isHidden
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        )),
                                    validator: RequiredValidator(
                                        errorText: "กรุณาป้อนรหัสผ่าน"),
                                    obscureText: _isHidden,
                                    onSaved: (password) {
                                      profile.password = password!;
                                    },
                                  ),
                                ),

                                //------------------------------------------ login btn -----------------------------------------------------------------------
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 30),
                                  child: InkWell(
                                      child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.pink),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "Sign in",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        if (formKey.currentState!.validate()) {
                                          formKey.currentState!.save();
                                          print(
                                              "email = ${profile.email} password = ${profile.password}");
                                          try {
                                            await FirebaseAuth.instance
                                                .signInWithEmailAndPassword(
                                                    email: profile.email,
                                                    password: profile.password)
                                                .then((value) {
                                              formKey.currentState!.reset();
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return AddValveScreen();
                                              }));
                                            });
                                          } on FirebaseAuthException catch (e) {
                                            print(e.code);
                                            String? message;
                                            if (e.code == 'weak-password') {
                                              message =
                                                  "รหัสผ่านต้องมีความยาว 6 ตัวอักษรขึ้นไป";
                                            } else {
                                              message = e.message;
                                            }
                                            Fluttertoast.showToast(
                                                msg: message.toString(),
                                                gravity: ToastGravity.CENTER);
                                          }
                                        }
                                      }),
                                ),
                                //------------------------------------------ login btn -----------------------------------------------------------------------

                                //------------------------------------------ login with google btn -----------------------------------------------------------
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 30),
                                  child: InkWell(
                                    child: Container(
                                        width: double.infinity, //ขนาดปุ่ม
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.black),
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 30.0,
                                              width: 30.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/google-logo.png'),
                                                    fit: BoxFit.cover),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10)),
                                            Text(
                                              'Sign in with Google',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ))),
                                    onTap: () {
                                      //อีเว้นหลังจากกดปุ่ม
                                      signInWithGoogle()
                                          .then((UserCredential user) {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return AddValveScreen();
                                        }));
                                      }).catchError((e) {
                                        print(e.toString());
                                      });
                                    },
                                  ),
                                ),

                                //------------------------------------------ login with google btn -----------------------------------------------------------

                                //------------------------------------------ register btn --------------------------------------------------------------------
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 30),
                                  child: InkWell(
                                      child: Container(
                                        width: double.infinity, //ขนาดปุ่ม
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.pink),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 3)),
                                              Text(
                                                "Sign up",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        //อีเว้นหลังจากกดปุ่ม
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return RegisterScreen();
                                        }));
                                      }),
                                ),
                              ],
                            ),
                          ),
                          //------------------------------------------ register btn --------------------------------------------------------------------
                        ),
                      ),
                    ),
                  ]))
                ]),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
