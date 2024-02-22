import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _scrollController = ScrollController();
  bool _showTitleInAppBar = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollController.offset > 50 &&
        !_scrollController.position.outOfRange) {
      if (!_showTitleInAppBar) {
        setState(() {
          _showTitleInAppBar = true;
        });
      }
    } else {
      if (_showTitleInAppBar) {
        setState(() {
          _showTitleInAppBar = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            pinned: true,
            title: _showTitleInAppBar ? const Text("Settings") : null,
            centerTitle: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AnimatedOpacity(
                    opacity: _showTitleInAppBar ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInToLinear,
                    child: Visibility(
                      visible: !_showTitleInAppBar,
                      maintainAnimation: true,
                      maintainSize: true,
                      maintainState: true,
                      child: Text(
                        "Settings",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(children: [Text('Style')]),
                      Row(
                        children: [
                          Expanded(child: Text('Font size')),
                          Expanded(
                            child: Text('Medium'),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text('Sort')),
                          Expanded(
                            child: Text('By modification date'),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text('Layout')),
                          Expanded(
                            child: Text('Layout'),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
