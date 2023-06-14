import 'package:appproject/datatable/eveningTable.dart';
import 'package:appproject/datatable/morningTable.dart';
import 'package:appproject/datatable/noonTable.dart';
import 'package:appproject/screen/navigation.dart';
import 'package:flutter/material.dart';

class SensorScreen extends StatelessWidget {
  const SensorScreen({super.key});

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
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 400,
                  child: Card(child: const morningTable()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 400,
                  child: Card(child: const noonTable()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 400,
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
