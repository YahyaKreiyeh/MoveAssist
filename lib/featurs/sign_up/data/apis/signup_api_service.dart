import 'package:dio/dio.dart';
import 'package:moveassist/core/networking/api_constants.dart';
import 'package:moveassist/featurs/sign_up/data/apis/signup_api_constants.dart';
import 'package:moveassist/featurs/sign_up/data/models/sign_up_request_body.dart';
import 'package:moveassist/featurs/sign_up/data/models/sign_up_response.dart';
import 'package:retrofit/retrofit.dart';

part 'signup_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class SignupApiService {
  factory SignupApiService(Dio dio, {String baseUrl}) = _SignupApiService;

  @POST(SignupApiConstants.signup)
  Future<SignupResponse> signup(
    @Body() SignupRequestBody signupRequestBody,
  );
}
