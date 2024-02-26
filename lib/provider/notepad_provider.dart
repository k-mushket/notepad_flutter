import 'package:flutter/material.dart';

class NotepadProvider extends ChangeNotifier {
  bool isPressedNotepadItem = false;

  void changeAppBarIcons() {
    isPressedNotepadItem = !isPressedNotepadItem;
    notifyListeners();
  }
}
