import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Game/NoGame.dart';
import 'Game/ProgressGame.dart';

//TODO: 画面遷移の時にデータをどうやってやり取りするかを考え中
//今のところProviderをうまく使えないかを考えている
//そのための参考記事としてこちらをみている途中
//https://rinoguchi.net/2021/05/share-state-between-other-routes.html
//githubのコードを読んでいる(以下の2つ)
//https://github.com/rinoguchi/study_timer/blob/0238aa987e11e17e48ee7673a529ffe6d9d796cd/lib/main.dart
//https://github.com/rinoguchi/study_timer/blob/0238aa987e11e17e48ee7673a529ffe6d9d796cd/lib/timeKeeper.dart
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

