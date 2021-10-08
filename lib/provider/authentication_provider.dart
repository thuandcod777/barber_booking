import 'package:barber_booking/provider/base_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationFirebaseProvider extends BaseAuthenticationProvider {
  final FirebaseAuth _firebaseAuth;

  AuthenticationFirebaseProvider({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<User?> getAuthStates() {
    return _firebaseAuth.authStateChanges();
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<String> getCurrentUser() async {
    return _firebaseAuth.currentUser!.uid;
  }

  Future<User?> loginGoogle({AuthCredential? credential}) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential!);

    return userCredential.user;
  }

  Future<UserCredential> signUpWithEmail(
      {String? email, String? password}) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email!, password: password!);

    return userCredential;
  }

  Future<UserCredential?> signInWithEmail(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    return userCredential;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
