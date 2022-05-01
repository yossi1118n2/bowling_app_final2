

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameHome extends StatefulWidget {
  List<String> PlayerItem;
  List<bool> _isChecked;
  List<int> _hdcp;

  GameHome( this.PlayerItem ,this._isChecked, this._hdcp,{Key? key}) : super(key: key);

  @override
  _GameHomeState createState() => _GameHomeState();
}

class _GameHomeState extends State<GameHome> {
  List<String> ParticipationPlayer = [];
  int _gamecount = 1;

  bool _nextgame = false;

  String dropdownValue = 'A';

  //後でParticipationPlayerと同数のリストにする
  int _score = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(var i=0;i<widget.PlayerItem.length;i++){
      if(widget._isChecked[i] == true){
        ParticipationPlayer.add(widget.PlayerItem[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('参加するメンバーを選択'),
        actions: [
          IconButton(icon: Icon(Icons.save_as), onPressed: () {

          }),
          IconButton(icon: Icon(Icons.restart_alt), onPressed: () {

          }),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: ListView.builder(
            itemCount: ParticipationPlayer.length,
            itemBuilder: (context, index) {
              return Text(ParticipationPlayer[index]);
              //縦軸にゲームnombuer,横軸にplayer名
              //floating buttonを押したらポップアップ
              //ポップアップの画面切り替えの仕方を調べる必要がある
            }
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                insetPadding: EdgeInsets.all(8),
                title: Text("第${_gamecount}ゲーム"),
                content: Container(
                  // child: ListView(
                  //   children: [
                  //
                  //     Text("aaa"),
                  //
                  //     Text('iii'),
                  //   //   for (var i = 0; i < 6; i++)
                  //   //     CheckboxListTile(
                  //   //       title:Text(widget.PlayerItem[i]),
                  //   //       value: widget._isChecked[i],
                  //   //       subtitle: Text('HDCP --  ' + widget._hdcp[i].toString()),
                  //   //       onChanged: (bool? value) {
                  //   //         setState(() {
                  //   //           widget._isChecked[i] = value!;
                  //   //         });
                  //   //       },
                  //   //       controlAffinity: ListTileControlAffinity.leading,
                  //   //     )
                  //   // ],
                  //   // itemExtent: 50,
                  // ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("name(hdcp 10)"),
                          Flexible(
                              child: TextField(
                                decoration:InputDecoration(
                                    border: OutlineInputBorder()
                                ),
                                enabled:true,
                                maxLength: 3,
                                //keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                              )
                          ),
                          StatefulBuilder(
                              builder: (BuildContext context, StateSetter dropDownState) {
                                return DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style: const TextStyle(
                                      color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? newValue) {
                                    dropDownState(() {
                                      dropdownValue = newValue!;
                                    });
                                  },
                                  items: <String>['A', 'B', 'C', 'D']
                                      .map<DropdownMenuItem<String>>((
                                      String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                );
                              }
                          )

                        ],
                      ),
                      Row(
                        children: [
                          Text("name(hdcp 10)"),
                          Flexible(
                              child: TextField(
                                decoration:InputDecoration(
                                    border: OutlineInputBorder()
                                ),
                                enabled:true,
                                maxLength: 3,
                                //keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                              )
                          ),
                          StatefulBuilder(
                              builder: (BuildContext context, StateSetter dropDownState) {
                                return DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style: const TextStyle(
                                      color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? newValue) {
                                    dropDownState(() {
                                      dropdownValue = newValue!;
                                    });
                                  },
                                  items: <String>['A', 'B', 'C', 'D']
                                      .map<DropdownMenuItem<String>>((
                                      String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                );
                              }
                          )

                        ],
                      ),

                      Row(
                        children: [
                          Text("next game?"),
                          StatefulBuilder(
                          builder: (context, setState){
                            return Checkbox(value: _nextgame, onChanged: (value){
                              setState(() {
                                _nextgame = value!;
                              });
                            });
                            }
                          ),
                        ],
                      )
                    ],
                  )

                ),

                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: (){
                        Navigator.of(context, rootNavigator: true).pop();
                        if(_nextgame == true){
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) {
                              return AlertDialog(
                                title: Text("第${_gamecount}ゲームの結果"),
                                content: Text("This is the content"),
                                actions: [
                                  FlatButton(
                                    child: Text("OK"),
                                    onPressed: (){
                                      _gamecount += 1;
                                      Navigator.of(context, rootNavigator: true).pop();
                                    }
                                  ),
                                ],
                              );
                            },
                          );
                        }
                    }
                  ),
                ],
              );
            },
          );
        },
        label: const Text('追加'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
