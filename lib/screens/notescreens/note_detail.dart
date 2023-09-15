import 'package:flutter/material.dart';
import 'package:someapp/models/note_model.dart';

class NoteDetailScreen extends StatefulWidget {
  const NoteDetailScreen({super.key, required this.noteItem});
  final NoteItem noteItem;

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey.withOpacity(0.01),
      child: Container(
        color: Colors.grey.withOpacity(0.01),
        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width * 0.75,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.75 * 0.97,
                width: MediaQuery.of(context).size.width * 0.75 * 0.95,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.yellow, Colors.yellow.withOpacity(0.7)]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.noteItem.title,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.noteItem.content,
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(70)),
                    color: widget.noteItem.typeColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
