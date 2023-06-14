import 'package:appproject/screen/addvalve.dart';
import 'package:appproject/screen/login.dart';
import 'package:appproject/screen/sensor.dart';
import 'package:appproject/screen/watercontrol.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Navigation_Drawer extends StatelessWidget {
  void AllsignOut() async {
    await GoogleSignIn().signOut();
  }

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Material(
      color: Colors.blue.shade700,
      child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.only(
                top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 52,
                  backgroundImage:
                      NetworkImage(auth.currentUser!.photoURL ?? ''),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(auth.currentUser!.displayName.toString(),
                    style: TextStyle(fontSize: 25, color: Colors.white)),
                Text(auth.currentUser!.email.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
          )));

  Widget buildMenuItems(BuildContext context) => Container(
        padding: EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
                leading: Icon(Icons.add_circle, size: 30, color: Colors.black),
                title: Text('เพิ่มวาว์ลน้ำ',
                    style: TextStyle(fontSize: 18, color: Colors.black)),
                onTap: () =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => AddValveScreen(),
                    ))),
            ListTile(
                leading: Icon(Icons.water_drop, size: 30, color: Colors.black),
                title: Text('ควบคุมระบบน้ำ',
                    style: TextStyle(fontSize: 18, color: Colors.black)),
                onTap: () =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const WaterControlScreen(),
                    ))),
            ListTile(
                leading: Icon(Icons.sensors, size: 30, color: Colors.black),
                title: Text('ข้อมูลเซ็นเซอร์',
                    style: TextStyle(fontSize: 18, color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SensorScreen(),
                  ));
                }),
            Divider(
              color: Colors.black54,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                size: 30,
                color: Colors.red.shade900,
              ),
              title: Text(
                'ออกจากระบบ',
                style: TextStyle(fontSize: 18, color: Colors.red.shade900),
              ),
              onTap: () {
                AllsignOut();
                auth.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
            ),
          ],
        ),
      );
}
