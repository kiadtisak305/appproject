import 'package:appproject/component/datatable/eveningTable.dart';
import 'package:appproject/component/datatable/morningTable.dart';
import 'package:appproject/component/datatable/noonTable.dart';
import 'package:appproject/component/navigation.dart';
import 'package:flutter/material.dart';

class SensorScreen extends StatefulWidget {
  const SensorScreen({super.key});

  _SensorScreenState createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navigation_Drawer(),
      appBar: AppBar(
        title: Text('ข้อมูลเซ็นเซอร์'),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFE6E6E6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 250,
                  child: Card(child: const morningTable()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 250,
                  child: Card(child: const noonTable()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 250,
                  child: Card(child: const eveningTable()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
