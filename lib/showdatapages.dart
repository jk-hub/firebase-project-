import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseapp/mydata.dart';
import 'package:flutter/material.dart';

class ShowDataPage extends StatefulWidget {
  @override
  _ShowDataPageState createState() => _ShowDataPageState();
}

class _ShowDataPageState extends State<ShowDataPage> {
  List<MyData> allData = [];

  @override
  void initState() {
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('Message').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allData.clear();
      for (var key in keys) {
        MyData d = new MyData(
          data[key]['name'],
          data[key]['profession'],
          data[key]['mobile'],
          data[key]['age'],
          data[key]['email'],
          data[key]['message'],
        );
        allData.add(d);
      }
      setState(() {
        print('Length : ${allData.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Firebase Data'),
      ),
      body: new Container(
        child: allData.length == 0
            ? new Text(' No Data is Available')
            : new ListView.builder(
                itemCount: allData.length,
                itemBuilder: (_, index) {
                  return uI(
                    allData[index].name,
                    allData[index].profession,
                    allData[index].mobile,
                    allData[index].age,
                    allData[index].email,
                    allData[index].message,
                  );
                },
              ),
      ),
    );
  }

  Widget uI(String name, String profession, String mobile, String age,
      String email, String message) {
    return new Card(
      elevation: 10.0,
      child: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              'Name : $name',
              style: Theme.of(context).textTheme.title,
            ),
            new Text('Profession : $profession'),
            new Text('Mobile no : $mobile'),
            new Text('Age : $age'),
            new Text('email : $email'),
            new Text('Message : $message'),
          ],
        ),
      ),
    );
  }
}
