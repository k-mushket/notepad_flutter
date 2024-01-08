import 'package:flutter/material.dart';

class TextStoragePage extends StatefulWidget {
  @override
  _TextStoragePageState createState() => _TextStoragePageState();
}

class _TextStoragePageState extends State<TextStoragePage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: _textEditingController,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Enter your note here',
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
