import 'package:appproject/screen/home.dart';
import 'package:appproject/screen/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../model/profile.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(username: '',email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

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
            return Scaffold(
              appBar: AppBar(
                title: Text("เข้าสู่ระบบ"),
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("อีเมล", style: TextStyle(fontSize: 20)),
                            TextFormField(
                              validator: MultiValidator([
                                RequiredValidator(errorText: "กรุณาป้อนอีเมล"),
                                EmailValidator(
                                    errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                              ]),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (email) {
                                profile.email = email!;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text("รหัสผ่าน", style: TextStyle(fontSize: 20)),
                            TextFormField(
                              validator: RequiredValidator(
                                  errorText: "กรุณาป้อนรหัสผ่าน"),
                              obscureText: true,
                              onSaved: (password) {
                                profile.password = password!;
                              },
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  child: Text("ลงชื่อเข้าใช้",
                                      style: TextStyle(fontSize: 20)),
                                  onPressed: () async {
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
                                            return WelcomeScreen();
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
                            )
                          ],
                        ),
                      )),
                ),
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