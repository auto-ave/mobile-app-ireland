import 'package:flutter/material.dart';

getTimeOfDayFromString(String s) {
  List<String> splitted = s.split(':');
  return TimeOfDay(
    hour: int.parse(splitted[0]),
    minute: int.parse(splitted[1]),
  );
}
