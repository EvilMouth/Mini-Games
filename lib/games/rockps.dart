import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RockPaperScissorsGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _ViewModel(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('RPS Game')),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('游戏规则：1s内输给我'),
              ),
              Center(
                child: Consumer<_ViewModel>(
                  builder: (context, viewModel, child) => IndexedStack(
                    index: viewModel.index,
                    children: _ViewModel.assets
                        .map<Widget>((e) => Image.asset(e))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<_ViewModel>().refresh();
            },
            child: Icon(Icons.refresh),
          ),
        ),
      ),
    );
  }
}

class _ViewModel with ChangeNotifier {
  static const assets = [
    'images/rock.png',
    'images/paper.png',
    'images/scissors.png',
  ];
  int _index = 0;
  int get index => _index;

  _ViewModel() {
    refresh();
  }

  refresh() {
    _index = Random().nextInt(assets.length);
    notifyListeners();
  }
}
