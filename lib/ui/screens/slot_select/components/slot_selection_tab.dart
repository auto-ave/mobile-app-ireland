import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';

class SlotSelectionTab extends StatelessWidget {
  final List<SlotSelectionTabItem> slots;
  final int currentSelectedTabIndex;
  final Function(int tabIndex) onTap;
  SlotSelectionTab(
      {Key? key,
      required this.slots,
      required this.currentSelectedTabIndex,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemBuilder: (_, index) {
        final item = slots[index];
        return SlotSelectionTabWidget(
          startTime: item.startTime,
          endTime: item.endTime,
          isSelected: currentSelectedTabIndex == index,
          slotsAvailable: item.slotsAvailable,
          onTap: (tabIndex) => onTap(tabIndex),
          tabIndex: index,
        );
      },
      itemCount: slots.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 2,
          crossAxisCount: MediaQuery.of(context).size.width < 400 ? 2 : 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8),
    );
  }
}

class SlotSelectionTabItem {
  final String startTime;
  final String endTime;
  final int slotsAvailable;

  SlotSelectionTabItem(
      {required this.startTime,
      required this.endTime,
      required this.slotsAvailable});
}

class SlotSelectionTabWidget extends StatelessWidget {
  final int slotsAvailable;

  SlotSelectionTabWidget(
      {Key? key,
      required this.startTime,
      required this.endTime,
      required this.isSelected,
      required this.slotsAvailable,
      required this.onTap,
      required this.tabIndex})
      : super(key: key);
  final String startTime;
  final String endTime;
  final bool isSelected;
  final Function(int tabIndex) onTap;
  final int tabIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: slotsAvailable == 0 ? () {} : () => onTap(tabIndex),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(
                    color: slotsAvailable == 0
                        ? Color(0xff8D8D8D)
                        : Theme.of(context).primaryColor,
                    width: 1),
                borderRadius: BorderRadius.circular(5),
                color:
                    isSelected ? Theme.of(context).primaryColor : Colors.white),
            child: Center(
                child: Text(
              '9am - 10am',
              style: kStyle14SemiBold.copyWith(color: getButtonTextColor()),
            )),
          ),
        ),
        Text(
          '$slotsAvailable slots available',
          style: TextStyle(
              color: slotsAvailable == 0
                  ? Colors.red
                  : Theme.of(context).primaryColor),
        ),
      ],
    );
  }

  Color getButtonTextColor() {
    return slotsAvailable == 0
        ? Color(0xff8D8D8D)
        : (!isSelected ? Colors.black : Colors.white);
  }
}
