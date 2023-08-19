import 'package:appproject/component/LoadingScreen.dart';
import 'package:appproject/component/navigation.dart';
import 'package:appproject/component/textboxValvename.dart';
import 'package:appproject/component/textboxValvestatus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';

class WaterControlScreen extends StatefulWidget {
  const WaterControlScreen({super.key});

  @override
  State<WaterControlScreen> createState() => _WaterControlScreenState();
}

class _WaterControlScreenState extends State<WaterControlScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final TextEditingController switchValue = TextEditingController();
  bool? switchStatus;

  @override
  void initState() {
    super.initState();
    ref.child("Controls/waterValve/No1/Turn").onValue.listen((event) {
      final turnValue = event.snapshot.value;
      setState(() {
        switchStatus = (turnValue == "on");
        switchValue.text = turnValue.toString();
      });
    });
  }

  void changeStatus(bool value) {
    setState(() {
      switchStatus = value;
    });
  }

  @override
  void dispose() {
    switchValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (switchStatus == null) {
      return LoadingScreen();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("ควบคุมระบบน้ำ"),
        centerTitle: true,
      ),
      drawer: Navigation_Drawer(),
      backgroundColor: Color(0xFFE6E6E6),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Card(
          color: Color.fromARGB(255, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'วาล์วน้ำ',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 30),
                    child: ValveName()),
                Text(
                  'สถานะวาล์วน้ำ',
                  style: TextStyle(fontSize: 25),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 30),
                    child: StatusValve()),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 45, vertical: 50),
                  child: Container(
                    width: 300,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3), // สีเงา
                          spreadRadius: 3, // รัศมีการกระจายของเงา
                          blurRadius: 5, // รัศมีการกระจายของเงา
                          offset: Offset(0, 3), // ตำแหน่งเงา (x, y)
                        ),
                      ],
                    ),
                    child: SizedBox(
                        width: 300,
                        height: 70,
                        child: SlidingSwitch(
                          value: switchStatus!,
                          width: 285,
                          onChanged: changeStatus,
                          height: 70,
                          animationDuration: const Duration(milliseconds: 1),
                          onTap: () {
                            if (switchValue.text == "on") {
                              ref
                                  .child("Controls/waterValve/No1")
                                  .set({"Turn": "off", "Valve": "ปิด"});
                            } else if (switchValue.text == "off") {
                              ref
                                  .child("Controls/waterValve/No1")
                                  .set({"Turn": "on", "Valve": "เปิด"});
                            }
                          },
                          onDoubleTap: () {},
                          onSwipe: () {},
                          textOff: "OFF",
                          textOn: "ON",
                          contentSize: 20,
                          colorOn: Color.fromARGB(255, 0, 81, 255),
                          colorOff: Color.fromARGB(255, 255, 0, 17),
                          background: Color.fromARGB(255, 202, 202, 204),
                          buttonColor: const Color(0xfff7f5f7),
                          inactiveColor: const Color(0xff636f7b),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: InkWell(
                    child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.purple.shade300,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3), // สีเงา
                              spreadRadius: 3, // รัศมีการกระจายของเงา
                              blurRadius: 5, // รัศมีการกระจายของเงา
                              offset: Offset(0, 3), // ตำแหน่งเงา (x, y)
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "เปิด-ปิดวาล์ว อัตโนมัติ",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        )),
                    onTap: () {
                      if (switchValue.text == "auto") {
                        ref
                            .child("Controls/waterValve/No1")
                            .set({"Turn": "off", "Valve": "ปิด"});
                      } else {
                        ref
                            .child("Controls/waterValve/No1")
                            .set({"Turn": "auto", "Valve": "อัตโนมัติ"});
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
