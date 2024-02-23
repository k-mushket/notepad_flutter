import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:notepad_flutter/models/note.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;
  final List<Note> currentNotes = [];

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  Future<void> createNote(String title, String body) async {
    // create a new note object
    final newNote = Note()
      ..title = title
      ..body = body;

    // save to db
    await isar.writeTxn(() => isar.notes.put(newNote));

    // re-read from db
    readNotes();
  }

  Future<void> readNotes() async {
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    notifyListeners();
  }

  Future<void> updateNote(int id, String newTitle, String newBody) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.title = newTitle;
      existingNote.body = newBody;
      existingNote.creationDate = DateTime.now();
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await readNotes();
    }
  }

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(
      () => isar.notes.delete(id),
    );
    await readNotes();
  }
}
