import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name;
  String department;
  String email;
  SharedPreferences _prefs;
  final BaseAuth auth = Auth();
  Future<String> currentUser;

  void sharePrefrences() async{
    this._prefs =  await SharedPreferences.getInstance();
    this.name = _prefs.getString('name');
    this.department = _prefs.getString('department');
    this.email = _prefs.getString('email');

    print('id' + _prefs.getString('id') + '/n/n' +
      'name' + _prefs.getString('name')+ '/n/n' +
      'email' + _prefs.getString('email')+ '/n/n' +
      'department' + _prefs.getString('department'));
  }

  @override
  void initState() {
    super.initState();
    sharePrefrences();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Container(
          child: StreamBuilder(
            stream: Firestore.instance.collection('users').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                ),
              );}else{
                return new ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (context, index) => buildItem(context, snapshot.data.documents[index]),
                  itemCount: snapshot.data.documents.length,
                );
              }
            }
          )
        )
      )
    );
  }
  Widget buildItem(BuildContext context, DocumentSnapshot document){
    if(document['id'] == currentUser){
      return Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                'Name: ${document['name']}',
              ),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
            ),
            Container(
              child: Text(
                'Name: ${document['email']}',
              ),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
            ),
            Container(
              child: Text(
                'Name: ${document['department']}',
              ),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
            ),
          ],
        ),
      );
      
    }
  }
}