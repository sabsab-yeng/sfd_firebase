import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class BasicFirebasePage extends StatefulWidget {

  @override
  _BasicFirebasePageState createState() => _BasicFirebasePageState();
}

class _BasicFirebasePageState extends State<BasicFirebasePage> {

  final FirebaseDatabase database = FirebaseDatabase.instance;

  void _incrementCounter() {
    database.reference().child("sfDB").set({
      "First name" : "Sabsab Flutter Development Loas",
      "Last naem" : "IOS",
      "age" : 23
    });
    setState(() {
      database.reference().child("sfDB").once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> data = snapshot.value;
        print("Value: ${snapshot.value}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basic Page"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
