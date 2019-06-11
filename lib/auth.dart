import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


abstract class BaseAuth{
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> signInWithEmailAndPassword(email, password);
  Future<String> currentUser();
  Future<void> signOut();
  Future<String> googlesignin();

}

class Auth implements BaseAuth{
  // Dependencies
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String> createUserWithEmailAndPassword(String email, String password) async{
    FirebaseUser user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }
  Future<String> signInWithEmailAndPassword(email, password) async{
    FirebaseUser user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

  Future<String> currentUser() async{
    FirebaseUser user = await _auth.currentUser();
    return user.uid;
  }

  Future<void> signOut() async{
    return _auth.signOut();
  }

  Future<String> googlesignin() async{
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);
    return user.uid;
  }
  
}