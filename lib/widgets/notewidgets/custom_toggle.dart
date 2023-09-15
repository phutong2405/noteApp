import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:someapp/providers/filter_button_provider.dart';
import 'package:someapp/providers/notedata_provider.dart';
// import 'package:someapp/providers/notedata_provider.dart';

class FilterButton extends ConsumerStatefulWidget {
  const FilterButton({super.key, required this.flag});
  final int flag;

  @override
  ConsumerState<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends ConsumerState<FilterButton> {
  // List<bool> isSelected = List.generate(4, (index) => false);
  @override
  Widget build(BuildContext context) {
    final isSelected = ref.watch(filterButtonProvider);
    final isSelectedTo = ref.read(filterButtonProvider.notifier);
    final noteDataUpdate = ref.read(filterNoteDataProvider.notifier);
    int flag = widget.flag;
    return ToggleButtons(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < isSelected[flag].length;
              buttonIndex++) {
            if (buttonIndex == index) {
              isSelectedTo.setButton(buttonIndex, flag);
              if (flag == 0) {
                noteDataUpdate.filterNoteData(isSelectedTo.getColorButton(0));
                //set counter sort = 0
                // ignore: deprecated_member_use
                ref.read(sortKeyProvider.state).state = 0;
              }
            } else {}
          }
        });
      },
      isSelected: isSelected[flag],
      renderBorder: false,
      fillColor: Colors.transparent,
      children: [
        CustomIcon(bgColor: Colors.red, isSelected: isSelected[flag][0]),
        CustomIcon(bgColor: Colors.blue, isSelected: isSelected[flag][1]),
        CustomIcon(bgColor: Colors.yellow, isSelected: isSelected[flag][2]),
        CustomIcon(bgColor: Colors.green, isSelected: isSelected[flag][3]),
      ],
    );
  }
}

class CustomIcon extends StatefulWidget {
  final bool isSelected;
  final Color bgColor;

  const CustomIcon({super.key, this.isSelected = false, required this.bgColor});
  @override
  // ignore: library_private_types_in_public_api
  _CustomIconState createState() => _CustomIconState();
}

class _CustomIconState extends State<CustomIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(70)),
        border: widget.isSelected
            ? Border.all(width: 3, color: Colors.white)
            : null,
        color: widget.bgColor,
      ),
      child: widget.isSelected
          ? const Icon(
              Icons.check,
              size: 20,
              color: Colors.white,
            )
          : null,
    );
  }
}
