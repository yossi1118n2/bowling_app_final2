import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Game/Member.dart';
import 'Game/ProgressGame.dart';


//TODO: 画面遷移の時にデータをどうやってやり取りするかを考え中
//今のところProviderをうまく使えないかを考えている
//そのための参考記事としてこちらをみている途中
//https://rinoguchi.net/2021/05/share-state-between-other-routes.html
//githubのコードを読んでいる(以下の2つ)
//https://github.com/rinoguchi/study_timer/blob/0238aa987e11e17e48ee7673a529ffe6d9d796cd/lib/main.dart
//https://github.com/rinoguchi/study_timer/blob/0238aa987e11e17e48ee7673a529ffe6d9d796cd/lib/timeKeeper.dart

//Changenotifierを継承すると変更可能なデータを渡せる.
class GameData{
  int _gameStatus = 0;


  //現在開催中のmatchがあるかどうかを調べる

  Future<void> isMatchProgress()async {
    //日付を取得(後で書き換える)
    int date = 20220506;
    print("isMatchProgress");

    //firestoreからデータを取得
    FirebaseFirestore.instance.collection('Match')
        .snapshots().listen((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        if(doc.get('date') == date){
          if(doc.get('onGoing') == true){
            //ゲームが進行中
            _gameStatus = 1;
            print("試合中${_gameStatus}");
          }else{
            //今日のゲームはもう終わっている
            _gameStatus = 2;
            print("試合終わり");
          }
        }else{
          //本日はまだ開催されていない
          _gameStatus = 0;
          print("データなし");
        }
      });
    });
    print("inmatch${_gameStatus}");
  }

}

class GamePage extends StatelessWidget {
  int _gameStatus = 0;
  GameData _data = GameData();

  var _gameStatuspages = <Widget>[
    NoGame(),
    ProgressGame(),
    NoGame(),
  ];



  @override
  Widget build(BuildContext context) {
    _data.isMatchProgress();
    print("inbuld-${_data._gameStatus}");

    print("${GameData()._gameStatus}");
    return MaterialApp(
        title: 'Study Timer', // Webアプリとして実行した際のページタイトル
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _gameStatuspages[_data._gameStatus],
    );
  }
}

class NoGame extends StatefulWidget {
  const NoGame({Key? key}) : super(key: key);

  @override
  _NoGameState createState() => _NoGameState();
}

class _NoGameState extends State<NoGame> {
  //データを取得して何かに入れる

  //もしコレクションのタイプがgameならstate配列に格納する

  // //state配列を日付の順番にソートする
  // void _getDataFromeFirebase(){
  //   FirebaseFirestore.instance.collection('users')
  //       .snapshots().listen((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((doc) {
  //       print(doc.get('name'));
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ゲームを選択'),
      ),
      body: Text("現在開催中のゲームはありません"),
      // body: ListView.separated(
      //   padding: EdgeInsets.all(5),
      //   itemBuilder: (BuildContext context, int index){
      //     var sub = state[index];
      //     return GameListItem(
      //         date: sub.date,
      //         field: sub.field,
      //         numberOfGames: sub.numberOfGames,
      //         numberOfPlayers: sub.numberOfPlayers,
      //         onGoing: sub.onGoing,
      //         typeOfCollection: sub.typeOfCollection);
      //   },
      //   separatorBuilder: (BuildContext context, int index) {
      //     return SizedBox(height: 10);
      //   },
      //   itemCount: state.length,
      // ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Member(),
              )
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('New Game'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// class GameListItem extends StatelessWidget{
//   int date;
//   String field;
//   int numberOfGames;
//   int numberOfPlayers;
//   bool onGoing;
//   String typeOfCollection;
//   //引数の{}は名前付き引数を表す.
//   GameListItem({required this.date, required this.field, required this.numberOfGames,required this.numberOfPlayers,required this.onGoing,required this.typeOfCollection});
//
//   @override
//   Widget build(BuildContext context){
//     return ListTile(
//       title: Text('${date} [${numberOfGames} Games][${numberOfPlayers} Plyers]'),
//       subtitle: Text('場所: ${field}'),
//       leading: Icon(Icons.launch,),
//       trailing: Icon(Icons.more_vert),
//     );
//   }
//
// }


