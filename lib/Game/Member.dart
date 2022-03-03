
import 'package:flutter/material.dart';


class Member extends StatefulWidget {
  const Member({Key? key}) : super(key: key);

  @override
  _MemberState createState() => _MemberState();
}

class _MemberState extends State<Member> {
  List<bool> _isChecked = List.filled(6, false);
  List<String> Player = ['澤木', 'せいげん', '有林', '永江', '吉川', 'しゅん'];
  List<int> _hdcp = [0, 5, 21, 21, 6, 20];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('参加するメンバーを選択'),
      ),
      body: Container(
        width: double.infinity,
        child: ListView(
          children: [
            for (var i = 0; i < 6; i++)
              CheckboxListTile(
                title:Text(Player[i]),
                value: _isChecked[i],
                subtitle: Text('HDCP --  ' + _hdcp[i].toString()),
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked[i] = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              )
          ],
          itemExtent: 50,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context).pop();
        },
        label: const Text('ゲーム開始'),
        icon: const Icon(Icons.start),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

