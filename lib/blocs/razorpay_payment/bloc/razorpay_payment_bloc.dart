import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:themotorwash/data/models/initiate_razorpay_payment.dart';
import 'package:themotorwash/data/models/razorpay_payment_response.dart';
import 'package:themotorwash/data/repos/payment_repository.dart';
import 'package:themotorwash/utils/utils.dart';

part 'razorpay_payment_event.dart';
part 'razorpay_payment_state.dart';

class RazorpayPaymentBloc
    extends Bloc<RazorpayPaymentEvent, RazorpayPaymentState> {
  final Razorpay _razorpayInstance;
  final PaymentRepository _paymentRepository;
  RazorpayPaymentBloc(
      {required Razorpay razorpayInstance,
      required PaymentRepository paymentRepository})
      : _razorpayInstance = razorpayInstance,
        _paymentRepository = paymentRepository,
        super(RazorpayPaymentInitial()) {
    on<RazorpayPaymentEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is InitiateRazorpayPayment) {
        await _mapInitiateRazorpayPaymentToState(
            date: event.date,
            bay: event.bay,
            slotStart: event.slotStart,
            slotEnd: event.slotEnd,
            emit: emit);
      } else if (event is CheckRazorpayPaymentStatus) {
        await _mapCheckRazorpayPaymentStatusToState(
            paymentResponseModel: event.paymentResponseModel,
            bookingId: event.bookingId,
            isFailure: event.isFailure,
            emit: emit);
      } else if (event is StartRazorpayTransaction) {
        await _mapStartRazorpayTransactionToState(
            initiatedPayment: event.initiatedPayment,
            emit: emit,
            bookingId: event.initiatedPayment.bookingId);
      } else if (event is EmitRazorpayPaymentSuccess) {
        emit(RazorpayPaymentSuccess(
            bookingId: event.bookingId, successResponse: event.response));
      } else if (event is EmitRazorpayPaymentFailure) {
        emit(RazorpayPaymentFailure(
            failureResponse: event.response, bookingId: event.bookingId));
      }
    });
  }

  FutureOr<void> _mapStartRazorpayTransactionToState(
      {required InitiateRazorpayPaymentModel initiatedPayment,
      required Emitter<RazorpayPaymentState> emit,
      required String bookingId}) async {
    emit(RazorpayPaymentStarted());
    _razorpayInstance.open(initiatedPayment.toMap());
    _razorpayInstance.on(
        Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) => _handlePaymentSuccess(
            emit: emit, response: response, bookingId: bookingId));
    _razorpayInstance.on(
        Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) => _handlePaymentError(
            emit: emit, response: response, bookingId: bookingId));
    _razorpayInstance.on(
        Razorpay.EVENT_EXTERNAL_WALLET,
        (ExternalWalletResponse response) =>
            _handleExternalWallet(emit: emit, response: response));
  }

  FutureOr<void> _mapCheckRazorpayPaymentStatusToState(
      {required RazorpayPaymentResponse paymentResponseModel,
      required String bookingId,
      required bool isFailure,
      required Emitter<RazorpayPaymentState> emit}) async {
    try {
      print(paymentResponseModel.toString());
      RazorpayPaymentResponse paymentResponse =
          await _paymentRepository.checkRazorpayPaymentStatus(
              paymentResponseModel: paymentResponseModel,
              bookingId: bookingId,
              isFailure: isFailure);

      emit(CheckedRazorpayPaymentStatus(
          paymentResponseModel: paymentResponse, bookingId: bookingId));
    } catch (e) {
      emit(
        FailedToCheckRazorpayPaymentStatus(
            message: e.toString(), bookingId: bookingId),
      );
    }
  }

  FutureOr<void> _mapInitiateRazorpayPaymentToState(
      {required String date,
      required int? bay,
      required String slotStart,
      required String? slotEnd,
      required Emitter<RazorpayPaymentState> emit}) async {
    try {
      emit(InitiatingRazorpayPayment());
      InitiateRazorpayPaymentModel initiatedPayment =
          await _paymentRepository.initiateRazorpayPayment(
              date: date, bay: bay, slotStart: slotStart, slotEnd: slotEnd);
      print('Initiated Razorpay Payment ' +
          ' ' +
          initiatedPayment.toString() +
          " " +
          initiatedPayment.key +
          " " +
          initiatedPayment.amount.toString());
      emit(InitiatedRazorpayPayment(initiatedPayment: initiatedPayment));
    } catch (e) {
      emit(FailedToInitiateRazorpayPayment(message: e.toString()));
    }
  }

  FutureOr<void> _handlePaymentSuccess(
      {required Emitter<RazorpayPaymentState> emit,
      required PaymentSuccessResponse response,
      required String bookingId}) async {
    // re
    print('Handle Payment Success Called' +
        " " +
        response.toString() +
        " " +
        RazorpayPaymentResponse(
          razorpayOrderId: response.orderId ?? "",
          razorpayPaymentId: response.paymentId ?? "",
          razorpaySignature: response.signature ?? "",
        ).toString());

    add(EmitRazorpayPaymentSuccess(
        response: RazorpayPaymentResponse(
          razorpayOrderId: response.orderId ?? "",
          razorpayPaymentId: response.paymentId ?? "",
          razorpaySignature: response.signature ?? "",
        ),
        bookingId: bookingId));
    _razorpayInstance.clear();
  }

  FutureOr<void> _handlePaymentError(
      {required Emitter<RazorpayPaymentState> emit,
      required PaymentFailureResponse response,
      required String bookingId}) {
    print('Handle Payment Error Called' +
        " " +
        response.toString() +
        " " +
        response.message.toString());
    add(EmitRazorpayPaymentFailure(response: response, bookingId: bookingId));
    _razorpayInstance.clear();
  }

  FutureOr<void> _handleExternalWallet(
      {required Emitter<RazorpayPaymentState> emit,
      required ExternalWalletResponse response}) {
    print('Handle External Wallet Called' + " " + response.toString());
    autoaveLog(response.toString());
  }
}
