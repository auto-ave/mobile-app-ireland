import 'package:hive/hive.dart';
import 'package:themotorwash/data/models/auth_tokens.dart';
import 'package:themotorwash/data/models/vehicle_model.dart';

class LocalDataService {
  static final getItInstanceName = "LocalDataService";
  // final storage = new FlutterSecureStorage();
  final String authBoxKey = 'auth_box';
  final String vehicleBoxKey = 'vehicle_box';
  final String accessTokenKey = 'access_token';
  final String refreshTokenKey = 'refresh_token';
  final String vehicleKey = 'saved_vehicle';
  final String firstTimeAppOpenKey = 'first_time_app_open';
  LocalDataService() {
    Hive.registerAdapter<VehicleModel>(VehicleModelAdapter(), override: true);
  }

  Future storeAuthToken(AuthTokensModel tokens) async {
    var authBox = await Hive.openBox(authBoxKey);
    await authBox.put(accessTokenKey, tokens.accessToken);
    await authBox.put(refreshTokenKey, tokens.refreshToken);
    // await storage.write(key: 'refresh_token', value: tokens.refreshToken);
    // await storage.write(key: 'access_token', value: tokens.accessToken);
  }

  storeNewAccessToke(String accessToken) async {
    var authBox = await Hive.openBox(authBoxKey);
    await authBox.put(accessTokenKey, accessToken);
    // await storage.write(key: 'access_token', value: accessToken);
  }

  Future<AuthTokensModel> getAuthTokens() async {
    var authBox = await Hive.openBox(authBoxKey);
    String? refreshToken = authBox.get(refreshTokenKey);
    String? accessToken = authBox.get(accessTokenKey);

    // String? refreshToken = await storage.read(key: 'refresh_token');
    // String? accessToken = await storage.read(key: 'access_token');
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
    var authBox = await Hive.openBox(authBoxKey);
    await authBox.deleteAll([accessTokenKey, refreshTokenKey]);
    // String? refreshToken = authBox.get('refresh_token');
    // String? accessToken = authBox.get('access_token');
    // await storage.delete(key: 'refresh_token');
    // await storage.delete(key: 'access_token');

    return true;
  }

  Future<VehicleModel?> getSavedVehicleType() async {
    // final documentDirectory = await getApplicationDocumentsDirectory();

    // Hive.init(documentDirectory.path);

    var vehicleBox = await Hive.openBox(vehicleBoxKey);
    VehicleModel? vehicleTypeModel;
    if (vehicleBox.containsKey(0)) {
      vehicleTypeModel = vehicleBox.get(0);
    }

    return vehicleTypeModel;
  }

  Future<void> saveVehicleType({required VehicleModel vehicleTypeModel}) async {
    var vehicleBox = await Hive.openBox(vehicleBoxKey);
    if (vehicleBox.containsKey(0)) {
      await vehicleBox.delete(0);
    }

    await vehicleBox.put(0, vehicleTypeModel);
  }

  Future<bool> isFirstOpen() async {
    // return false;
    var appOpenBox = await Hive.openBox(firstTimeAppOpenKey);
    if (!appOpenBox.containsKey(0)) {
      await appOpenBox.put(0, true);
      return true;
    }
    return false;
    // return true;
  }
}
