import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ValveName extends StatefulWidget {
  @override
  _ValveNameState createState() => _ValveNameState();
}

class _ValveNameState extends State<ValveName> {
  final TextEditingController _textEditingController = TextEditingController();
  void initState() {
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.ref();

    ref.child('Controls/waterValve').onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          final data = event.snapshot.value;
          print("ข้อมูลส่วน No1 = $data");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: _textEditingController.text,
        hintStyle: TextStyle(fontSize: 20),
      ),
    );
  }
}
