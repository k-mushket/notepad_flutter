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

  Future<void> addNote(String title, String body) async {
    final newNote = Note()
      ..title = title
      ..body = body
      ..creationDate = DateTime.now();

    await isar.writeTxn(() => isar.notes.put(newNote)); // insert & update
    fetchNotes();
  }

  Future<void> fetchNotes() async {
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
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(
      () => isar.notes.delete(id),
    );
    await fetchNotes();
  }

  Future<Note> createNewNote() async {
    final newNote = Note()
      ..title = ''
      ..body = '';
    await isar.writeTxn(() => isar.notes.put(newNote));
    return newNote;
  }
}
