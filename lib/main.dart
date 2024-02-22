import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:notepad_flutter/theme/theme_provider.dart';
import 'package:notepad_flutter/services/note_database.dart';
import 'package:notepad_flutter/screens/notepad.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NoteDatabase()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
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
