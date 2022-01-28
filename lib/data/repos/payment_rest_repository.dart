import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:themotorwash/data/api/api_methods.dart';
import 'package:themotorwash/data/models/initiate_paytm_payment.dart';
import 'package:themotorwash/data/models/initiate_razorpay_payment.dart';
import 'package:themotorwash/data/models/paytm_payment_response.dart';
import 'package:themotorwash/data/models/razorpay_payment_response.dart';
import 'package:themotorwash/data/repos/payment_repository.dart';
import 'dart:convert';

class PaymentRestRepository implements PaymentRepository {
  ApiMethods _apiMethodsImp;
  PaymentRestRepository({required ApiMethods apiMethodsImp})
      : _apiMethodsImp = apiMethodsImp;

  @override
  Future<InitiatePaytmPaymentModel> initiatePaytmPayment(
      {required String date,
      required int? bay,
      required String slotStart,
      required String? slotEnd}) async {
    InitiatePaytmPaymentEntity e = await _apiMethodsImp.initiatePaytmPayment(
        date: date, bay: bay, slotStart: slotStart, slotEnd: slotEnd);
    return InitiatePaytmPaymentModel.fromEntity(e);
  }

  @override
  Future<PaytmPaymentResponseModel> startPaytmTransaction(
      {required InitiatePaytmPaymentModel initiatedPayment}) async {
    print('INITIATED PAYMENT' + initiatedPayment.toString());

    Map<dynamic, dynamic>? result = await AllInOneSdk.startTransaction(
        initiatedPayment.mid,
        initiatedPayment.orderId,
        initiatedPayment.amount,
        initiatedPayment.transactionToken,
        initiatedPayment.callbackUrl,
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

  @override
  Future<RazorpayPaymentResponse> checkRazorpayPaymentStatus(
      {required RazorpayPaymentResponse paymentResponseModel,
      required bool isFailure,
      required String bookingId}) async {
    RazorpayPaymentResponseEntity entity =
        await _apiMethodsImp.checkRazorpayPaymentStatus(
            paymentResponseEntity: paymentResponseModel.toEntity(),
            bookingId: bookingId,
            isFailure: isFailure);
    return RazorpayPaymentResponse.fromEntity(entity);
  }

  @override
  Future<InitiateRazorpayPaymentModel> initiateRazorpayPayment(
      {required String date,
      required int? bay,
      required String slotStart,
      required String? slotEnd}) async {
    InitiateRazorpayPaymentEntity e =
        await _apiMethodsImp.initiateRazorpayPayment(
            date: date, bay: bay, slotStart: slotStart, slotEnd: slotEnd);
    return InitiateRazorpayPaymentModel.fromEntity(e);
  }
}
