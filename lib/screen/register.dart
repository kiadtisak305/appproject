import 'package:appproject/app/data/model/profile.dart';
import 'package:appproject/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
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
                                horizontal: 35, vertical: 200),
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
                                        "Register",
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
                                          hintText: "Username",
                                          hintStyle: TextStyle(fontSize: 20)),
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: "กรุณาป้อนชื่อผู้ใช้"),
                                      ]),
                                      onSaved: (username) {
                                        profile.username = username!;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0,
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
                                        top: 5.0,
                                        right: 30,
                                        left: 30,
                                        bottom: 8),
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

                                  //---------------------------------------- Sign up ---------------------------------//
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
                                                  "ลงทะเบียน",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        onTap: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                            print(
                                                "email = ${profile.email} password = ${profile.password}");
                                            try {
                                              await FirebaseAuth.instance
                                                  .createUserWithEmailAndPassword(
                                                      email: profile.email,
                                                      password:
                                                          profile.password)
                                                  .then((userCredential) async {
                                                final user =
                                                    userCredential.user;
                                                await user?.updateDisplayName(
                                                    profile.username);
                                                formKey.currentState!.reset();
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "สร้างบัญชีผู้ใช้เรียบร้อยแล้ว",
                                                    gravity:
                                                        ToastGravity.CENTER);
                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                        builder: (context) {
                                                  return LoginScreen();
                                                }));
                                              });
                                            } on FirebaseAuthException catch (e) {
                                              print(e.code);
                                              String? message;
                                              if (e.code ==
                                                  'email-already-in-use') {
                                                message =
                                                    "มีอีเมลนี้ในระบบแล้ว โปรดใช้อีเมลอื่นแทน";
                                              } else if (e.code ==
                                                  'weak-password') {
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
                                  )
                                  //---------------------------------------- Sign up ---------------------------------//
                                ],
                              ),
                            ),
                          )),
                    ),
                  ])),
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
}
