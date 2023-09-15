import 'package:flutter/material.dart';
import 'package:someapp/screens/notescreens/add_note_sheet.dart';
import 'package:someapp/widgets/notewidgets/note_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.centerLeft,
            child: const Text('Note')),
          actions: [
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.search),
                label: const Text('Search'))
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(150),
            ),
            // color: Colors.amber,
            gradient: LinearGradient(
                colors: [Colors.amber, Colors.amber.withOpacity(0.5)],
                end: Alignment.topRight,
                begin: Alignment.centerLeft),
          ),
          alignment: Alignment.center,
          child: const NoteWidget(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.7),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0))),
          child:
              Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
          onPressed: () async {
            await showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(60),
                  topLeft: Radius.circular(60),
                ),
              ),
              showDragHandle: true,
              context: context,
              builder: (context) => const AddNote(),
            );
          },
        ));
  }
}
