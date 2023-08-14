import 'package:appproject/component/LoadingScreen.dart';
import 'package:appproject/component/datatabledetail/noonTableDetail.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class noonTable extends StatefulWidget {
  const noonTable({super.key});

  @override
  State<noonTable> createState() => _noonTableState();
}

class _noonTableState extends State<noonTable> {
  final TextEditingController _Datetimenoon = TextEditingController();
  final TextEditingController _humiditynoon = TextEditingController();
  final TextEditingController _rhnoon = TextEditingController();
  final TextEditingController _tempnoon = TextEditingController();

  void initState() {
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.ref();

    ref
        .child('sensor/noon')
        .orderByKey()
        .limitToLast(1)
        .onValue
        .listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        final noonData = event.snapshot.value
            as Map<dynamic, dynamic>; // แปลงข้อมูลใน snapshot เป็น Map
        final noonlastKey = noonData.keys.first; // ดึง Unique Key ล่าสุด
        // วนลูปเช็คข้อมูลทุกตัวใน morningData
        noonData.forEach((key, value) {
          if (key == noonlastKey) {
            final datetimenoon = value["Datetime"];
            final humiditynoon = value["Humidity"];
            final rhnoon = value["Relative_Humidity"];
            final tempnoon = value["Temperature"];
            setState(() {
              print("ข้อมูลรายการที่: $noonData");
              _Datetimenoon.text = datetimenoon;
              _humiditynoon.text = humiditynoon.toString();
              _rhnoon.text = rhnoon.toString();
              _tempnoon.text = tempnoon.toString();
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _Datetimenoon.dispose();
    _humiditynoon.dispose();
    _rhnoon.dispose();
    _tempnoon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          // แสดงหน้าโหลด
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LoadingScreen();
          }));

          Future.delayed(Duration(seconds: 2), () {
            // Delay เป็นเวลา 2 วินาที
            Navigator.pop(context); // ปิดหน้าโหลด
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return noonTableDetail();
            }));
          });
        },
        child: Container(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'กลางวัน',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    _Datetimenoon.text + ' น.',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Table(
                    border:
                        TableBorder.all(color: Color.fromARGB(255, 0, 0, 0)),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: {
                      0: FlexColumnWidth(5),
                      1: FlexColumnWidth(5),
                      2: FlexColumnWidth(5),
                    },
                    children: [
                      const TableRow(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 126, 169)),
                          children: [
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'ความชื้นในดิน',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 8),
                                  child: Text(
                                    'ความชื้นสัมพัทธ์',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                            TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'อุณหภูมิ',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ))
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 208, 255, 155)),
                          children: [
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(child: Text(_humiditynoon.text)),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(child: Text(_rhnoon.text)),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(child: Text(_tempnoon.text)),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
