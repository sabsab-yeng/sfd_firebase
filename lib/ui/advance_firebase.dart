import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sdf_firebase/models/student.dart';

class AdvanceFirebasePage extends StatefulWidget {
  @override
  _AdvanceFirebasePageState createState() => _AdvanceFirebasePageState();
}

class _AdvanceFirebasePageState extends State<AdvanceFirebasePage> {
  final FirebaseDatabase database = FirebaseDatabase.instance;

  List<Student> listStudent = List();
  Student student;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();
    student = Student();

    databaseReference = database.reference().child("table_student");
    databaseReference.onChildAdded.listen(_onEntyAdd);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advance Page"),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 0,
            child: Form(
              key: formKey,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) => student.fName = val,
                      validator: (val) => val == " " ? val : null,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.label),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) => student.surName = val,
                      validator: (val) => val == " " ? val : null,
                    ),
                  ),
                  RaisedButton(
                    color: Colors.redAccent,
                    child: Text("Post"),
                    onPressed: () {
                      handlePost();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onEntyAdd(Event event) {
    setState(() {
      listStudent.add(Student.fromSnapshot(event.snapshot));
    });
  }

  void handlePost() {
    final FormState form = formKey.currentState;
    if(form.validate()){
      form.save();
      form.reset();

      //Save data to database
      databaseReference.push().set(student.toJson());
    }
  }
}
