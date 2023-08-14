import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class morningTable extends StatefulWidget {
  const morningTable({super.key});

  @override
  State<morningTable> createState() => _morningTableState();
}

class _morningTableState extends State<morningTable> {
  String _DatetimeValue = "";
  int _humidity = 0;
  double _rh = 0.0;
  double _temp = 0.0;

  void initState() {
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.ref();

    ref
        .child('sensor/morning')
        .orderByKey()
        .limitToLast(1)
        .onValue
        .listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        final morningData = event.snapshot.value
            as Map<dynamic, dynamic>; // แปลงข้อมูลใน snapshot เป็น Map
        final latestKey = morningData.keys.first; // ดึง Unique Key ล่าสุด
        // วนลูปเช็คข้อมูลทุกตัวใน morningData
        morningData.forEach((key, value) {
          if (key == latestKey) {
            final datetime = value["Datetime"];
            final humidity = value["Humidity"];
            final rh = value["Relative_Humidity"];
            final temp = value["Temperature"];
            setState(() {
              print("ข้อมูลรายการที่: $morningData");
              _DatetimeValue = datetime;
              _humidity = humidity;
              _rh = rh;
              _temp = temp;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'เช้า',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                _DatetimeValue + ' น.',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Table(
                border: TableBorder.all(color: Colors.white30),
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
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: Text(_humidity.toString())),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: Text(_rh.toString())),
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: Text(_temp.toString())),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
