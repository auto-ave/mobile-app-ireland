import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:themotorwash/data/models/auth_tokens.dart';

class LocalAuthService {
  final storage = new FlutterSecureStorage();

  Future storeAuthToken(AuthTokensModel tokens) async {
    await storage.write(key: 'refresh_token', value: tokens.refreshToken);
    await storage.write(key: 'access_token', value: tokens.accessToken);
  }

  storeNewAccessToke(String accessToken) async {
    await storage.write(key: 'access_token', value: accessToken);
  }

  Future<AuthTokensModel> getAuthTokens() async {
    String? refreshToken = await storage.read(key: 'refresh_token');
    String? accessToken = await storage.read(key: 'access_token');
    if (refreshToken != null && accessToken != null) {
      return AuthTokensModel(
          refreshToken: refreshToken,
          accessToken: accessToken,
          authenticated: true);
    }
    return AuthTokensModel(
        refreshToken: '', accessToken: '', authenticated: false);
  }

  Future<bool> removeTokens() async {
    await storage.delete(key: 'refresh_token');
    await storage.delete(key: 'access_token');

    return true;
  }
}
