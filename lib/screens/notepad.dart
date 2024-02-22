import 'package:flutter/material.dart';
import 'package:notepad_flutter/models/note.dart';
import 'package:notepad_flutter/services/note_database.dart';
import 'package:notepad_flutter/screens/note_page.dart';
import 'package:provider/provider.dart';

class Notepad extends StatefulWidget {
  const Notepad({super.key});

  @override
  State<Notepad> createState() => _NotepadState();
}

class _NotepadState extends State<Notepad> {
  @override
  void initState() {
    super.initState();
    readNotes();
  }

  void openNewNotePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NotePage(),
      ),
    );
  }

  void openNotePage(Note note) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NotePage(note: note),
      ),
    );
  }

  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNewNotePage,
        child: const Icon(Icons.add),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
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
              onTap: () => openNotePage(note),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white38,
                ),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        note.body,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black38),
                      ),
                      IconButton(
                        onPressed: () => deleteNote(note.id),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
