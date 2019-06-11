import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class database{
  final Firestore _firestore = Firestore.instance;
  SharedPreferences _prefs;

  void dbCreate(_name, _email, _department, userId) async{
    _prefs = await SharedPreferences.getInstance();
        _firestore.collection('users').document(userId).setData(
          {'name': _name, 'email': _email, 'department': _department, 'id': userId});
          print('done');

          await _prefs.setString('id', userId);
          await _prefs.setString('email', _email);
          await _prefs.setString('department', _department);
          await _prefs.setString('name', _name);
  }
  void dbLogin(userId) async{
    QuerySnapshot result = await _firestore.collection('users').where('id', isEqualTo: userId).getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    print(documents);

      await _prefs.setString('id', documents[0]['id']);
      await _prefs.setString('name', documents[0]['name']);
      await _prefs.setString('email', documents[0]['email']);
      await _prefs.setString('department', documents[0]['department']);

      print('id' + _prefs.getString('id') + '/n/n' +
      'name' + _prefs.getString('name')+ '/n/n' +
      'email' + _prefs.getString('email')+ '/n/n' +
      'department' + _prefs.getString('department'));
  }
}