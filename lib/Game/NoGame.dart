import 'package:flutter/material.dart';
import 'package:bowling_app_final2/Game/Member.dart';

class NoGame extends StatefulWidget {
  const NoGame({Key? key}) : super(key: key);

  @override
  _NoGameState createState() => _NoGameState();
}

class _NoGameState extends State<NoGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Text('現在開催中のゲームはありません'),
          // Flutter1.22以降のみ
          ElevatedButton.icon(
            icon: const Icon(
              Icons.tag_faces,
              color: Colors.white,
            ),
            label: const Text('ゲームスタート'),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              onPrimary: Colors.white,
            ),
            onPressed: () {
              print('ゲーム開始');
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Member(),
                  )
              );
            },
          ),
        ],
      )
    );
  }
}
