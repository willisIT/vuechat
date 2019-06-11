import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:vuechat/login_page.dart';
import 'package:vuechat/root_page.dart';
import 'database.dart';
import 'auth.dart';



class CreateAccount extends StatefulWidget {

  CreateAccount({this.auth,});
  final BaseAuth auth;

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.greenAccent
      ),
      home: new CreatePageWidget(auth: Auth(),)
    );


  }

  
}

class CreatePageWidget extends StatefulWidget {
  CreatePageWidget({this.auth,});
  final BaseAuth auth;

  @override
  _CreatePageWidgetState createState() => _CreatePageWidgetState();
}

class _CreatePageWidgetState extends State<CreatePageWidget> {
  final _formKey = new  GlobalKey<FormState>();

  String _email;
  String _password;
  String _name;
  String _department;
  final database _db = new database();

  bool _isLoading = false;
  String _errorMessage;

  bool validateValues(){
    final form = _formKey.currentState;

    if(form.validate()){
      form.save();
     return true;
    }else{
      return false;
    }
  }

  void _validateAndSubmit() async{
    if(validateValues()){
      this.setState(() {
        _isLoading = true;
      });
      _errorMessage = "";

      try{
        String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
        try {
          if(userId.length > 0 && userId != null){
            _db.dbCreate(_name, _email, _department, userId);
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (context)=>RootPage(auth: Auth(),))
            );
          }
          
        } catch (e) {
          print(e);
          
        }
        
        print("User: $userId");
      }catch (e){
        print("Error: $e");
        setState(() {
          
         _errorMessage = e.message;
         print(_department);
          print(_name);
        });
      }
    }
  }

  void _googleSignIn() async{
    try{
        String userId = await widget.auth.googlesignin();
        try {
          if(userId.length > 0 && userId != null){
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(builder: (context)=>RootPage(auth: Auth(),))
            );
          }
          
        } catch (e) {
          print(e);
          
        }
        
        print("User: $userId");
      }catch (e){
        print("Error: $e");
        setState(() {
          _isLoading = false;
         _errorMessage = e.message;
         print(_department);
          print(_name);
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Create account"),
      ),
      body: Stack(
        children: <Widget>[
          _showBody(),
          _showCircularProgress(),
        ],
      )
    );
  }

  Widget _showNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        textCapitalization: TextCapitalization.words,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'eg. Paul Opata',
            labelText: 'Name*',
            icon: new Icon(Icons.person,),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            )),
        validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
        onSaved: (value) => _name = value,
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'eg. paulopata342@gmail.com',
            labelText: 'Email*',
            icon: new Icon(Icons.mail,),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Enter password',
            labelText: 'Password',
            icon: new Icon(Icons.lock,),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showDepartmentInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'eg. Computer Science',
            labelText: 'Department*',
            icon: new Icon(Icons.description,),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            )),
        validator: (value) => value.isEmpty ? 'Department can\'t be empty' : null,
        onSaved: (value) => _department = value,
      ),
    );
  }

  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: new MaterialButton(
                elevation: 5.0,
                minWidth: 200.0,
                height: 42.0,
                child:  new Text('SignUp',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
                color: Colors.green,
                onPressed: _validateAndSubmit,
        ));
  }

  Widget _showSecondaryButton() {
    return new FlatButton(
      child: new Text("'Have an account?Login'"),
      onPressed: (){Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context)=>LoginPage()));
      }
    );
  }

  Widget _textDivider(){
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: Text(
        "_____ Or connect with ____",
        style: TextStyle(color: Colors.green),
        
      ),
      ),
    );
  }

  Widget _otherSignButton(){
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FacebookSignInButton(
            text: "Facebook",
            onPressed: (){},
          ),
          GoogleSignInButton(
            text: "Google",
            onPressed: () {
              _googleSignIn();
            },
          )
        ],
      ),);
  }

  Widget _showErrorMessage() {
  if ( _errorMessage != null) {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      child: Text(
      _errorMessage,
      style: TextStyle(
          fontSize: 13.0,
          color: Colors.red,
          height: 1.0,
          fontWeight: FontWeight.w300),
    ),
    );
  } else {
    return new Container(
      height: 0.0,
    );
  }
}

  Widget _showCircularProgress(){
  if(_isLoading){
    return Center(
      child: CircularProgressIndicator(),
    );
  }return Container(height: 0.0, width: 0.0,);
}

  Widget _showBody(){
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showNameInput(),
              _showDepartmentInput(),
              _showEmailInput(),
              _showPasswordInput(),
              _showErrorMessage(),
              _showPrimaryButton(),
              _showSecondaryButton(),
              _textDivider(),
              _otherSignButton(),
            ],
          ),
        ));
  }
}