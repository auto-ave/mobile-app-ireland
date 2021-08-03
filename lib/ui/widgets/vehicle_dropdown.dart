import 'package:flutter/material.dart';

class VehicleDropDown extends StatelessWidget {
  final String? valueSelected;
  final Function(String?)? onChangedSelected;
  final String? hintText;
  final List<String>? options;

  const VehicleDropDown(
      {this.valueSelected,
      this.onChangedSelected,
      this.hintText,
      this.options});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 40,
      child: DropdownButton(
        isExpanded: true,
        underline: Text(""),
        hint: Text(
          'Filter',
          style: TextStyle(
            fontSize: 10,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),

        // Not necessary for Option 1
        value: valueSelected,
        style: TextStyle(
          fontSize: 10,
          color: const Color(0xfff6f6f6),
          fontWeight: FontWeight.w600,
        ),
        dropdownColor: Theme.of(context).primaryColor,
        onChanged: onChangedSelected,
        items: options?.map((filter) {
          return DropdownMenuItem(
            child: Text(
              filter,
              style: TextStyle(
                fontSize: 10,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            value: filter,
          );
        }).toList(),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffaaaaaa),
        ),
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
    );
    ;
  }
}
