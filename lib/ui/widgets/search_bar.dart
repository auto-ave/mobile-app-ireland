import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final String? hintText;

  const SearchBar({this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: hintText,
          hintStyle:
              TextStyle(fontSize: 16, color: Color.fromRGBO(170, 170, 170, 1)),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 4),
        ),
      ),
      height: 40,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, .08),
              offset: Offset(0, 0),
              blurRadius: 24)
        ],
        borderRadius: BorderRadius.circular(24.0),
        color: Colors.white,
      ),
    );
  }
}
