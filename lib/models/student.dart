import 'package:firebase_database/firebase_database.dart';

class Student {
  String fName;
  String surName;
  String key;

  Student({this.key, this.fName, this.surName});

  Student.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        fName = snapshot.value["fname"],
        surName = snapshot.value["surName"];

  toJson() {
    return {
      "fname": fName,
      "surName": surName,
    };
  }
}
