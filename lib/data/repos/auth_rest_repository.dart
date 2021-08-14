import 'package:themotorwash/data/api/api_methods.dart';
import 'package:themotorwash/data/models/auth_tokens.dart';
import 'package:themotorwash/data/models/send_otp_response.dart';
import 'package:themotorwash/data/repos/auth_repository.dart';

class AuthRestRepository implements AuthRepository {
  ApiMethods _apiMethodsImp;
  AuthRestRepository({required ApiMethods apiMethodsImp})
      : _apiMethodsImp = apiMethodsImp;
  @override
  Future<AuthTokensModel> checkOTP(
      {required String otp, required String phoneNumber}) async {
    AuthTokensEntity entity =
        await _apiMethodsImp.checkOTP(otp: otp, phoneNumber: phoneNumber);
    return AuthTokensModel.fromEntity(entity);
  }

  @override
  Future<SendOTPResponse> sendOTP({required String phoneNumber}) async {
    var otpSent = await _apiMethodsImp.sendOTP(phoneNumber: phoneNumber);
    return otpSent;
  }
}
