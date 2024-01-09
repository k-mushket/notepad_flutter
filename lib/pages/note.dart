import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:notepad_flutter/models/note.dart';
import 'package:notepad_flutter/models/note_database.dart';

class NotePage extends StatefulWidget {
  final Note? note;

  NotePage({Key? key, this.note}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late final TextEditingController textController;
  late final NoteDatabase noteDatabase;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.note?.text ?? '');
    noteDatabase = context.read<NoteDatabase>();
  }

  @override
  void dispose() {
    if (!isSaved) {
      saveNote();
    }
    super.dispose();
  }

  Future<void> saveNote() async {
    final text = textController.text;
    if (text.isNotEmpty && !isSaved) {
      if (widget.note == null) {
        await noteDatabase.addNote(text);
      } else {
        await noteDatabase.updateNote(widget.note!.id, text);
      }
      isSaved = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward),
          ),
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              saveNote();
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '${DateFormat('dd MMMM HH:mm').format(now)}'
                  '\u0009|\u0009'
                  '${textController.text.length} character',
                ),
              ],
            ),
            TextField(
              controller: textController,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Start typing',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
