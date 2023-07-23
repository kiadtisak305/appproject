/* import 'package:appproject/screen/navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddValveScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  String valveName = '';
  String userId = '';
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เพิ่มวาว์ลน้ำ"),
        centerTitle: true,
      ),
      drawer: Navigation_Drawer(),
      backgroundColor: Color(0xFFE6E6E6),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Center(
            child: ListView(
              children: [
                Card(
                  child: ListTile(
                    title: Text('One-line with trailing widget'),
                    trailing: Icon(Icons.more_vert),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('ลงทะเบียนวาว์ลใหม่'),
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: auth.currentUser!.email.toString(),
                          ),
                          onSaved: (userId) {
                            userId = userId!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            hintText: 'ชื่อวาว์ล',
                          ),
                          onSaved: (valveName) {
                            valveName = valveName!;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                      child: Text('Save'),
                      onPressed: () {
                        addUser();
                      }),
                  ElevatedButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Future<void> addUser() async {
    // Create a map of data to be added
    Map<String, dynamic> addData = {
      userId: '',
      valveName: '',
    };

    // Add the data to Firestore
    db.collection("valveName").add(addData).then((documentSnapshot) =>
        print("Added Data with ID: ${documentSnapshot.id}"));
  }
}
 */