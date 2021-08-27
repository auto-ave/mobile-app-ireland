import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:themotorwash/data/models/initiate_payment.dart';
import 'package:themotorwash/data/repos/payment_repository.dart';
import 'package:themotorwash/data/models/paytm_payment_response.dart';

part 'paytm_payment_event.dart';
part 'paytm_payment_state.dart';

class PaytmPaymentBloc extends Bloc<PaytmPaymentEvent, PaytmPaymentState> {
  final PaymentRepository _paymentRepository;
  PaytmPaymentBloc({required PaymentRepository paymentRepository})
      : _paymentRepository = paymentRepository,
        super(PaytmPaymentInitial());

  @override
  Stream<PaytmPaymentState> mapEventToState(
    PaytmPaymentEvent event,
  ) async* {
    if (event is InitiatePaytmPaymentApi) {
      yield* _mapInitiatePaytmPaymentApiToState(
          date: event.date,
          bay: event.bay,
          slotStart: event.slotStart,
          slotEnd: event.slotEnd);
    } else if (event is CheckPaytmPaymentStatus) {
      yield* _mapCheckPaytmPaymentStatusToState(
          paymentResponseModel: event.paymentResponseModel);
    } else if (event is StartPaytmTransaction) {
      yield* _mapStartPaytmTransactionToState(
          initiatedPayment: event.initiatedPayment);
    }
  }

  Stream<PaytmPaymentState> _mapInitiatePaytmPaymentApiToState(
      {required String date,
      required int bay,
      required String slotStart,
      required String slotEnd}) async* {
    try {
      yield InitiatingPaytmPayment();
      InitiatePaymentModel initiatedPayment =
          await _paymentRepository.initiatePaytmPayment(
              date: date, bay: bay, slotStart: slotStart, slotEnd: slotEnd);
      yield PaytmPaymentInitiated(initiatedPayment: initiatedPayment);
    } catch (e) {
      yield FailedToInitiatePaytmPayment(message: e.toString());
    }
  }

  Stream<PaytmPaymentState> _mapStartPaytmTransactionToState(
      {required InitiatePaymentModel initiatedPayment}) async* {
    try {
      PaytmPaymentResponseModel paymentResponseModel = await _paymentRepository
          .startPaytmTransaction(initiatedPayment: initiatedPayment);
      yield PaytmPaymentSuccessful(paymentResponseModel: paymentResponseModel);
    } on PlatformException catch (e) {
      yield PaytmPaymentFailed(message: e.toString(), e: e);
    }
  }

  Stream<PaytmPaymentState> _mapCheckPaytmPaymentStatusToState(
      {required PaytmPaymentResponseModel paymentResponseModel}) async* {
    try {
      PaytmPaymentResponseModel paymentResponse = await _paymentRepository
          .checkPaytmPaymentStatus(paymentResponseModel: paymentResponseModel);

      yield CheckedPaytmPaymentStatus(paymentResponseModel: paymentResponse);
    } catch (e) {
      yield FailedToCheckPaytmPaymentStatus(message: e.toString());
    }
  }
}
