import 'package:flutter/material.dart';
import 'package:notepad_flutter/models/note.dart';
import 'package:notepad_flutter/provider/notepad_provider.dart';
import 'package:provider/provider.dart';

class NotepadOverlay {
  static OverlayEntry? _overlayEntry;

  static Future<void> overlayInstruments(
      Note note, BuildContext context) async {
    if (_overlayEntry != null) {
      return;
    }
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        width: MediaQuery.of(context).size.width,
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(15),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    child: Column(
                      children: [Icon(Icons.lock_outline), Text('Hide')],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    child: Column(
                      children: [Icon(Icons.arrow_upward), Text('Pin')],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.exit_to_app_outlined),
                        Text('Move to')
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () =>
                        Provider.of<NotepadProvider>(context, listen: false)
                            .deleteNote(note.id, context),
                    child: const Column(
                      children: [
                        Icon(Icons.delete_outline),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () => removeOverlay(context),
                    child: const Column(
                      children: [
                        Icon(Icons.remove),
                        Text('Remove'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  static void removeOverlay(BuildContext context) {
    _overlayEntry?.remove();
    _overlayEntry = null;
    Provider.of<NotepadProvider>(context, listen: false).changeAppBarIcons();
  }
}
