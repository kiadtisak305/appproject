import 'package:appproject/screen/login.dart';
import 'package:appproject/screen/register.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register/Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: SingleChildScrollView(
          child: Column(children: [
            //Image.asset("assets/images/ชื่อไฟล์"),                                 //รูปภาพ
            SizedBox(
              width: double.infinity,                                             //ขนาดปุ่ม
              child: ElevatedButton.icon(
                icon: Icon(Icons.add),                                            //ไอคอน
                label: Text(                                                      //ชื่อปุ่ม
                  "สร้างบัญชีผู้ใช้", 
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {                                                   //อีเว้นหลังจากกดปุ่ม
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return RegisterScreen();
                  }));
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(Icons.login),
                label: Text(
                  "เข้าสู่ระบบ",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
