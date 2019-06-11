import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vuechat/message_page.dart';
import 'package:vuechat/pdf/pdf_main.dart';
import 'package:vuechat/profile_page.dart';
import 'package:vuechat/quiz/quiz_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth.dart';




class MainPage extends StatefulWidget {
  MainPage({this.auth, this.onSignOut});
  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  void initState(){
    super.initState();
  }

  bool _isLoading = true;
  void _signOut() async{
    try {
      await widget.auth.signOut();
      widget.onSignOut();
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.message);
    }
    this.setState((){
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(
        title: new Text("Main Page"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.message),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MessagePage()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              Fluttertoast.showToast(
                msg: "You clicked on search"
              );
            },
          ),
          _popMenuButton(),
        ],
      ),
      body: Center(child: new Text("Main Page Under Construction"),),
      drawer: Drawer(
        child: _appBarListButton(),
      ),
      
      
    );
  }

  Widget _appBarListButton(){
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("User Name"),
          accountEmail: Text("User.name@gmail.com"),
          currentAccountPicture: CircleAvatar(
            child: FlutterLogo(size: 42.0),
            backgroundColor: Colors.white,
          ),
        ),
        ListTile(
          leading: Icon(Icons.message),
          title: Text("Message"),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MessagePage())
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.people),
          title: Text("Friends"),
          onTap: (){
            Fluttertoast.showToast(
              msg: "Clicked"
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.face),
          title: Text("Profile"),
          onTap: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) =>ProfilePage())
              );

          },
        ),
        ListTile(
          leading: Icon(Icons.book),
          title: Text("PDFs"),
          onTap: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) =>PdfsMainPage())
              );
              
          },
        ),
        ListTile(
          leading: Icon(Icons.question_answer),
          title: Text("Quiz"),
          onTap: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) =>QuizMainPage())
              );
              
          },
        ),
        ListTile(
          leading: Icon(Icons.format_paint),
          title: Text("Logout"),
          onTap: (){
            _showDialog();
          },
        )
      ],
    );
  }

  Widget _showCircularProgress(){
  if(_isLoading){
    return Center(
      child: CircularProgressIndicator(),
    );
  }return Container(height: 0.0, width: 0.0,);
}

  void _showDialog(){
    showDialog<String>(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Logout'),
          content: Text("Do you want to logout?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Logout"),
              onPressed: () {
                Navigator.pop(context, 'OK');
              },
            ),
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: ()=>Navigator.pop(context, 'Cancel'),
            ),
          ],
        );
      }
    ).then<String>((returnVal){
      if (returnVal == 'OK') {
        _showCircularProgress();
        _signOut();  
      }
    });
  }

  Widget _popMenuButton(){
    return  PopupMenuButton<popList>(
      onSelected: (popList result){setState(() {
       if(popList.Account == result){
         Fluttertoast.showToast(msg: "Account Settings");
       } 
       if(popList.User == result){
         Fluttertoast.showToast(msg: "User");
       }
       if(popList.Logout == result){
         _showDialog();
       }
      });},

      itemBuilder: (BuildContext context) => <PopupMenuEntry<popList>>[
        const PopupMenuItem<popList>(
          value: popList.Account,
          child: Text('Account setting'),
        ),
        const PopupMenuItem<popList>(
          value: popList.User,
          child: Text('User'),
        ),
        const PopupMenuItem<popList>(
          value: popList.Logout,
          child: Text('Logout'),
        ),
  ],
    );
  }
  
}
enum popList{
  Account,User,Logout
}