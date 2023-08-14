import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';

class ChangingButton extends StatefulWidget {
  @override
  _ChangingButtonState createState() => _ChangingButtonState();
}

class _ChangingButtonState extends State<ChangingButton> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  void changeStatus(bool value) {
    if (value == false) {
      setState(() {
        OffStatus();
      });
    } else {
      setState(() {
        OnStatus();
      });
    }
  }

  void OnStatus() {
    DatabaseReference newRef = ref.child("Controls/waterValve/No1/Turn").push();
    String? uniqueKey = newRef.key;
    ref.child("Controls/waterValve/No1").set({
      "Turn": {uniqueKey: "on"},
      "Valve": "on"
    });
    print('Generated Unique Key: $uniqueKey : "on"');
  }

  void OffStatus() {
    DatabaseReference newRef = ref.child("Controls/waterValve/No1/Turn").push();
    String? uniqueKey = newRef.key;
    ref.child("Controls/waterValve/No1").set({
      "Turn": {uniqueKey: "off"},
      "Valve": "off"
    });
    print('Generated Unique Key: $uniqueKey : "off"');
  }

  @override
  Widget build(BuildContext context) {
    return SlidingSwitch(
      value: false,
      width: 290,
      onChanged: changeStatus,
      height: 50,
      animationDuration: const Duration(milliseconds: 400),
      onTap: () {},
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
