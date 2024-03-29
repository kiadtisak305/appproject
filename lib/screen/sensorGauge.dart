import 'package:appproject/component/dataGauge/relativeHumidity.dart';
import 'package:appproject/component/dataGauge/soilMoisture.dart';
import 'package:appproject/component/dataGauge/temperature.dart';
import 'package:appproject/component/navigation.dart';
import 'package:flutter/material.dart';

class sensorGaugeScreen extends StatefulWidget {
  const sensorGaugeScreen({super.key});

  _sensorGaugeScreenState createState() => _sensorGaugeScreenState();
}

class _sensorGaugeScreenState extends State<sensorGaugeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navigation_Drawer(),
      appBar: AppBar(
        title: Text('มาตรวัดเซนเซอร์'),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFE6E6E6),
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 450,
              child: Card(
                child: const soilMoisture(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 450,
              child: Card(child: const temperature()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 450,
              child: Card(child: const relativeHumidity()),
            ),
          ),
        ],
      ),
    );
  }
}
