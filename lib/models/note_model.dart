import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class NoteItem {
  NoteItem(
      {required this.title,
      required this.typeColor,
      required this.content,
      id,
      date})
      : id = id ?? uuid.v4(),
        date = date ?? DateTime.now();
  final String id;
  final String title;
  final Color typeColor;
  final String content;
  final DateTime date;
}
