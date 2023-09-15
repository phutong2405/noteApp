import 'package:flutter/material.dart';
import 'package:someapp/providers/notedata_provider.dart';
import 'package:someapp/widgets/notewidgets/note_list_item.dart';
import '../../providers/filter_button_provider.dart';
import 'custom_toggle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteWidget extends ConsumerStatefulWidget {
  const NoteWidget({super.key});

  @override
  ConsumerState<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends ConsumerState<NoteWidget> {
  late Future<void> _notesFuture;

  @override
  void initState() {
    super.initState();
    ref.read(filterButtonProvider.notifier).resetButton(0);
    // ignore: deprecated_member_use
    ref.read(sortKeyProvider.state).state = 0;
    _notesFuture = ref.read(filterNoteDataProvider.notifier).loadingNotes();
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = ref.watch(filterNoteDataProvider);
    final counterSort = ref.watch(sortKeyProvider);
    Icon iconSort = const Icon(
      Icons.sort_rounded,
      size: 40,
    );
    if (counterSort == 0) {
      iconSort = const Icon(
        Icons.sort_rounded,
        size: 40,
      );
    } else if (counterSort == 1) {
      iconSort = const Icon(
        Icons.arrow_upward,
        size: 40,
      );
    } else if (counterSort == 2) {
      iconSort = const Icon(
        Icons.arrow_downward,
        size: 40,
      );
    }
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const FilterButton(flag: 0),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 8),
            child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  if (filteredData.length >= 2) {
                    ref
                        .read(filterNoteDataProvider.notifier)
                        .sortFilteredData();
                  }
                },
                child: Transform.scale(
                  scaleX: -1,
                  child: iconSort,
                )),
          ),
        ],
      ),
      FutureBuilder(
        future: _notesFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: NoteListItem(noteData: filteredData),
                  ),
      ),
    ]);
  }
}
