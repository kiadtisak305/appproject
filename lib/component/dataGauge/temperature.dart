import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class temperature extends StatefulWidget {
  const temperature({super.key});
  _temperatureState createState() => _temperatureState();
}

class _temperatureState extends State<temperature> {
  final TextEditingController _TempValue = TextEditingController();
  void initState() {
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.ref();

    ref
        .child('sensor/gauge/app/Temperature')
        .onValue
        .listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          final data = event.snapshot.value;
          _TempValue.text = data.toString();
          print("อุณหภูมิ = $data");
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
                text: "อุณหภูมิ",
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: -30,
                  maximum: 50,
                  interval: 10,
                  ticksPosition: ElementsPosition.outside,
                  labelsPosition: ElementsPosition.outside,
                  minorTicksPerInterval: 4,
                  radiusFactor: 0.9,
                  labelOffset: 10,
                  tickOffset: 2,
                  minorTickStyle: MinorTickStyle(
                      thickness: 1.5,
                      color: Color.fromARGB(255, 0, 0, 0),
                      length: 0.075,
                      lengthUnit: GaugeSizeUnit.factor),
                  majorTickStyle: MinorTickStyle(
                    thickness: 1.5,
                    color: Color.fromARGB(255, 0, 0, 0),
                    length: 0.15,
                    lengthUnit: GaugeSizeUnit.factor,
                  ),
                  axisLineStyle: AxisLineStyle(
                    thickness: 3,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  axisLabelStyle: GaugeTextStyle(
                    fontSize: 11,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  ranges: [
                    GaugeRange(
                      rangeOffset: 7,
                      startValue: -30,
                      endValue: 18,
                      color: Colors.blue.shade400,
                      startWidth: 20,
                      endWidth: 20,
                    ),
                    GaugeRange(
                        rangeOffset: 7,
                        startValue: 18.5,
                        endValue: 25,
                        color: Colors.green.shade600,
                        startWidth: 20,
                        endWidth: 20),
                    GaugeRange(
                        rangeOffset: 7,
                        startValue: 25.5,
                        endValue: 50,
                        color: Colors.orange.shade700,
                        startWidth: 20,
                        endWidth: 20)
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                        enableAnimation: true,
                        value: double.tryParse(_TempValue.text) ?? 0.00,
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
                          _TempValue.text + '°C',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
