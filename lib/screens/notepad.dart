import 'package:flutter/material.dart';
import 'package:notepad_flutter/provider/notepad_provider.dart';
import 'package:provider/provider.dart';
import 'package:notepad_flutter/screens/note_page.dart';
import 'package:notepad_flutter/screens/notepad_check.dart';
import 'package:notepad_flutter/screens/settings.dart';
import 'package:notepad_flutter/widgets/notepad/notepad_items.dart';

class Notepad extends StatefulWidget {
  const Notepad({super.key});

  @override
  State<Notepad> createState() => _NotepadState();
}

class _NotepadState extends State<Notepad> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageChanged);
  }

  void navigateTo(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _pageChanged() {
    int currentPage = _pageController.page!.round();
    if (currentPage != _currentPage) {
      setState(() {
        _currentPage = currentPage;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isPressedNotepadItem = Provider.of<NotepadProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: isPressedNotepadItem.isPressedNotepadItem
            ? Text('1 item selected')
            : null,
        centerTitle: true,
        leading: isPressedNotepadItem.isPressedNotepadItem
            ? IconButton(onPressed: () {}, icon: Icon(Icons.close),)
            : null,
        flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isPressedNotepadItem.isPressedNotepadItem) ...[
                    IconButton(
                      icon: const Icon(Icons.book_outlined),
                      onPressed: () => navigateTo(0),
                      style: IconButton.styleFrom(
                        foregroundColor: _currentPage == 0
                            ? Colors.orangeAccent
                            : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: const Icon(Icons.check_box_outlined),
                      onPressed: () => navigateTo(1),
                      style: IconButton.styleFrom(
                        foregroundColor: _currentPage == 1
                            ? Colors.orangeAccent
                            : Colors.grey,
                      ),
                    ),
                  ]
                ],
              ),
            );
          },
        ),
        actions: [
          if (!isPressedNotepadItem.isPressedNotepadItem) ...[
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
            ),
          ] else ...[
            IconButton(
              icon: const Icon(Icons.checklist_rtl_outlined),
              onPressed: () {},
            ),
          ]
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const NotePage(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: PageView(
        controller: _pageController,
        children: const [
          NotepadItems(),
          NotepadCheck(),
        ],
      ),
    );
  }
}
