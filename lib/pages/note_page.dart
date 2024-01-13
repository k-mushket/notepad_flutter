import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:notepad_flutter/models/note.dart';
import 'package:notepad_flutter/models/note_database.dart';

class NotePage extends StatefulWidget {
  final Note? note;

  const NotePage({Key? key, this.note}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late final TextEditingController titleTextController;
  late final TextEditingController bodyTextController;
  late final NoteDatabase noteDatabase;
  String? _originalText;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    titleTextController = TextEditingController(text: widget.note?.title ?? '');
    bodyTextController = TextEditingController(text: widget.note?.body ?? '');
    noteDatabase = context.read<NoteDatabase>();
    _originalText = bodyTextController.text;

    bodyTextController.addListener(
      () {
        setState(() {});
      },
    );
  }

  void clearText() {
    setState(() {
      _originalText = bodyTextController.text;
      bodyTextController.clear();
    });
  }

  void restoreText() {
    if (_originalText != null) {
      setState(() {
        bodyTextController.text = _originalText!;
      });
    }
  }

  @override
  void dispose() {
    if (!isSaved) {
      saveNote();
    }
    super.dispose();
  }

  Future<void> saveNote() async {
    final title = titleTextController.text;
    final body = bodyTextController.text;
    if ((title.isNotEmpty && !isSaved) || (body.isNotEmpty && !isSaved)) {
      if (widget.note == null) {
        await noteDatabase.addNote(title, body);
      } else {
        await noteDatabase.updateNote(widget.note!.id, title, body);
      }
      isSaved = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayDate = widget.note?.creationDate != null
        ? DateFormat('dd MMMM HH:mm').format(widget.note!.creationDate!)
        : DateFormat('dd MMMM HH:mm').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: clearText,
            icon: const Icon(Icons.arrow_back),
          ),
          IconButton(
            onPressed: restoreText,
            icon: const Icon(Icons.arrow_forward),
          ),
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () {
              saveNote();
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleTextController,
              maxLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
                hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            Row(
              children: [
                Text(
                  '$displayDate'
                  '\u0009|\u0009'
                  '${bodyTextController.text.length} character',
                ),
              ],
            ),
            Expanded(
              child: TextField(
                controller: bodyTextController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Start typing',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
