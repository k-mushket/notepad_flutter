import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:notepad_flutter/models/note.dart';

class IsarDatabase {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  Future<void> createNote(String title, String body) async {
    final newNote = Note()
      ..title = title
      ..body = body;
    await isar.writeTxn(() => isar.notes.put(newNote));
  }

  Future<List<Note>> readNotes() async {
    return await isar.notes.where().findAll();
  }

  Future<void> updateNote(int id, String newTitle, String newBody) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.title = newTitle;
      existingNote.body = newBody;
      existingNote.creationDate = DateTime.now();
      await isar.writeTxn(() => isar.notes.put(existingNote));
    }
  }

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
  }
}
