import 'package:flutter/material.dart';
import 'package:someapp/models/note_model.dart';
import 'package:someapp/providers/notedata_provider.dart';
import 'package:someapp/screens/notescreens/note_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteListItem extends ConsumerStatefulWidget {
  const NoteListItem({super.key, required this.noteData});
  final List<NoteItem> noteData;

  @override
  ConsumerState<NoteListItem> createState() => _NoteListItemState();
}

class _NoteListItemState extends ConsumerState<NoteListItem> {
  @override
  Widget build(BuildContext context) {
    final removeItem = ref.read(filterNoteDataProvider.notifier);
    return ListView.builder(
      itemCount: widget.noteData.length,
      itemBuilder: (context, index) {
        return Dismissible(
          background: Container(
            color: Colors.red,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          key: Key(widget.noteData[index].id),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            if (direction != DismissDirection.endToStart) {
              removeItem.deleteItem(widget.noteData[index], context);
            } else {}
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              bottom: 8,
            ),
            child: ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return NoteDetailScreen(noteItem: widget.noteData[index]);
                  },
                );
              },
              leading: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(70)),
                    color: widget.noteData[index].typeColor),
              ),
              title: Text(
                widget.noteData[index].title,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(widget.noteData[index].content),
            ),
          ),
        );
      },
    );
  }
}
