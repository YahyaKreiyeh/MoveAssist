import 'package:firebase_auth/firebase_auth.dart';
import 'package:moveassist/core/networking/api_error_handler.dart';
import 'package:moveassist/core/networking/api_result.dart';
import 'package:moveassist/featurs/login/data/models/login_request_body.dart';
import 'package:moveassist/featurs/login/data/models/login_response.dart';

class LoginRepo {
  final FirebaseAuth _firebaseAuth;

  LoginRepo(this._firebaseAuth);

  Future<ApiResult<LoginResponse>> login(
      LoginRequestBody loginRequestBody) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: loginRequestBody.email,
        password: loginRequestBody.password,
      );

      LoginResponse loginResponse = LoginResponse(
        message: "User logged in successfully",
        status: true,
        code: 200,
        userData: UserData(
          token: await userCredential.user?.getIdToken(),
          userName: userCredential.user?.displayName,
          userId: userCredential.user?.uid,
        ),
      );

      return ApiResult.success(loginResponse);
    } on FirebaseAuthException catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
