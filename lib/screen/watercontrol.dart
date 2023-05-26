import 'package:appproject/screen/login.dart';
import 'package:appproject/screen/sensor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WaterControlScreen extends StatelessWidget {
  const WaterControlScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("ควบคุมระบบน้ำ"),
          centerTitle: true,
        ),
        drawer: NavigationDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'วาล์วน้ำ',
                  style: TextStyle(fontSize: 25),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: TextField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "No.1",
                      hintStyle: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Text(
                  'สถานะวาล์วน้ำ',
                  style: TextStyle(fontSize: 25),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: TextField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "ปิด",
                      hintStyle: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      child: Text(
                        "เปิดวาล์ว",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Colors.green.shade500)),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      child: Text(
                        "เปิด-ปิดวาล์ว ตามตาราง",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Colors.purple.shade300)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({super.key});
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
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtI0qyw0VkvP2ArwuFBeVSdhVyR_nttyEcmQ&usqp=CAU'),
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
