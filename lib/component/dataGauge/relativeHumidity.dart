import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class relativeHumidity extends StatefulWidget {
  const relativeHumidity({super.key});
  _relativeHumidityState createState() => _relativeHumidityState();
}

class _relativeHumidityState extends State<relativeHumidity> {
  final TextEditingController _RHValue = TextEditingController();
  void initState() {
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.ref();

    ref
        .child('sensor/gauge/app/Relative_Humidity')
        .onValue
        .listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          final data = event.snapshot.value;
          _RHValue.text = data.toString();
          print("ค่าความชื้นสัมพัทธ์ = $data");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: SfRadialGauge(
              title: GaugeTitle(
                text: "ความชื้นสัมพัทธ์",
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              axes: <RadialAxis>[
                RadialAxis(
                  axisLineStyle: AxisLineStyle(
                      thickness: 20, cornerStyle: CornerStyle.bothCurve),
                  showTicks: true,
                  pointers: <GaugePointer>[
                    NeedlePointer(
                        enableAnimation: true,
                        value: double.tryParse(_RHValue.text) ?? 0.00,
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
                    RangePointer(
                        value: double.tryParse(_RHValue.text) ?? 0.00,
                        width: 20,
                        cornerStyle: CornerStyle.bothCurve,
                        enableAnimation: true,
                        color: Colors.orange)
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        angle: 90,
                        positionFactor: 1,
                        widget: Text(
                          _RHValue.text + '%',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
