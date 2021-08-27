import 'package:flutter/material.dart';
import 'package:themotorwash/ui/widgets/search_bar.dart';

class SelectLocationBottomSheet extends StatefulWidget {
  const SelectLocationBottomSheet({Key? key}) : super(key: key);

  @override
  _SelectLocationBottomSheetState createState() =>
      _SelectLocationBottomSheetState();
}

class _SelectLocationBottomSheetState extends State<SelectLocationBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Select City',
        ),
        // SearchBar(),
        Text('Popular Tities'),
        ListView.separated(
            itemBuilder: (_, index) {
              return Text('Banglore');
            },
            separatorBuilder: (_, __) {
              return Divider(
                thickness: 1,
              );
            },
            itemCount: 3)
      ],
    );
  }
}
