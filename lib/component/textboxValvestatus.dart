import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class StatusValve extends StatefulWidget {
  @override
  _StatusValveState createState() => _StatusValveState();
}

class _StatusValveState extends State<StatusValve> {
  final TextEditingController _textEditingController = TextEditingController();
  void initState() {
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.ref();

    ref
        .child('Controls/waterValve/No1/Valve')
        .onValue
        .listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          final data = event.snapshot.value;
          _textEditingController.text = data.toString();
          print("สถานะวาว์ล = $data");
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
