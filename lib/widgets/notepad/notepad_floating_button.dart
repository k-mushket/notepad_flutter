import 'package:flutter/material.dart';

import 'package:notepad_flutter/screens/note_page.dart';

class NotepadFloatingButton extends StatelessWidget {
  const NotepadFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 20),
      child: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        shape: const CircleBorder(),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const NotePage(),
          ),
        ),
        child: const Icon(
          Icons.add,
          size: 36,
        ),
      ),
    );
  }
}
