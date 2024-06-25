import 'package:firebase_auth/firebase_auth.dart';
import 'package:moveassist/core/networking/api_error_handler.dart';
import 'package:moveassist/core/networking/api_result.dart';
import 'package:moveassist/featurs/sign_up/data/models/sign_up_request_body.dart';
import 'package:moveassist/featurs/sign_up/data/models/sign_up_response.dart';

class SignupRepo {
  final FirebaseAuth _firebaseAuth;

  SignupRepo(this._firebaseAuth);

  Future<ApiResult<SignupResponse>> signup(
    SignupRequestBody signupRequestBody,
  ) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: signupRequestBody.email,
        password: signupRequestBody.password,
      );

      // Set the display name
      await userCredential.user
          ?.updateProfile(displayName: signupRequestBody.name);
      await userCredential.user?.reload();

      // Fetch the updated user details
      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'ERROR_USER_NOT_FOUND',
          message: 'User not found after signup',
        );
      }

      SignupResponse signupResponse = SignupResponse(
        message: "User registered successfully",
        status: true,
        code: 200,
        userData: UserData(
          token: await user.getIdToken(),
          userName: user.displayName,
          userId: user.uid,
        ),
      );

      return ApiResult.success(signupResponse);
    } on FirebaseAuthException catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
