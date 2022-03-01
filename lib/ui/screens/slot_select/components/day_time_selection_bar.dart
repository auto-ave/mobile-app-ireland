import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:themotorwash/main.dart';

import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/slot_select/components/no_slots_widget.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/shimmer_placeholder.dart';

class DayTimeSelectionBar extends StatefulWidget {
  // final List<SlotSelectionTabItem> slots;
  // final int currentSelectedTabIndex;
  final Function(int tabIndex) onChange;
  final List<DayTimeTabItem> tabs;
  int selectedIndex;
  DayTimeSelectionBar({
    Key? key,
    required this.onChange,
    required this.tabs,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<DayTimeSelectionBar> createState() => _DayTimeSelectionBarState();
}

class _DayTimeSelectionBarState extends State<DayTimeSelectionBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      child: Wrap(
        // spacing: 16,
        // runSpacing: 16,
        runAlignment: WrapAlignment.start,
        alignment: WrapAlignment.spaceEvenly,
        children: widget.tabs
            .map(
              (e) => DayTimeTabWidget(
                  time: e.time,
                  isSelected: widget.selectedIndex == e.tabIndex,
                  onTap: (index) {
                    widget.onChange(index);
                    setState(() {
                      widget.selectedIndex = index;
                    });
                  },
                  tabIndex: e.tabIndex,
                  imageAddress: e.image,
                  title: e.title),
            )
            .toList(),
      ),
    );
  }
}

class DayTimeTabItem {
  final String time;
  final String image;
  final String title;
  final int tabIndex;
  final bool isSelected;
  DayTimeTabItem({
    required this.time,
    required this.image,
    required this.title,
    required this.tabIndex,
    required this.isSelected,
  });
}

class DayTimeTabWidget extends StatelessWidget {
  final String time;
  final bool isSelected;
  final Function(int tabIndex) onTap;
  final int tabIndex;
  final String imageAddress;
  final String title;
  DayTimeTabWidget(
      {Key? key,
      required this.time,
      required this.isSelected,
      required this.onTap,
      required this.tabIndex,
      required this.imageAddress,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(tabIndex);
        mixpanel?.track('DayTime Slot Selected');
      },
      child: Container(
        width: 25.w,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      color: Colors.black.withOpacity(.16),
                    )
                  ]
                : [],
            border: Border.all(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Color(0xffCCCCCC),
                width: 1),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: imageAddress,
              height: 25,
              width: 25,
              placeholder: (_, __) {
                return Container(
                  child: ShimmerPlaceholder(),
                  height: 25,
                  width: 25,
                );
              },
            ),
            SizeConfig.kverticalMargin4,
            Text(
              title,
              style: SizeConfig.kStyle16,
            ),
            SizeConfig.kverticalMargin4,
            Text(
              time,
              style:
                  SizeConfig.kStyle12.copyWith(color: SizeConfig.kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
