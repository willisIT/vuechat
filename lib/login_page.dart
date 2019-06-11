import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:vuechat/createaccount_page.dart';
import 'auth.dart';
import 'database.dart';


class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = new  GlobalKey<FormState>();

  bool _isLoading = false;
  String _errorMessage;
  String _email;
  String _password;
  final database _db = new database();

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
        String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
        print("User: $userId");
        if(userId.length > 0 && userId != null){
          _db.dbLogin(userId);
          widget.onSignedIn();
        }
      }catch (e){
        print("Error: $e");
        setState(() {
          this.setState(() {
            _isLoading = false; _errorMessage = e.message;
          });
        });
      }
    }
  }

  void _googleSignIn() async{
    this.setState(() {
        _isLoading = true;
      });
      _errorMessage = "";
    try{
        String userId = await widget.auth.googlesignin();
        print("User: $userId");
        try {
          if(userId.length > 0 && userId != null){
            widget.onSignedIn();
          }
          
        } catch (e) {
          print(e);
          
        }
        
        print("User: $userId");
      }catch (e){
        print("Error: $e");
        setState(() {
          this.setState(() {
            _isLoading = false;
          });
          if(e.code == 'ERROR_NETWORK_REQUEST_FAILED'){
            return Center(
              child: AlertDialog(
                title: Text('No'),
                content: Text("Do you want to logout?"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Logout"),
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                  ),
                ]
              ),
            );
          }
          else{
            _errorMessage = e.message;
          }
         
        });
      }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Login"),
      ),
      body: Stack(
        children: <Widget>[
          _showBody(),
          _showCircularProgress()
        ],
      )
    );
  }

  Widget _showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('images/chat.png'),
        ),
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
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
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }
  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: new MaterialButton(
                elevation: 5.0,
                minWidth: 200.0,
                height: 42.0,
                child:  new Text('Login',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
                color: Colors.green,
                onPressed: _validateAndSubmit,
        ));
}

Widget _showSecondaryButton() {
  return new FlatButton(
    child: new Text("'Create an account'"),
    onPressed: (){Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context)=>CreateAccount(auth: Auth(),)));
    }
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
            onPressed: (){
              _googleSignIn();
            },
          )
        ],
      ),);
  }

  Widget _textDivider(){
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: Text(
        "_____ Or connect with ____",
        style: TextStyle(color: Colors.green),
        
      ),
      ),
    );
  }

Widget _showErrorMessage() {
  if ( _errorMessage != null) {
    return new Text(
      _errorMessage,
      style: TextStyle(
          fontSize: 13.0,
          color: Colors.red,
          height: 1.0,
          fontWeight: FontWeight.w300),
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
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),),
    );
  }return Container(height: 0.0, width: 0.0,);
}

Widget _showBody(){
  return new Container(
      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: new Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            _showLogo(),
            _showEmailInput(),
            _showPasswordInput(),
            _showErrorMessage(),
            _showPrimaryButton(),
            _showSecondaryButton(),
            _textDivider(),
            _otherSignButton()
            
          ],
        ),
      ));
}


}