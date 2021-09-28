import 'package:themotorwash/data/api/api_methods.dart';
import 'package:themotorwash/data/models/auth_tokens.dart';
import 'package:themotorwash/data/models/fcm_topic.dart';
import 'package:themotorwash/data/models/send_otp_response.dart';
import 'package:themotorwash/data/repos/auth_repository.dart';

class AuthRestRepository implements AuthRepository {
  ApiMethods _apiMethodsImp;
  AuthRestRepository({required ApiMethods apiMethodsImp})
      : _apiMethodsImp = apiMethodsImp;
  @override
  Future<AuthTokensModel> checkOTP(
      {required String otp,
      required String phoneNumber,
      required String token}) async {
    AuthTokensEntity entity = await _apiMethodsImp.checkOTP(
        otp: otp, phoneNumber: phoneNumber, token: token);
    return AuthTokensModel.fromEntity(entity);
  }

  @override
  Future<SendOTPResponse> sendOTP({required String phoneNumber}) async {
    var otpSent = await _apiMethodsImp.sendOTP(phoneNumber: phoneNumber);
    return otpSent;
  }

  @override
  Future<void> addFcmToken({required String token}) async {
    await _apiMethodsImp.addFcmToken(token: token);
  }

  @override
  Future<void> subcribeFcmTopics({required List<String> topics}) async {
    await _apiMethodsImp.subscribeFcmTopics(topics: topics);
  }

  @override
  Future<List<FcmTopic>> getFcmTopics() async {
    List<FcmTopicEntity> entities = await _apiMethodsImp.getFcmTopics();
    return entities.map((e) => FcmTopic.fromEntity(e)).toList();
  }

  @override
  Future<void> logout({required String token}) async {
    await _apiMethodsImp.logout(token: token);
  }
}
