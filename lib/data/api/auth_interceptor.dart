import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';

import 'package:themotorwash/data/local/local_data_service.dart';
import 'package:themotorwash/data/models/auth_tokens.dart';

class AuthInterceptor extends Interceptor {
  final GlobalAuthBloc _globalAuthBloc;
  AuthInterceptor({
    required GlobalAuthBloc globalAuthBloc,
  }) : _globalAuthBloc = globalAuthBloc;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // if(err.response?.statusCode)
    LocalDataService localDataService = GetIt.instance.get<LocalDataService>(
        instanceName: LocalDataService.getItInstanceName);
    GlobalAuthState state = _globalAuthBloc.state;
    Dio client = Dio();
    print('on error called1');
    if (err.response?.statusCode == 401 && state is Authenticated) {
      try {
        print('on error called2');
        await client.post("https://testapi.autoave.in/account/token/refresh",
            data: {"refresh": state.tokens.refreshToken}).then((value) async {
          print('then called' +
              value.statusCode.toString() +
              " " +
              value.data.toString());
          if (value.statusCode == 200) {
            //get new tokens ...
            print('on error called3');
            String accessToken = value.data['access'];
            String refreshToken = value.data['refresh'];
            print("access token" + accessToken);
            print("refresh token" + refreshToken);
            AuthTokensModel tokens = AuthTokensModel(
                refreshToken: refreshToken,
                accessToken: accessToken,
                authenticated: true);
            await localDataService.storeAuthToken(tokens);
            _globalAuthBloc.add(YieldAuthenticatedState(tokens: tokens));
            //set bearer
            // headers = {'Authorization': 'JWT ${state.tokens.accessToken}'};
            err.requestOptions.headers["Authorization"] = 'JWT $accessToken';
            // err.requestOptions.headers["Authorization"] = "JWT " + accessToken;
            //create request with new access token
            final opts = new Options(
                method: err.requestOptions.method,
                headers: err.requestOptions.headers,
                responseType: err.requestOptions.responseType);
            final cloneReq = await client.request(err.requestOptions.path,
                options: opts,
                data: err.requestOptions.data,
                queryParameters: err.requestOptions.queryParameters);

            return handler.resolve(cloneReq);
          }
          return super.onError(err, handler);
        }).onError(
            (error, stackTrace) => print(error.toString() + "refresh error"));
      } catch (e, st) {
        print(e.toString());
      }
    }
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}
