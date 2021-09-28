import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';

class DateSelectionTab extends StatelessWidget {
  const DateSelectionTab(
      {Key? key,
      required this.dates,
      required this.currentSelectedTabIndex,
      required this.onTap})
      : super(key: key);
  final List<DateSelectionItem> dates;
  final int currentSelectedTabIndex;
  final Function(int tabIndex) onTap;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 8,
            ),
            ...(dates
                .asMap()
                .entries
                .map((e) => DateSelectionWidget(
                      isSelected: currentSelectedTabIndex == e.key,
                      date: e.value.date,
                      onTap: onTap,
                      tabIndex: e.key,
                    ))
                .toList())
          ],
        ));
  }
}

class DateSelectionItem {
  final DateTime date;
  DateSelectionItem({required this.date});
}

class DateSelectionWidget extends StatelessWidget {
  const DateSelectionWidget(
      {Key? key,
      required this.isSelected,
      required this.date,
      required this.onTap,
      required this.tabIndex})
      : super(key: key);
  final bool isSelected;
  final DateTime date;
  final Function(int tabIndex) onTap;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(tabIndex),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: 70,
          decoration: BoxDecoration(
              color: isSelected ? Theme.of(context).primaryColor : Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              border: Border.all(color: Theme.of(context).primaryColor)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                child: Text(
                  '${date.day}',
                  style: kStyle24Bold.copyWith(
                      color: isSelected ? Colors.white : Color(0xff8C8C8C)),
                ),
              ),
              FittedBox(
                child: Text(
                  getWeekdayText(date.weekday),
                  style: kStyle16SemiBold.copyWith(
                      color: isSelected ? Colors.white : Color(0xff8C8C8C),
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getWeekdayText(int weekday) {
    switch (weekday) {
      case 1:
        {
          return 'Mon';
        }

      case 2:
        {
          return 'Tue';
        }
      case 3:
        {
          return 'Wed';
        }
      case 4:
        {
          return 'Thu';
        }
      case 5:
        {
          return 'Fri';
        }
      case 6:
        {
          return 'Sat';
        }
      case 7:
        {
          return 'Sun';
        }

      default:
        {
          return '';
        }
    }
  }
}
