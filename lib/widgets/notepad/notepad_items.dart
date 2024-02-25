import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

import 'package:notepad_flutter/models/note.dart';
import 'package:notepad_flutter/screens/note_page.dart';
import 'package:notepad_flutter/services/note_database.dart';

class NotepadItems extends StatefulWidget {
  const NotepadItems({super.key});

  @override
  State<NotepadItems> createState() => _NotepadItemsState();
}

class _NotepadItemsState extends State<NotepadItems> {
  static OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    context.read<NoteDatabase>().readNotes();
  }

  void _deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _openNotePage(Note note) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NotePage(note: note),
      ),
    );
  }

  Future<void> _overlayInstruments(Note note) async {
    if (_overlayEntry != null) {
      return;
    }
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        width: MediaQuery.of(context).size.width,
        child: Container(
          color: Colors.white,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    child: Column(
                      children: [Icon(Icons.lock_outline), Text('Hide')],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    child: Column(
                      children: [Icon(Icons.arrow_upward), Text('Pin')],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.exit_to_app_outlined),
                        Text('Move to')
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.delete_outline),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> currentNotes = noteDatabase.currentNotes;

    currentNotes.sort(
      (first, second) => second.creationDate.compareTo(first.creationDate),
    );

    return Container(
      padding: const EdgeInsets.all(10),
      child: MasonryGridView.builder(
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: currentNotes.length,
        itemBuilder: (context, index) {
          final note = currentNotes[index];
          final displayDate =
              DateFormat('dd MMMM HH:mm').format(note.creationDate);
          return GestureDetector(
            onTap: () => _openNotePage(note),
            onLongPress: () {
              Vibration.vibrate(
                pattern: [0, 50],
                intensities: [0, 100],
              );
              _overlayInstruments(note);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white38,
              ),
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title.isEmpty ? note.body : note.title,
                    maxLines: 1,
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
                    (note.title.isEmpty & note.body.isNotEmpty) ||
                            (note.title.isNotEmpty & note.body.isEmpty)
                        ? 'No text'
                        : note.body,
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
          );
        },
      ),
    );
  }
}
