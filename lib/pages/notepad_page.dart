import 'package:flutter/material.dart';
import 'package:notepad_flutter/models/note.dart';
import 'package:notepad_flutter/models/note_database.dart';
import 'package:notepad_flutter/pages/note_page.dart';
import 'package:provider/provider.dart';

class Notepad extends StatefulWidget {
  Notepad({super.key});

  @override
  State<Notepad> createState() => _NotepadState();
}

class _NotepadState extends State<Notepad> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readNotes();
  }

  void createNote() {
    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     content: TextField(
    //       controller: textController,
    //     ),
    //     actions: [
    //       MaterialButton(
    //         onPressed: () {
    //           context.read<NoteDatabase>().addNote(textController.text);
    //           textController.clear();
    //           Navigator.pop(context);
    //         },
    //         child: const Text('Create'),
    //       ),
    //     ],
    //   ),
    // );
    context.read<NoteDatabase>().addNote(textController.text);
    createPage();
  }

  void createPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TextStoragePage(),
      ),
    );
  }

  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('UpdateNote'),
        content: TextField(controller: textController),
        actions: [
          MaterialButton(
            onPressed: () {
              context
                  .read<NoteDatabase>()
                  .updateNote(note.id, textController.text);
              textController.clear();
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: currentNotes.length,
          itemBuilder: (context, index) {
            final note = currentNotes[index];
            return GestureDetector(
              onTap: () => createPage(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Row(
                  children: [
                    Text(note.text),
                    // IconButton(
                    //   onPressed: () => updateNote(note),
                    //   icon: Icon(Icons.edit),
                    // ),
                    // IconButton(
                    //   onPressed: () => deleteNote(note.id),
                    //   icon: Icon(Icons.delete),
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
