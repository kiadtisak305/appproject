import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class eveningTableDetail extends StatefulWidget {
  const eveningTableDetail({super.key});
  @override
  State<eveningTableDetail> createState() => _eveningTableDetailState();
}

class _eveningTableDetailState extends State<eveningTableDetail> {
  List<TableRow> _tableRows = [];
  void initState() {
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.ref();

    ref.child('sensor/evening').onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        final eveningData = event.snapshot.value as Map<dynamic, dynamic>;

        List<TableRow> tableRows = [];

        eveningData.forEach((key, value) {
          final datetime = value["Datetime"];
          final humidity = value["Humidity"];
          final rh = value["Relative_Humidity"];
          final temp = value["Temperature"];

          TableRow tableRow = TableRow(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 208, 255, 155),
            ),
            children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text(datetime.substring(0, 10))),
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text(humidity.toString())),
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text(rh.toString())),
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text(temp.toString())),
                ),
              ),
            ],
          );
          tableRows.add(tableRow);
        });

        setState(() {
          _tableRows = tableRows; // อัปเดตตาราง
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เย็น'),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFE6E6E6),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Container(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                // ใส่ส่วนหัวของตารางที่ไม่เลื่อน
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Table(
                    border:
                        TableBorder.all(color: Color.fromARGB(255, 0, 0, 0)),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: {
                      0: FlexColumnWidth(5),
                      1: FlexColumnWidth(5),
                      2: FlexColumnWidth(5),
                      3: FlexColumnWidth(5),
                    },
                    children: [
                      const TableRow(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 126, 169),
                        ),
                        children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'วันที่',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Text(
                                'ความชื้นในดิน',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Text(
                                'ความชื้นสัมพัทธ์',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
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
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 1),
                      child: Table(
                        border: TableBorder.all(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        // ... ส่วนอื่น ๆ ของตาราง
                        children: [
                          ..._tableRows,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
