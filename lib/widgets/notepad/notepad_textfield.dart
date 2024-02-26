import 'package:flutter/material.dart';

class NotepadTextField extends StatelessWidget {
  const NotepadTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: const TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black12,
          prefixIcon: Icon(Icons.search),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 1.0),
          hintText: 'Search notes',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
