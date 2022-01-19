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
    print('INITIATED PAYMENT' + initiatedPayment.toString());

    Map<dynamic, dynamic>? result = await AllInOneSdk.startTransaction(
        initiatedPayment.mid,
        initiatedPayment.orderId,
        initiatedPayment.amount,
        initiatedPayment.transactionToken,
        'https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=${initiatedPayment.orderId}',
        true,
        false);
    print(" hello" + result.toString());
    print("json" + jsonEncode(result));
    dynamic data = jsonDecode(jsonEncode(result));
    PaytmPaymentResponseEntity response =
        PaytmPaymentResponseEntity.fromJson(data);

    return PaytmPaymentResponseModel.fromEntity(response);

    // return PaytmPaymentResponseModel(
    //     currency: '',
    //     gatewayName: '',
    //     responseMessage: '',
    //     bankName: '',
    //     paymentMode: '',
    //     mid: '',
    //     responseCode: '',
    //     transactionAmount: '',
    //     transactionId: 'transactionId',
    //     orderId: '',
    //     bankTransactionId: '',
    //     status: '',
    //     transactionDate: DateTime.now(),
    //     checksumHash: ' checksumHash',
    //     transactionDateString: 'transactionDateString');
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
