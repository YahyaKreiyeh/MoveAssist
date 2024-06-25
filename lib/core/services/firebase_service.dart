import 'package:firebase_auth/firebase_auth.dart';
import 'package:moveassist/core/networking/api_error_handler.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      print('Unknown error: $e');
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update the user profile to include the display name
      await userCredential.user?.updateProfile(displayName: name);
      await userCredential.user?.reload();
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      print('Unknown error: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  void _handleAuthException(FirebaseAuthException e) {
    final apiErrorModel = ErrorHandler.handle(e).apiErrorModel;
    print('Error: ${apiErrorModel.message}');
  }
}
