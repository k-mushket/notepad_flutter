import 'package:flutter/material.dart';

class ButtonPanel extends StatelessWidget {
  const ButtonPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 50,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Colors.black12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'All',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        Container(
          height: 40,
          width: 50,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: IconButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Colors.white38,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.folder_open, color: Colors.orangeAccent),
          ),
        ),
      ],
    );
  }
}
