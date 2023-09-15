import 'package:flutter/material.dart';
import 'package:someapp/models/note_model.dart';
import 'package:someapp/widgets/notewidgets/custom_toggle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/filter_button_provider.dart';
import '../../providers/notedata_provider.dart';

class AddNote extends ConsumerStatefulWidget {
  const AddNote({super.key});

  @override
  ConsumerState<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends ConsumerState<AddNote> {
  final _formKey = GlobalKey<FormState>();
  var _title = '';
  var _note = '';
  void _saveNote() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final noteData = ref.read(filterNoteDataProvider.notifier);
      final filteredColor =
          ref.read(filterButtonProvider.notifier).getColorButton(1);
      final newNote =
          NoteItem(title: _title, typeColor: filteredColor, content: _note);
      noteData.addNote(newNote);
      ref.read(filterButtonProvider.notifier).resetButton(1);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop({
        noteData.filterNoteData(
            ref.read(filterButtonProvider.notifier).getColorButton(0))
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  label: Text(
                    'title',
                    style: TextStyle(
                        color: Color.fromARGB(255, 201, 153, 10),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 and 50 characters.';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _title = newValue!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                minLines: 1,
                maxLines: 3,
                maxLength: 1000,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  label: Text(
                    'note',
                    style: TextStyle(
                        color: Color.fromARGB(255, 201, 153, 10),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1) {
                    return 'Must be more than 1 character.';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _note = newValue!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: FilterButton(flag: 1),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        _saveNote();
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add'))
                ],
              ),
            ],
          )),
    );
  }
}
