import 'package:appproject/app/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../app/data/model/profile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(username: '', email: '', password: '');

  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(
                      color: theme.brightness == Brightness.light ? Colors.black : Colors.white,
                      width: 2,
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(
                      color: theme.brightness == Brightness.light ? Colors.black : Colors.white,
                      width: 2,
                    )
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(
                      color: Color(0xffd01716),
                      width: 2,
                    )
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(
                      color: Color(0xffd01716),
                      width: 2,
                    )
                  ),
                  hintText: "E-mail",
                  hintStyle: const TextStyle(fontSize: 16),
                  
              ),
              cursorColor: Colors.black,
              validator: MultiValidator([
                RequiredValidator(errorText: "กรุณาป้อนอีเมล"),
                EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
              ]),
              keyboardType: TextInputType.emailAddress,
              onSaved: (email) {
                profile.email = email!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(
                      color: theme.brightness == Brightness.light ? Colors.black : Colors.white,
                      width: 2,
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(
                      color: theme.brightness == Brightness.light ? Colors.black : Colors.white,
                      width: 2,
                    )
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(
                      color: Color(0xffd01716),
                      width: 2,
                    )
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(
                      color: Color(0xffd01716),
                      width: 2,
                    )
                  ),
                  hintText: "Password",
                  hintStyle: const TextStyle(fontSize: 16),
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
                  cursorColor: Colors.black,
              validator:
                  RequiredValidator(errorText: "กรุณาป้อนรหัสผ่าน"),
              obscureText: _isHidden,
              onSaved: (password) {
                profile.password = password!;
              },
            ),
            //------------------------------------------ login btn -----------------------------------------------------------------------
            InkWell(
                child: Container(
                  width: 200,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xffec407a)),
                  child: const Center(
                    child: Text(
                      "เข้าสู่ระบบ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    print(
                        "email = ${profile.email} password = ${profile.password}");
                    FirebaseServices().login(email: profile.email, password: profile.password);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
