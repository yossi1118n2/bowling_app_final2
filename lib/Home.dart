
import 'package:flutter/material.dart';

//自作ページ
import 'package:bowling_app_final2/GamePage.dart';
import 'package:bowling_app_final2/HistoryPage.dart';
import 'package:bowling_app_final2/TopPage.dart';
import 'package:bowling_app_final2/SettingPage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //選んだやつのindex
  int _selectedIndex = 0;


  var _pages = <Widget>[
    TopPage(),
    GamePage(),
    HistoryPage(),
    SettingPage(),
  ];


  //ボタンがtapされた時の設定
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Column(
  // children: [
  // Text(
  // "indexNum: $_selectedIndex",
  // style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
  // ),
  //
  // ],
  // ),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home),
            label: 'Top',
            tooltip: "トップページを表示",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.outlet),
            activeIcon: Icon(Icons.outlet),
            label: 'Game',
            tooltip: "進行中のゲームを表示",
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            activeIcon: Icon(Icons.history),
            label: 'History',
            tooltip: "過去の対戦のデータ",
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            activeIcon: Icon(Icons.settings_accessibility),
            label: 'Settings',
            tooltip: "設定を表示",
            backgroundColor: Colors.pink,
          ),
        ],
        type: BottomNavigationBarType.shifting,
        // ここで色を設定していても、shiftingにしているので
        // Itemの方のbackgroundColorが勝ちます。
        backgroundColor: Colors.red,
        enableFeedback: true,
        // IconTheme系統の値が優先されます。
        iconSize: 18,
        // 横向きレイアウトは省略します。
        // landscapeLayout: 省略
        selectedFontSize: 20,
        selectedIconTheme: const IconThemeData(size: 30, color: Colors.green),
        selectedLabelStyle: const TextStyle(color: Colors.red),
        // ちなみに、LabelStyleとItemColorの両方を選択した場合、ItemColorが勝ちます。
        selectedItemColor: Colors.black,
        unselectedFontSize: 15,
        unselectedIconTheme: const IconThemeData(size: 25, color: Colors.white),
        unselectedLabelStyle: const TextStyle(color: Colors.purple),
        // IconTheme系統の値が優先されるのでこの値は適応されません。
        unselectedItemColor: Colors.red,
      ),
    );
  }
}
