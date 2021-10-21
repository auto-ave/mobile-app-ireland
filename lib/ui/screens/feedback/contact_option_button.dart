import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:themotorwash/theme_constants.dart';

class ContactOptionButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String svgAsset;
  const ContactOptionButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.svgAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(
                color: kPrimaryColor,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                    offset: Offset(-5, 4),
                    blurRadius: 16,
                    color: Color.fromRGBO(0, 0, 0, 0.16))
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(svgAsset),
              kverticalMargin8,
              Text(text)
            ],
          ),
        ));
  }
}
