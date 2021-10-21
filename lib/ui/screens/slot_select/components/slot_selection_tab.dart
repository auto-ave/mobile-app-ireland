import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/slot_select/components/no_slots_widget.dart';

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
    // return StaggeredGridView.count(
    //   crossAxisCount: MediaQuery.of(context).size.width < 400 ? 2 : 3,
    //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //   children: slots.asMap().entries.map((e) {
    //     final item = e.value;
    //     // return Text('Hello');
    //     return SlotSelectionTabWidget(
    //       startTime: item.startTime,
    //       endTime: item.endTime,
    //       isSelected: currentSelectedTabIndex == e.key,
    //       slotsAvailable: item.slotsAvailable,
    //       onTap: (tabIndex) => onTap(tabIndex),
    //       tabIndex: e.key,
    //     );
    //   }).toList(),
    //   staggeredTiles: slots.map((e) => StaggeredTile.count(1, 1)).toList(),
    //   mainAxisSpacing: 8.0,
    //   crossAxisSpacing: 4.0,
    // );
    // return StaggeredGridView.countBuilder(
    //   crossAxisCount: MediaQuery.of(context).size.width < 400 ? 2 : 3,
    //   itemCount: slots.length,
    //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //   itemBuilder: (BuildContext context, int index) {
    //     final item = slots[index];
    //     // return Text('Hello');
    //     return SlotSelectionTabWidget(
    //       startTime: item.startTime,
    //       endTime: item.endTime,
    //       isSelected: currentSelectedTabIndex == index,
    //       slotsAvailable: item.slotsAvailable,
    //       onTap: (tabIndex) => onTap(tabIndex),
    //       tabIndex: index,
    //     );
    //   },
    //   staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
    //   mainAxisSpacing: 4.0,
    //   crossAxisSpacing: 4.0,
    // );

    return slots.isEmpty
        ? Center(child: NoSlotsWidget())
        : GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                // childAspectRatio: MediaQuery.of(context).size.width < 400 ? 2.5 : 1.8,
                mainAxisExtent: 70,
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
  late int _slotsAvailable;

  SlotSelectionTabWidget(
      {Key? key,
      required this.startTime,
      required this.endTime,
      required this.isSelected,
      required int slotsAvailable,
      required this.onTap,
      required this.tabIndex}) {
    if (slotsAvailable < 1)
      _slotsAvailable = 0;
    else
      _slotsAvailable = slotsAvailable;
  }

  final String startTime;
  final String endTime;
  final bool isSelected;
  final Function(int tabIndex) onTap;
  final int tabIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _slotsAvailable == 0 ? () {} : () => onTap(tabIndex),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: _slotsAvailable == 0
                        ? Color(0xff8D8D8D)
                        : Theme.of(context).primaryColor,
                    width: 1),
                borderRadius: BorderRadius.circular(5),
                color:
                    isSelected ? Theme.of(context).primaryColor : Colors.white),
            child: Center(
                child: FittedBox(
              child: Text(
                '$startTime - $endTime',
                style: kStyle14W500.copyWith(color: getButtonTextColor()),
              ),
            )),
          ),
        ),
        FittedBox(
          child: Text(
            '$_slotsAvailable slots available',
            style: TextStyle(
                color: _slotsAvailable == 0
                    ? Colors.red
                    : Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }

  Color getButtonTextColor() {
    return _slotsAvailable == 0
        ? Color(0xff8D8D8D)
        : (!isSelected ? Colors.black : Colors.white);
  }
}
