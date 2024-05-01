
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices{
  FirebaseAuth _auth = FirebaseAuth.instance;

  // SignUp Authentication Service and Store User Data
  Future<User?> signupwithEmailAndPassword(String email, String password) async{
    print('------------>Loading SignUp');
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e){
      print('------------>Some Error is Showing');
    }
    return null;
  }

  // LogIn Authentication Service and Store User Data
  Future<User?> loginwithEmailAndPassword(String email, String password) async{
    print('------------>Loading SignIn');
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e){
      print('------------>Some Error is Showing');
    }
    return null;
  }
}