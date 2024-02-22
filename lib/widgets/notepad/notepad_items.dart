import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notepad_flutter/models/note.dart';
import 'package:notepad_flutter/screens/note_page.dart';
import 'package:notepad_flutter/services/note_database.dart';
import 'package:provider/provider.dart';

class NotepadItems extends StatefulWidget {
  const NotepadItems({super.key});

  @override
  State<NotepadItems> createState() => _NotepadItemsState();
}

class _NotepadItemsState extends State<NotepadItems> {
  @override
  void initState() {
    super.initState();
    _readNotes();
  }

  void _openNotePage(Note note) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NotePage(note: note),
      ),
    );
  }

  void _openSpecialInstruments(Note note) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        return Row(
          children: [
            Expanded(
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.abc),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.abc),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.abc),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () => _deleteNote(note.id),
                icon: const Icon(Icons.delete),
              ),
            ),
          ],
        );
      },
    );
  }

  void _readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  void _deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Container(
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
          final displayDate = note.creationDate != null
              ? DateFormat('dd MMMM HH:mm').format(note.creationDate!)
              : DateFormat('dd MMMM HH:mm').format(DateTime.now());
          return GestureDetector(
            onTap: () => _openNotePage(note),
            onLongPress: () => _openSpecialInstruments(note),
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
                    Text(
                      displayDate,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black38),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
