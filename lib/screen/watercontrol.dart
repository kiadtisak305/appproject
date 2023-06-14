import 'package:appproject/screen/navigation.dart';
import 'package:appproject/screen/textboxValvename.dart';
import 'package:appproject/screen/textboxValvestatus.dart';
import 'package:appproject/screen/valvestatus.dart';
import 'package:flutter/material.dart';

class WaterControlScreen extends StatelessWidget {
  const WaterControlScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("ควบคุมระบบน้ำ"),
          centerTitle: true,
        ),
        drawer: Navigation_Drawer(),
        backgroundColor: Color(0xFFE6E6E6),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'วาล์วน้ำ',
                  style: TextStyle(fontSize: 25),
                ),
                Padding(padding: const EdgeInsets.all(30), child: ValveName()),
                Text(
                  'สถานะวาล์วน้ำ',
                  style: TextStyle(fontSize: 25),
                ),
                Padding(
                    padding: const EdgeInsets.all(30), child: StatusValve()),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ChangingButton()),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      child: Text(
                        "เปิด-ปิดวาล์ว ตามตาราง",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Colors.purple.shade300)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
