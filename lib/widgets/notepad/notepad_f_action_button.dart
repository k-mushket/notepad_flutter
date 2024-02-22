import 'package:flutter/material.dart';
import 'package:notepad_flutter/screens/note_page.dart';

class NotepadFloatingButton extends StatelessWidget {
  const NotepadFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const NotePage(),
        ),
      ),
      child: const Icon(Icons.add),
    );
  }
}
