import 'package:flutter/material.dart';
import 'package:notepad_flutter/models/note.dart';
import 'package:notepad_flutter/models/note_database.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  final Note? note;

  NotePage({Key? key, this.note}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late final TextEditingController textController;
  late final NoteDatabase
      noteDatabase; // Додаємо змінну для збереження посилання на NoteDatabase

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.note?.text ?? '');
    noteDatabase =
        context.read<NoteDatabase>(); // Зберігаємо посилання на NoteDatabase
  }

  @override
  void dispose() {
    saveNoteOnExit(); // Виклик функції збереження при закритті сторінки
    super.dispose();
  }

  Future<void> saveNoteOnExit() async {
    final text = textController.text;
    if (text.isNotEmpty) {
      if (widget.note == null) {
        // Якщо нотатка нова, додаємо її
        await noteDatabase.addNote(text);
      } else {
        // Якщо редагуємо існуючу нотатку
        await noteDatabase.updateNote(widget.note!.id, text);
      }
    }
  }

  void saveNote() async {
    await saveNoteOnExit();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          controller: textController,
          maxLines: null,
          expands: true,
          keyboardType: TextInputType.multiline,
        ),
      ),
    );
  }
}
