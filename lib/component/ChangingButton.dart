import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';

class ChangingButton extends StatefulWidget {
  @override
  _ChangingButtonState createState() => _ChangingButtonState();
}

class _ChangingButtonState extends State<ChangingButton> {
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
      // Return a loading indicator or any other content while switchStatus is null
      return CircularProgressIndicator();
    }
    return SlidingSwitch(
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
    );
  }
}
