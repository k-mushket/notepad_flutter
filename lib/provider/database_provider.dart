import 'package:flutter/material.dart';
import 'package:notepad_flutter/models/note.dart';
import 'package:notepad_flutter/services/isar_database.dart';

class DatabaseProvider extends ChangeNotifier {
  final IsarDatabase _dbService = IsarDatabase();
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> loadNotes() async {
    _notes = await _dbService.readNotes();
    notifyListeners();
  }

  Future<void> addNote(String title, String body) async {
    await _dbService.createNote(title, body);
    await loadNotes();
  }

  Future<void> updateNote(int id, String newTitle, String newBody) async {
    await _dbService.updateNote(id, newTitle, newBody);
    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await _dbService.deleteNote(id);
    await loadNotes();
  }
}
