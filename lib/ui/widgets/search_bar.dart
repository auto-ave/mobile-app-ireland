import 'package:flutter/material.dart';

import 'package:themotorwash/theme_constants.dart';

class SearchBar extends StatelessWidget {
  final String? hintText;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final TextEditingController textController;
  const SearchBar({
    Key? key,
    this.hintText,
    required this.focusNode,
    required this.onChanged,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(8),
      child: TextField(
        controller: textController,
        onChanged: onChanged,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16),
        onSubmitted: (text) {
          focusNode.requestFocus();
        },
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: focusNode.hasFocus
              ? IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () => focusNode.unfocus(),
                )
              : Icon(Icons.search),
          hintText: hintText,
          hintStyle:
              TextStyle(fontSize: 16, color: Color.fromRGBO(170, 170, 170, 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.white)),
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 0),
        ),
      ),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, .16),
              offset: Offset(0, 0),
              blurRadius: 8)
        ],
        color: Colors.white,
      ),
    );
  }
}
