import 'package:wtfc_provider_app/export.dart';

class AuthServices {
  //for storing in cloud firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Access for authentication

  final FirebaseAuth _auth = FirebaseAuth.instance;

//?for signup

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String name}) async {
    String res = 'Some error ocurred';

    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        //add to firestore
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'name': name,
          'email': email,
          'uid': credential.user!.uid,
        });

        res = 'success';
      }
      //for register user in auth with email and password
    } catch (e) {
      return e.toString();
    }

    return res;
  }

  //?Signin

  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    String res = 'Signin failed';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      res = 'success';
    } catch (e) {
      return e.toString();
    }

    return res;
  }

  Future<void> SignOut() async {
    await _auth.signOut();
  }

  //check if the user is login or not
  Future<bool> isLoggedin() async {
    //if there is no current user, therefore it is null
    //thus if there is a current user, it will be false and invert to true
    var user = _auth.currentUser;
    print('current user ${user}');
    return user != null;
  }
}
