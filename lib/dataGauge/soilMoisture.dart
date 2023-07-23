import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class soilMoisture extends StatelessWidget {
  const soilMoisture({super.key});

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
                text: "ความชื้นในดิน",
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
                        value: 70,
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
                          '70.0%',
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
