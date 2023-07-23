import 'package:appproject/dataGauge/relativeHumidity.dart';
import 'package:appproject/dataGauge/soilMoisture.dart';
import 'package:appproject/dataGauge/temperature.dart';
import 'package:appproject/screen/navigation.dart';
import 'package:flutter/material.dart';

class sensorGaugeScreen extends StatelessWidget {
  const sensorGaugeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navigation_Drawer(),
      appBar: AppBar(
        title: Text('มาตรวัดเซนเซอร์'),
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
                  height: 450,
                  child: Card(
                    child: const soilMoisture(),
                    color: Colors.pink.shade200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 450,
                  child: Card(child: const relativeHumidity()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 450,
                  child: Card(child: const temperature()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
