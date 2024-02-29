import 'package:flutter/material.dart';
import 'package:notepad_flutter/models/note.dart';
import 'package:notepad_flutter/screens/note_page.dart';
import 'package:notepad_flutter/provider/database_provider.dart';
import 'package:notepad_flutter/widgets/notepad/notepad_overlay.dart';
import 'package:provider/provider.dart';

class NotepadProvider extends ChangeNotifier {
  bool isPressedNotepadItem = false;

  void changeAppBarIcons() {
    isPressedNotepadItem = !isPressedNotepadItem;
    notifyListeners();
  }

  void deleteNote(int id, BuildContext context) {
    context.read<DatabaseProvider>().deleteNote(id);
    NotepadOverlay.removeOverlay(context);
  }

  
  void openNotePage(Note note, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NotePage(note: note),
      ),
    );
  }
}
