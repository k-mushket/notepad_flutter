import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:notepad_flutter/models/note_database.dart';
import 'package:notepad_flutter/pages/notepad_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(
    ChangeNotifierProvider(
      create: ((context) => NoteDatabase()),
      child: MaterialApp(home: Notepad()),
    ),
  );
}
