import 'dart:async';
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
                  builder: (context, viewModel, child) => Visibility(
                    visible: viewModel.countdownTime == 0,
                    child: IndexedStack(
                      index: viewModel.index,
                      children: _ViewModel.assets
                          .map<Widget>((e) => Image.asset(e))
                          .toList(),
                    ),
                  ),
                ),
              ),
              Center(
                child: Consumer<_ViewModel>(
                  builder: (context, viewModel, child) => Visibility(
                    visible: viewModel.countdownTime != 0,
                    child: Text(
                      viewModel.countdownTime.toString(),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

  Timer _countdownTimer;
  int _countdownTime = 3;
  int get countdownTime => _countdownTime;

  _ViewModel() {
    refresh();
  }

  refresh() {
    _countdownTimer?.cancel();
    _countdownTime = 3;
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        _countdownTime -= 1;
        notifyListeners();
        if (countdownTime == 0) {
          _countdownTimer.cancel();
        }
      },
    );

    _index = Random().nextInt(assets.length);
    notifyListeners();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }
}
