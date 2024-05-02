import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createNewUser(String email, String password) async {
    try {
      print("test");
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

    } catch (exception) {
      print(exception);
    }
  }
}