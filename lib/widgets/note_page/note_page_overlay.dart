import 'package:flutter/material.dart';

class NotePageOverlay {
  static OverlayEntry? _overlayEntry;

  static void showOverlay(BuildContext context) {
    if (_overlayEntry != null) {
      return;
    }
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.waves),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.image_outlined),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.format_paint_outlined),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.check_box_outlined),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.font_download_off),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  static void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
