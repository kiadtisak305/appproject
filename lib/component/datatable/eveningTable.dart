import 'package:appproject/component/LoadingScreen.dart';
import 'package:appproject/component/datatabledetail/eveningTableDetail.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class eveningTable extends StatefulWidget {
  const eveningTable({super.key});

  @override
  State<eveningTable> createState() => _eveningTableState();
}

class _eveningTableState extends State<eveningTable> {
  final TextEditingController _Datetimeevening = TextEditingController();
  final TextEditingController _humidityevening = TextEditingController();
  final TextEditingController _rhevening = TextEditingController();
  final TextEditingController _tempevening = TextEditingController();

  void initState() {
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.ref();

    ref
        .child('sensor/evening')
        .orderByKey()
        .limitToLast(1)
        .onValue
        .listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        final eveningData = event.snapshot.value
            as Map<dynamic, dynamic>; // แปลงข้อมูลใน snapshot เป็น Map
        final latestKey = eveningData.keys.first; // ดึง Unique Key ล่าสุด
        // วนลูปเช็คข้อมูลทุกตัวใน morningData
        eveningData.forEach((key, value) {
          if (key == latestKey) {
            final datetime = value["Datetime"];
            final humidity = value["Humidity"];
            final rh = value["Relative_Humidity"];
            final temp = value["Temperature"];
            setState(() {
              print("ข้อมูลรายการที่: $eveningData");
              _Datetimeevening.text = datetime;
              _humidityevening.text = humidity.toString();
              _rhevening.text = rh.toString();
              _tempevening.text = temp.toString();
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _Datetimeevening.dispose();
    _humidityevening.dispose();
    _rhevening.dispose();
    _tempevening.dispose();
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
              return eveningTableDetail();
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
                    'เย็น',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    _Datetimeevening.text + ' น.',
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
                                child:
                                    Center(child: Text(_humidityevening.text)),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(child: Text(_rhevening.text)),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(child: Text(_tempevening.text)),
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
