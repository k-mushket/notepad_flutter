import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:notepad_flutter/services/vibration.dart';
import 'package:notepad_flutter/models/note.dart';
import 'package:notepad_flutter/provider/notepad_provider.dart';
import 'package:notepad_flutter/widgets/notepad/notepad_overlay.dart';

class NotepadItem extends StatelessWidget {
  const NotepadItem({
    super.key,
    required this.note,
    required this.displayDate,
  });

  final Note note;
  final String displayDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Provider.of<NotepadProvider>(context, listen: false)
          .openNotePage(note, context),
      onLongPress: () async {
        await VibrationService.vibrate();
        if (context.mounted) {
          NotepadOverlay.overlayInstruments(note, context);
          Provider.of<NotepadProvider>(context, listen: false)
              .changeAppBarIcons();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Provider.of<NotepadProvider>(context).isPressedNotepadItem
              ? Colors.grey.shade400
              : Colors.white38,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                (note.title.isEmpty & note.body.isNotEmpty) ||
                        (note.title.isNotEmpty & note.body.isEmpty)
                    ? 'No text'
                    : note.body,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black38),
              ),
            ),
            Row(
              children: [
                Text(
                  displayDate,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
