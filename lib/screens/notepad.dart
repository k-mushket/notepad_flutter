import 'package:flutter/material.dart';
import 'package:notepad_flutter/screens/notepad_check.dart';
import 'package:notepad_flutter/widgets/notepad/notepad_appbar.dart';
import 'package:notepad_flutter/widgets/notepad/notepad_f_action_button.dart';
import 'package:notepad_flutter/widgets/notepad/notepad_items.dart';

class Notepad extends StatefulWidget {
  const Notepad({super.key});

  @override
  State<Notepad> createState() => _NotepadState();
}

class _NotepadState extends State<Notepad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NotepadAppBar(),
      floatingActionButton: const NotepadFloatingButton(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: PageView(
        children: const [
          NotepadItems(),
          NotepadCheck(),
        ],
      ),
    );
  }
}
