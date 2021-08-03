import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/slot_select/components/date_selection_tab.dart';
import 'package:themotorwash/ui/screens/slot_select/components/slot_selection_tab.dart';

class SlotSelectScreen extends StatefulWidget {
  SlotSelectScreen({Key? key}) : super(key: key);
  static final String route = '/slotSelect';
  @override
  _SlotSelectScreenState createState() => _SlotSelectScreenState();
}

class _SlotSelectScreenState extends State<SlotSelectScreen> {
  int currentSelectedSlotIndex = -1;
  int currentSelectedDateIndex = -1;
  late DateTime sevenDaysFromNow;
  List<DateTime> calendarDays = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i <= 6; i++) {
      calendarDays.add(DateTime.now().add(Duration(days: i)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateSelectionTab(
                dates: calendarDays
                    .map((e) => DateSelectionItem(date: e))
                    .toList(),
                currentSelectedTabIndex: currentSelectedDateIndex,
                onTap: (index) {
                  setState(() {
                    currentSelectedDateIndex = index;
                  });
                }),
            currentSelectedDateIndex >= 0
                ? Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 16),
                    child: Text(
                        'Slots on  ${calendarDays[currentSelectedDateIndex].day}',
                        style: kStyle20Bold),
                  )
                : Container(),
            kverticalMargin16,
            Expanded(
              child: currentSelectedDateIndex < 0
                  ? Center(child: Text('Select a Date'))
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SlotSelectionTab(
                        slots: [
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 0,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 0,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                          SlotSelectionTabItem(
                            startTime: 's',
                            endTime: 'endTime',
                            slotsAvailable: 2,
                          ),
                        ],
                        currentSelectedTabIndex: currentSelectedSlotIndex,
                        onTap: (int tabIndex) {
                          setState(() {
                            currentSelectedSlotIndex = tabIndex;
                          });
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
