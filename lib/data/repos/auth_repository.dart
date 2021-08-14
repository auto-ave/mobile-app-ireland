import 'package:themotorwash/data/models/auth_tokens.dart';
import 'package:themotorwash/data/models/send_otp_response.dart';

abstract class AuthRepository {
  Future<AuthTokensModel> checkOTP(
      {required String otp, required String phoneNumber});
  Future<SendOTPResponse> sendOTP({required String phoneNumber});
}
