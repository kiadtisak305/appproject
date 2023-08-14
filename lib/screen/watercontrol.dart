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
        padding: const EdgeInsets.all(23),
        child: Card(
          color: Color.fromARGB(255, 253, 175, 201),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'วาล์วน้ำ',
                  style: TextStyle(fontSize: 25),
                ),
                Padding(padding: const EdgeInsets.all(30), child: ValveName()),
                Text(
                  'สถานะวาล์วน้ำ',
                  style: TextStyle(fontSize: 25),
                ),
                Padding(
                    padding: const EdgeInsets.all(30), child: StatusValve()),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: SlidingSwitch(
                        value: switchStatus!,
                        width: 290,
                        onChanged: changeStatus,
                        height: 50,
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
                        colorOn: const Color(0xff6682c0),
                        colorOff: const Color(0xffdc6c73),
                        background: const Color(0xffe4e5eb),
                        buttonColor: const Color(0xfff7f5f7),
                        inactiveColor: const Color(0xff636f7b),
                      )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      child: Text(
                        "เปิด-ปิดวาล์ว อัตโนมัติ",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
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
      ),
    );
  }
}
