import 'package:flutter/material.dart';
import 'package:notepad_flutter/services/note_database.dart';
import 'package:notepad_flutter/widgets/notepad/notepad_overlay.dart';
import 'package:provider/provider.dart';

class NotepadProvider extends ChangeNotifier {
  bool isPressedNotepadItem = false;

  void changeAppBarIcons() {
    isPressedNotepadItem = !isPressedNotepadItem;
    notifyListeners();
  }

  void deleteNote(int id, BuildContext context) {
    context.read<NoteDatabase>().deleteNote(id);
    NotepadOverlay.removeOverlay(context);
  }
}
