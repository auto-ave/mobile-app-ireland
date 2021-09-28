import 'package:themotorwash/data/models/auth_tokens.dart';
import 'package:themotorwash/data/models/fcm_topic.dart';
import 'package:themotorwash/data/models/send_otp_response.dart';

abstract class AuthRepository {
  Future<AuthTokensModel> checkOTP(
      {required String otp,
      required String phoneNumber,
      required String token});
  Future<SendOTPResponse> sendOTP({required String phoneNumber});

  Future<void> subcribeFcmTopics({required List<String> topics});

  Future<void> addFcmToken({required String token});
  Future<List<FcmTopic>> getFcmTopics();

  Future<void> logout({required String token});
}
