import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  final String text;
  const BadgeWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 4,
                color: Color.fromRGBO(0, 0, 0, 0.25))
          ],
          color: Color.fromRGBO(180, 214, 255, 1),
          borderRadius: BorderRadius.circular(2)),
      child: Text(
        text,
        style: TextStyle(fontSize: 10),
      ),
    );
  }
}
