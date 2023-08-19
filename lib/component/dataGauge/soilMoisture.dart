import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class soilMoisture extends StatefulWidget {
  const soilMoisture({super.key});
  _soilMoistureState createState() => _soilMoistureState();
}

class _soilMoistureState extends State<soilMoisture> {
  final TextEditingController _DatetimeValue = TextEditingController();
  final TextEditingController _HumidityValue = TextEditingController();

  void initState() {
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.ref();

    ref.child("sensor/gauge/app").onValue.listen((DatabaseEvent event) {
      Map<dynamic, dynamic> values =
          event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        final datetime = values["Datetime"];
        final humidity = values["Humidity"];
        _DatetimeValue.text = datetime;
        _HumidityValue.text = humidity.toString();
        print("วันที่: $datetime");
        print("ค่าความชื้นในดิน: $humidity");
      });
    });
  }

  @override
  void dispose() {
    _DatetimeValue.dispose();
    _HumidityValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      body: Center(
          child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 70, bottom: 5, left: 10, right: 10),
            child: Text(
              "ความชื้นในดิน",
              style: TextStyle(
                fontSize: 25,
                //fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 50, left: 10, right: 10),
            child: Text(
              _DatetimeValue.text + " น.",
              style: TextStyle(
                fontSize: 25,
                //fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                axisLineStyle: AxisLineStyle(
                    thickness: 20, cornerStyle: CornerStyle.bothCurve),
                showTicks: true,
                ranges: [
                  GaugeRange(
                    startValue: 0,
                    endValue: 70,
                    color: Colors.orange,
                    startWidth: 20,
                    endWidth: 20,
                  ),
                  GaugeRange(
                      startValue: 70,
                      endValue: 90,
                      color: Colors.green,
                      startWidth: 20,
                      endWidth: 20),
                  GaugeRange(
                      startValue: 90,
                      endValue: 100,
                      color: Colors.blue.shade900,
                      startWidth: 20,
                      endWidth: 20)
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(
                      enableAnimation: true,
                      value: double.tryParse(_HumidityValue.text) ?? 0.00,
                      lengthUnit: GaugeSizeUnit.factor,
                      needleLength: 0.6,
                      needleEndWidth: 9,
                      gradient: const LinearGradient(colors: <Color>[
                        Color(0xFFFF6B78),
                        Color(0xFFFF6B78),
                        Color(0xFFE20A22),
                        Color(0xFFE20A22)
                      ], stops: <double>[
                        0,
                        0.5,
                        0.5,
                        1
                      ]),
                      needleColor: Color(0xFFF67280),
                      knobStyle: KnobStyle(
                          knobRadius: 0.08,
                          sizeUnit: GaugeSizeUnit.factor,
                          color: Colors.black)),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    angle: 90,
                    positionFactor: 1,
                    widget: Text(
                      _HumidityValue.text + '%',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      )),
    );
  }
}
