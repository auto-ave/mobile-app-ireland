import 'package:themotorwash/data/models/initiate_paytm_payment.dart';
import 'package:themotorwash/data/models/initiate_razorpay_payment.dart';
import 'package:themotorwash/data/models/paytm_payment_response.dart';
import 'package:themotorwash/data/models/razorpay_payment_response.dart';

abstract class PaymentRepository {
  Future<InitiatePaytmPaymentModel> initiatePaytmPayment(
      {required String date,
      required int? bay,
      required String slotStart,
      required String? slotEnd});

  Future<PaytmPaymentResponseModel> startPaytmTransaction(
      {required InitiatePaytmPaymentModel initiatedPayment});

  Future<PaytmPaymentResponseModel> checkPaytmPaymentStatus(
      {required PaytmPaymentResponseModel paymentResponseModel});
  Future<InitiateRazorpayPaymentModel> initiateRazorpayPayment(
      {required String date,
      required int? bay,
      required String slotStart,
      required String? slotEnd});
  Future<RazorpayPaymentResponse> checkRazorpayPaymentStatus(
      {required RazorpayPaymentResponse paymentResponseModel,
      required String bookingId,
      required bool isFailure});
}
