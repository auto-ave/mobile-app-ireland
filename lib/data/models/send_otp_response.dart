class SendOTPResponse {
  final bool isOTPSent;
  final String? message;
  SendOTPResponse({
    required this.isOTPSent,
    this.message,
  });
}
