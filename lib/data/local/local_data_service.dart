import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:themotorwash/data/models/auth_tokens.dart';
import 'package:themotorwash/data/models/vehicle_type.dart';

class LocalDataService {
  static final getItInstanceName = "LocalDataService";
  final storage = new FlutterSecureStorage();
  LocalDataService() {
    Hive.registerAdapter(VehicleTypeModelAdapter(), override: true);
  }

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

  Future<VehicleTypeModel?> getSavedVehicleType() async {
    final documentDirectory = await getApplicationDocumentsDirectory();

    Hive.init(documentDirectory.path);

    var box = await Hive.openBox('vehicle_type');
    VehicleTypeModel? vehicleTypeModel;
    if (box.containsKey(0)) {
      vehicleTypeModel = await box.get(0);
    }

    return vehicleTypeModel;
  }

  Future<void> saveVehicleType(
      {required VehicleTypeModel vehicleTypeModel}) async {
    var box = await Hive.openBox('vehicle_type');
    if (box.containsKey(0)) {
      await box.delete(0);
    }

    await box.put(0, vehicleTypeModel);
  }
}
