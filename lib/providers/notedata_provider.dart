import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:someapp/models/note_model.dart';
import 'package:someapp/providers/filter_button_provider.dart';
import 'package:hive/hive.dart';

final sortKeyProvider = StateProvider<int>((ref) {
  return 0;
});

Future<CollectionBox<Map>> _getDatabase() async {
  final collection = await BoxCollection.open(
    'notes_db',
    {'notes_box'},
    path: './.',
  );
  final notesBox = await collection.openBox<Map>('notes_box');
  return notesBox;
}

class FilterNoteDataNotifier extends StateNotifier<List<NoteItem>> {
  FilterNoteDataNotifier({required this.ref}) : super([]);
  final Ref ref;

  Future<void> hiveData() async {
    final notesBox = await _getDatabase();
    final mapNotes = await notesBox.getAllValues();
    final listTemp = mapNotes.entries
        .map(
          (mapNote) => NoteItem(
              id: mapNote.key,
              title: mapNote.value['title'],
              typeColor: Color(
                mapNote.value['typeColor'],
              ),
              content: mapNote.value['content'],
              date: mapNote.value['date']),
        )
        .toList();
    listTemp.sort(
      (a, b) => a.date.compareTo(b.date),
    );
    state = [...listTemp];
  }

  Future<void> loadingNotes() async {
    await ref.read(filterNoteDataProvider.notifier).hiveData();
    if (state != []) {
      state = [...state];
    } else {
      state = [];
    }
  }

  void addNote(NoteItem noteItem) async {
    final notesBox = await _getDatabase();
    await notesBox.put(noteItem.id, {
      'title': noteItem.title,
      'typeColor': noteItem.typeColor.value,
      'content': noteItem.content,
      'date': noteItem.date,
    });
    final Color color =
        ref.watch(filterButtonProvider.notifier).getColorButton(0);
    if (color != Colors.transparent) {
      ref.read(filterNoteDataProvider.notifier).filterNoteData(color);
      ref
          .read(filterNoteDataProvider.notifier)
          .sortFilteredData(keyState: true);
    } else {
      await ref.read(filterNoteDataProvider.notifier).hiveData();
      ref
          .read(filterNoteDataProvider.notifier)
          .sortFilteredData(keyState: true);
    }
  }

  void deleteItem(NoteItem noteItem, context) async {
    final oldItem = noteItem;
    final notesBox = await _getDatabase();
    await notesBox.delete(noteItem.id);
    state = [...state.where((item) => noteItem.id != item.id).toList()];

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Deleted...'),
      duration: const Duration(seconds: 3),
      // backgroundColor: Colors.red.withOpacity(0.7),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          ref.read(filterNoteDataProvider.notifier).addNote(oldItem);

          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Undo...'),
              duration: Duration(seconds: 1),
              backgroundColor: Colors.transparent,
            ),
          );
        },
      ),
    ));
  }

  void filterNoteData(Color filteredColor) async {
    if (filteredColor == Colors.transparent) {
      await ref.read(filterNoteDataProvider.notifier).hiveData();
    } else {
      await ref.read(filterNoteDataProvider.notifier).hiveData();
      final newState = state
          .where((noteItem) => noteItem.typeColor.value == filteredColor.value)
          .toList();
      state = [...newState];
      ref
          .read(filterNoteDataProvider.notifier)
          .sortFilteredData(keyState: true);
    }
  }

  void sortFilteredData({bool keyState = false}) {
    if (keyState != false) {
      // ignore: deprecated_member_use
      ref.read(sortKeyProvider.state).state--;
    }
    int sortKey = ref.read(sortKeyProvider);
    if (sortKey == 0) {
      state.sort((a, b) => a.title.compareTo(b.title));
    } else if (sortKey == 1) {
      state.sort((a, b) => b.title.compareTo(a.title));
    } else if (sortKey == 2) {
      state.sort((a, b) => a.date.compareTo(b.date));
    }
    // ignore: deprecated_member_use

    if (sortKey >= 2) {
      // ignore: deprecated_member_use
      ref.read(sortKeyProvider.state).state = 0;
    } else {
      // ignore: deprecated_member_use
      ref.read(sortKeyProvider.state).state++;
    }
  }
}

final filterNoteDataProvider =
    StateNotifierProvider<FilterNoteDataNotifier, List<NoteItem>>((ref) {
  return FilterNoteDataNotifier(ref: ref);
});
