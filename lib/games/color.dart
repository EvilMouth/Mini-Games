import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _ViewModel(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text('Color Game')),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('游戏规则：1s内说出颜色'),
              ),
              Center(
                child: Consumer<_ViewModel>(
                  builder: (context, viewModel, child) => Text(
                    viewModel.text,
                    style: TextStyle(
                      color: viewModel.color,
                      fontSize: 127,
                      fontWeight: FontWeight.bold,
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
  static const List<Map<String, Color>> _colors = [
    {'黑': Colors.black},
    {'红': Colors.red},
    {'黄': Colors.yellow},
    {'蓝': Colors.blue},
    {'绿': Colors.green},
    {'紫': Colors.purple},
    {'橙': Colors.orange},
  ];
  String _text = _colors.first.keys.first;
  String get text => _text;
  Color _color = _colors.last.values.first;
  Color get color => _color;

  _ViewModel() {
    refresh();
  }

  refresh() {
    _text = (_colors.toList()..shuffle()).first.keys.first;
    _color = ((_colors.where((element) => element.keys.first != _text)).toList()
          ..shuffle())
        .first
        .values
        .first;
    notifyListeners();
  }
}
