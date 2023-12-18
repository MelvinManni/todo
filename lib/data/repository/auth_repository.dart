import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/data/models/user_model.dart' as user_model;

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<user_model.User?> get user {
    return _firebaseAuth.authStateChanges().map((user) {
      return user == null
          ? user_model.User.empty
          : user_model.User(id: user.uid, email: user.email);
    });
  }

  Future<void> signInWithCredentials(
      {required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUpWithCredentials(
      {required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
