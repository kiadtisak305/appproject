import 'package:appproject/screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  //const WelcomeScreen({super.key});
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ยินดีต้อนรับ"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              Text(auth.currentUser!.displayName.toString(),
                  style: TextStyle(fontSize: 25)),
              Text(auth.currentUser!.email.toString(),
                  style: TextStyle(fontSize: 25)),
              
              ElevatedButton(
                  child: Text("ออกจากระบบ"),
                  onPressed: () {
                    auth.signOut().then((value) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeScreen();
                      }));
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
