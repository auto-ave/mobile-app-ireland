import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:themotorwash/data/api/api_methods.dart';
import 'package:themotorwash/data/models/initiate_payment.dart';
import 'package:themotorwash/data/models/paytm_payment_response.dart';
import 'package:themotorwash/data/repos/payment_repository.dart';
import 'dart:convert';

class PaymentRestRepository implements PaymentRepository {
  ApiMethods _apiMethodsImp;
  PaymentRestRepository({required ApiMethods apiMethodsImp})
      : _apiMethodsImp = apiMethodsImp;

  @override
  Future<InitiatePaymentModel> initiatePaytmPayment(
      {required String date,
      required int bay,
      required String slotStart,
      required String slotEnd}) async {
    InitiatePaymentEntity e = await _apiMethodsImp.initiatePaytmPayment(
        date: date, bay: bay, slotStart: slotStart, slotEnd: slotEnd);
    return InitiatePaymentModel.fromEntity(e);
  }

  @override
  Future<PaytmPaymentResponseModel> startPaytmTransaction(
      {required InitiatePaymentModel initiatedPayment}) async {
    Map<dynamic, dynamic>? result = await AllInOneSdk.startTransaction(
        initiatedPayment.mid,
        initiatedPayment.orderId,
        initiatedPayment.amount,
        initiatedPayment.transactionToken,
        '',
        true,
        false);
    print(result.toString() + " hello");
    print(jsonEncode(result) + "json");
    dynamic data = jsonDecode(jsonEncode(result));
    PaytmPaymentResponseEntity response =
        PaytmPaymentResponseEntity.fromJson(data);

    return PaytmPaymentResponseModel.fromEntity(response);
  }

  @override
  Future<PaytmPaymentResponseModel> checkPaytmPaymentStatus(
      {required PaytmPaymentResponseModel paymentResponseModel}) async {
    PaytmPaymentResponseEntity entity =
        await _apiMethodsImp.checkPaytmPaymentStatus(
            paymentResponseEntity: paymentResponseModel.toEntity());
    return PaytmPaymentResponseModel.fromEntity(entity);
  }
}
