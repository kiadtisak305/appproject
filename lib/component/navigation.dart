import 'package:appproject/component/LoadingScreen.dart';
import 'package:appproject/screen/login.dart';
import 'package:appproject/screen/sensor.dart';
import 'package:appproject/screen/sensorGauge.dart';
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
      color: Colors.pink,
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
                leading: Icon(Icons.water_drop, size: 30, color: Colors.black),
                title: Text('ควบคุมระบบน้ำ',
                    style: TextStyle(fontSize: 18, color: Colors.black)),
                onTap: () {
                  // แสดงหน้าโหลด
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoadingScreen();
                  }));

                  Future.delayed(Duration(seconds: 2), () {
                    // Delay เป็นเวลา 2 วินาที
                    Navigator.pop(context); // ปิดหน้าโหลด
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return WaterControlScreen();
                    }));
                  });
                }),
            ListTile(
                leading: Icon(Icons.sensors, size: 30, color: Colors.black),
                title: Text('ข้อมูลเซนเซอร์',
                    style: TextStyle(fontSize: 18, color: Colors.black)),
                onTap: () {
                  // แสดงหน้าโหลด
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoadingScreen();
                  }));

                  Future.delayed(Duration(seconds: 2), () {
                    // Delay เป็นเวลา 2 วินาที
                    Navigator.pop(context); // ปิดหน้าโหลด
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return SensorScreen();
                    }));
                  });
                }),
            ListTile(
                leading:
                    Icon(Icons.speed_rounded, size: 30, color: Colors.black),
                title: Text('มาตรวัดเซนเซอร์',
                    style: TextStyle(fontSize: 18, color: Colors.black)),
                onTap: () {
                  // แสดงหน้าโหลด
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoadingScreen();
                  }));

                  Future.delayed(Duration(seconds: 2), () {
                    // Delay เป็นเวลา 2 วินาที
                    Navigator.pop(context); // ปิดหน้าโหลด
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return sensorGaugeScreen();
                    }));
                  });
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('ยืนยันการออกจากระบบ'),
                      content: Text('คุณต้องการออกจากระบบใช่หรือไม่?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // ปิดDialog
                          },
                          child: Text('ยกเลิก'),
                        ),
                        TextButton(
                          onPressed: () {
                            // แสดงหน้าโหลด
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LoadingScreen();
                            }));
                            // Delay เป็นเวลา 2 วินาที
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.pop(context); // ปิดหน้าโหลด
                              AllsignOut();
                              auth.signOut();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginScreen();
                              }));
                            });
                          },
                          child: Text('ยืนยัน'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      );
}
