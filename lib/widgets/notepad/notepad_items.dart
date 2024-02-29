import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:notepad_flutter/models/note.dart';
import 'package:notepad_flutter/widgets/notepad/notepad_button_panel.dart';
import 'package:notepad_flutter/provider/database_provider.dart';
import 'package:notepad_flutter/widgets/notepad/notepad_textfield.dart';
import 'package:notepad_flutter/widgets/notepad/notepad_item.dart';

class NotepadItems extends StatefulWidget {
  const NotepadItems({super.key});

  @override
  State<NotepadItems> createState() => _NotepadItemsState();
}

class _NotepadItemsState extends State<NotepadItems> {
  @override
  void initState() {
    super.initState();
    context.read<DatabaseProvider>().loadNotes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<DatabaseProvider>();
    List<Note> currentNotes = noteDatabase.notes;

    currentNotes.sort(
      (first, second) => second.creationDate.compareTo(first.creationDate),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          const NotepadTextField(),
          const ButtonPanel(),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(1.0),
                topRight: Radius.circular(1.0),
              ),
              child: MasonryGridView.builder(
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  final note = currentNotes[index];
                  final displayDate =
                      DateFormat('dd MMMM HH:mm').format(note.creationDate);
                  return NotepadItem(
                    note: note,
                    displayDate: displayDate,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
