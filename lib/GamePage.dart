import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Game/NoGame.dart';
import 'Game/ProgressGame.dart';


class GameData extends ChangeNotifier{
  int _gameStatus = 0;

  void changeStatus(int status) {
    _gameStatus = status;
    // 値が変更したことを知らせる
    //  >> UIを再構築する
    notifyListeners();
  }
}

class GamePage extends StatelessWidget {
  var _gameStatuspages = <Widget>[
    NoGame(),
    ProgressGame(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Study Timer', // Webアプリとして実行した際のページタイトル
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider(
          create: (context) => GameData(),
          child: NoGame(),
        ));
  }
}

