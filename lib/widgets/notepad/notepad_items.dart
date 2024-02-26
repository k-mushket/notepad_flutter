import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:notepad_flutter/provider/notepad_provider.dart';
import 'package:notepad_flutter/widgets/notepad/notepad_item.dart';
import 'package:notepad_flutter/widgets/notepad/notepad_overlay.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

import 'package:notepad_flutter/models/note.dart';
import 'package:notepad_flutter/services/note_database.dart';

class NotepadItems extends StatefulWidget {
  const NotepadItems({super.key});

  @override
  State<NotepadItems> createState() => _NotepadItemsState();
}

class _NotepadItemsState extends State<NotepadItems> {
  @override
  void initState() {
    super.initState();
    context.read<NoteDatabase>().readNotes();
  }

  @override
  void dispose() {
    super.dispose();
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
            onTap: () => Provider.of<NotepadProvider>(context, listen: false)
                .openNotePage(note, context),
            onLongPress: () {
              Vibration.vibrate(
                pattern: [0, 50],
                intensities: [0, 100],
              );
              NotepadOverlay.overlayInstruments(note, context);
              Provider.of<NotepadProvider>(context, listen: false)
                  .changeAppBarIcons();
            },
            child: NotepadItem(
              note: note,
              displayDate: displayDate,
            ),
          );
        },
      ),
    );
  }
}
