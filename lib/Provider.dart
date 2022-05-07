import 'package:bowling_app_final2/FireStoreData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final gameStateProvider = StateProvider((ref) => 0);

final dateTodayProvider = Provider((_){
  int  dateToday = 20220505;
  return dateToday;
} );

final gameStateStreamProvider = StreamProvider((ref){
  //ここを書く
  int  gameStatus = ref.watch(gameStateProvider);
  int dateToday = ref.watch(dateTodayProvider);

  bool isMatchflag = false;



  return FirebaseFirestore.instance.collection('Match').snapshots().map((snapshot) {
    isMatchflag = false;
    final list = snapshot.docs
        .map((doc) => doc.data()['date'])
        .toList();
    // list.sort((a, b) => a.name.compareTo(b.name));
    for(var i=0;i<list.length;i++) {
      print("list-${i}-${list[i]}");

      if(list[i] == dateToday){
        //ゲームが進行中
        ref.watch(gameStateProvider.notifier).state = 1;
        print("試合中${gameStatus}");
        isMatchflag = true;

        // if(doc.get('onGoing') == true){
        //   //ゲームが進行中
        //   _gameStatus = 1;
        //   print("試合中${_gameStatus}");
        //   isMatchflag = true;
        // }else{
        //   //今日のゲームはもう終わっている
        //   _gameStatus = 2;
        //   print("試合終わり");
        //   isMatchflag = true;
        // }
      }
    }
    if(isMatchflag == false){
      ref.watch(gameStateProvider.notifier).state = 0;
      print("データなし");
    }
    print("inmatch${gameStatus}");

    return list;
  });
});

final gameDataStreamProvider = StreamProvider((ref){
  //ここを書く

  var gameList;

  //ここに処理を書いてみる?
  FirebaseFirestore.instance.collection('Match').snapshots()
      .listen((QuerySnapshot snapshot) {
    snapshot.docs.forEach((doc){
      gameList.add(doc);
    });
  });

  print("gamelist${gameList}");
  //ここでFirestoreからのDynamicデータをClassに箱詰めしてReturnするのが良さそう
  return FirebaseFirestore.instance.collection('Match').snapshots().map((snapshot) {
    final list = snapshot.docs.map((doc) => doc.data()['date']).toList();
    // list.sort((a, b) => a.name.compareTo(b.name));
    return list;
  });
});

//
// final changeGameStateProvider = Provider.autoDispose((ref){
//   int _gameStatus = ref.watch(gameStateProvider);
//   print("inchange");
//
//   int date = 20220505;
//   bool isMatchflag = false;
//
//   FirebaseFirestore.instance.collection('Match')
//       .snapshots().listen((QuerySnapshot snapshot) {
//     snapshot.docs.forEach((doc) {
//       if(doc.get('date') == date){
//         if(doc.get('onGoing') == true){
//           //ゲームが進行中
//           _gameStatus = 1;
//           print("試合中${_gameStatus}");
//           isMatchflag = true;
//         }else{
//           //今日のゲームはもう終わっている
//           _gameStatus = 2;
//           print("試合終わり");
//           isMatchflag = true;
//         }
//       }
//       if(isMatchflag == false){
//         _gameStatus = 0;
//         print("データなし");
//       }
//       print("inmatch${_gameStatus}");
//     });
//   });
// });

