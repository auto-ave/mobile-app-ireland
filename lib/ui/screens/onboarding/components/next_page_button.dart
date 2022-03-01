import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:themotorwash/theme_constants.dart';

class NextPageButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NextPageButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: const EdgeInsets.all(16),
      elevation: 0.0,
      shape: const CircleBorder(),
      fillColor: SizeConfig.kPrimaryColor,
      onPressed: () {
        HapticFeedback.heavyImpact();
        onPressed();
      },
      child: Icon(
        Icons.arrow_forward,
        color: Colors.white,
        size: 32.0,
      ),
    );
  }
}
