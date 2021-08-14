import 'package:themotorwash/data/models/initiate_payment.dart';
import 'package:themotorwash/data/models/paytm_payment_response.dart';

abstract class PaymentRepository {
  Future<InitiatePaymentModel> initiatePaytmPayment(
      {required String date,
      required int bay,
      required String slotStart,
      required String slotEnd});

  Future<PaytmPaymentResponseModel> startPaytmTransaction(
      {required InitiatePaymentModel initiatedPayment});

  Future<PaytmPaymentResponseModel> checkPaytmPaymentStatus(
      {required PaytmPaymentResponseModel paymentResponseModel});
}
