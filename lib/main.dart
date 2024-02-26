import 'package:flutter/material.dart';
import 'package:notepad_flutter/provider/notepad_provider.dart';
import 'package:provider/provider.dart';

import 'package:notepad_flutter/theme/theme_provider.dart';
import 'package:notepad_flutter/services/note_database.dart';
import 'package:notepad_flutter/screens/notepad.dart';

void main() async {
  // initialize note isar db
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NoteDatabase()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => NotepadProvider()),
    ],
    child: Builder(
      builder: (context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Notepad(),
        theme: Provider.of<ThemeProvider>(context).themeData,
      ),
    ),
  ));
}
