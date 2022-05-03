

import 'dart:math';

import 'package:flutter/cupertino.dart';
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
  List<String> _ParticipationPlayer = [];
  List<int> _ParticipationHdcp = [];
  List<String> _tempTeamArray = [];
  int _gamecount = 1;

  bool _printPoint = false;
  bool _nextgame = false;
  List<List<int>> _scoreArray = List.generate(0, (_) => List.generate(0, (_) => 0));
  List<int> _tempScoreArray = [];

  List<List<int>> _pointArray = List.generate(0, (_) => List.generate(0, (_) => 0));
  List<int> _tempPointArray = [];

  List<String> _convertArray = ['A','B','C','D','E','F'];

  List<List<String>> _teamArray = List.generate(0, (_) => List.generate(0, (_) => '--'));


  List<bool> _printWinIndex = [];
  List<bool> _printLoseIndex = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(var i=0;i<widget.PlayerItem.length;i++){
      if(widget._isChecked[i] == true){
        _ParticipationPlayer.add(widget.PlayerItem[i]);
        _ParticipationHdcp.add(widget._hdcp[i]);
        _tempScoreArray.add(0);
        _tempPointArray.add(0);
        _tempTeamArray.add('--');
        _printWinIndex.add(false);
        _printLoseIndex.add(false);
      }
    }
  }

  //次のゲームに進むための処理
  void _nextGameFunc(){
    List<int> _onetimetempScoreArray = List.generate(_tempScoreArray.length, (_) => 0);
    List<int> _onetimetempPointArray = List.generate(_tempPointArray.length, (_) => 0);
    List<String> _onetimetempTeamArray = List.generate(_tempTeamArray.length, (_) => '--');

    for(var i=0;i<_tempScoreArray.length;i++){
      _onetimetempScoreArray[i] = _tempScoreArray[i];
      _onetimetempPointArray[i] = _tempPointArray[i];
      _onetimetempTeamArray[i] = _tempTeamArray[i];
     }
    setState(() {
      _scoreArray.add(_onetimetempScoreArray);
      _pointArray.add(_onetimetempPointArray);
      _teamArray.add(_onetimetempTeamArray);
      print(_scoreArray);
      print(_pointArray);
      print(_teamArray);
    });
    //teamのリセット処理
    for(var i=0;i<_tempTeamArray.length;i++){
      _tempTeamArray[i] = '--';
      _tempScoreArray[i] = 0;
      _tempPointArray[i] = 0;
      _printWinIndex[i] = false;
      _printLoseIndex[i] = false;
    }
  }

  void calculatePointFunc(){
    List<int> _numberOfPeople = List.generate(6, (index) => 0);
    int _maxNumberOfPeople = 0;
    //チーム数は6チームが今のところmaxなので6にしている
    List<int> _teamScore = List.generate(6, (index) => 0);
    List<double> _adjustmentTeamScore = List.generate(6, (index) => 0);
    int _winTeamIndex = 0;
    int _loseTeamIndex = 0;
    double _winTeamScore = 0;
    double _loseTeamScore = 99999;
    double _unitPoint = 0;

    int _winLoseMaxNumberOfPeople = 0;
    //各チームの点数を集計
    for(var i=0;i<_ParticipationPlayer.length;i++){
      switch(_tempTeamArray[i]){
        case 'A':
          _teamScore[0] = _teamScore[0] + _tempScoreArray[i] + widget._hdcp[i];
          _numberOfPeople[0] += 1;
          break;
        case 'B':
          _teamScore[1] = _teamScore[1] + _tempScoreArray[i] + widget._hdcp[i];
          _numberOfPeople[1] += 1;
          break;
          break;
        case 'C':
          _teamScore[2] = _teamScore[2] + _tempScoreArray[i] + widget._hdcp[i];
          _numberOfPeople[2] += 1;
          break;
          break;
        case 'D':
          _teamScore[3] = _teamScore[3] + _tempScoreArray[i] + widget._hdcp[i];
          _numberOfPeople[3] += 1;
          break;
          break;
        case 'E':
          _teamScore[4] = _teamScore[4] + _tempScoreArray[i] + widget._hdcp[i];
          _numberOfPeople[4] += 1;
          break;
        case 'F':
          _teamScore[5] = _teamScore[5] + _tempScoreArray[i] + widget._hdcp[i];
          _numberOfPeople[5] += 1;
          break;
      }
    }

    //最大人数のチームを調べる
    _maxNumberOfPeople = _numberOfPeople.reduce(max);

    //最大人数に調整した点数を計算する
    for(var i=0;i<_adjustmentTeamScore.length;i++){
      _adjustmentTeamScore[i] = _teamScore[i].toDouble() * (_maxNumberOfPeople.toDouble() / _numberOfPeople[i].toDouble());
    }

    //勝利チームと敗北チームのindexを求める
    for(var i=0;i<_adjustmentTeamScore.length;i++){
      if(_numberOfPeople[i] > 0){
        if(_adjustmentTeamScore[i] > _winTeamScore){
          _winTeamScore = _adjustmentTeamScore[i];
          _winTeamIndex = i;
        }
        if(_adjustmentTeamScore[i] < _loseTeamScore){
          _loseTeamScore = _adjustmentTeamScore[i];
          _loseTeamIndex = i;
        }
      }
    }

    //勝敗参加チームの最大人数を決定
    _winLoseMaxNumberOfPeople = max(_numberOfPeople[_winTeamIndex],_numberOfPeople[_loseTeamIndex]);

    //単価を計算
    _unitPoint = (_adjustmentTeamScore[_winTeamIndex] - _adjustmentTeamScore[_loseTeamIndex]) *
        (_winLoseMaxNumberOfPeople.toDouble() / _maxNumberOfPeople.toDouble());

    //結果を配列に格納
    for(var i=0;i<_tempPointArray.length;i++){
      if(_tempTeamArray[i] == _convertArray[_winTeamIndex]){
        _tempPointArray[i] = (10) * (_unitPoint *
            (_winLoseMaxNumberOfPeople.toDouble() / _numberOfPeople[_winTeamIndex].toDouble())).ceil();
        _printWinIndex[i] = true;
       }

      if(_tempTeamArray[i] == _convertArray[_loseTeamIndex]){
        _tempPointArray[i] = (-1) * (10) * (_unitPoint *
            (_winLoseMaxNumberOfPeople.toDouble() / _numberOfPeople[_loseTeamIndex].toDouble())).ceil();
        _printLoseIndex[i] = true;
      }
    }

  }

  //値が変更された時に画面を更新する処理
  // void _updateScreenFunc(){
  //   setState(() {
  //     _scoreArray.add(_tempScoreArray);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('参加するメンバーを選択'),
        actions: [
          CupertinoSwitch(
            activeColor: Colors.pink, //ONの色
            trackColor: Colors.blueGrey, //OFFの色
            value: _printPoint,
            onChanged: (value) {
              setState(() {
                _printPoint = value;
              });
            },
          ),
          IconButton(icon: Icon(Icons.save_as), onPressed: () {

          }),
          IconButton(icon: Icon(Icons.restart_alt), onPressed: () {

          }),
        ],
      ),
      body: Container(
        width: 300,
        height: 800,
        child: Column(
          children: [
            Container(
              width: 300,
              height: 30,
              child: Row(
                children: [
                  Text("Players "),
                  SizedBox(
                    width: 240,
                    height: 30,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _ParticipationPlayer.length,
                        itemBuilder: (context, index) {
                          return Text(
                            '${_ParticipationPlayer[index]}\n(${_ParticipationHdcp[index]}) ',
                            style: TextStyle(fontSize: 10),);
                        }
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 300,
              height: 700,
              child: ListView.builder(
                  itemCount: _scoreArray.length,
                  itemBuilder: (context, gameNumber) {
                    return Container(
                      width: 300,
                      height: 30,

                      child: Row(
                        children: [
                          Text("第${gameNumber + 1}ゲーム  "),
                          SizedBox(
                            width: 220,
                            height: 30,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _scoreArray[gameNumber].length,
                                itemBuilder: (context, index) {
                                  if(_printPoint){
                                    return Text(
                                      '${_pointArray[gameNumber][index]}  ',
                                      style: TextStyle(fontSize: 10),
                                    );

                                  }else{
                                    return Text(
                                      '${_scoreArray[gameNumber][index]}  ',
                                      style: TextStyle(fontSize: 10),
                                    );
                                  }
                                }
                            ),
                          ),
                        ],
                      ),
                    );
                    //縦軸にゲームnombuer,横軸にplayer名
                    //floating buttonを押したらポップアップ
                    //ポップアップの画面切り替えの仕方を調べる必要がある
                  }
              ),
            ),
          ],
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
                  height: 600,
                  width: 200,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 400,
                        width: 200,
                        child: ListView.builder(
                            itemCount: _ParticipationPlayer.length,
                            itemBuilder: (context,index){
                              return Row(
                                children: [
                                  Text("${_ParticipationPlayer[index]} (${_ParticipationHdcp[index]})"),
                                  Flexible(
                                      child: TextField(
                                        decoration:InputDecoration(
                                            border: OutlineInputBorder()
                                        ),
                                        enabled:true,
                                        maxLength: 3,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        onChanged: (score){
                                            _tempScoreArray[index]= int.parse(score);
                                        },

                                      )
                                  ),
                                  StatefulBuilder(
                                      builder: (BuildContext context, StateSetter dropDownState) {
                                        return DropdownButton<String>(
                                          value: _tempTeamArray[index],
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
                                              _tempTeamArray[index] = newValue!;
                                            });
                                          },
                                          items: <String>['--','A', 'B', 'C', 'D','E','F']
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
                              );
                            }
                        ),
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
                  ),
                  ),
                actions: <Widget>[
                  FlatButton(
                      child: Text("OK"),
                      onPressed: (){
                        Navigator.of(context, rootNavigator: true).pop();
                        if(_nextgame == true){
                          calculatePointFunc();
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) {
                              return AlertDialog(
                                title: Text("第${_gamecount}ゲームの結果"),
                                content: Container(
                                  width: 300,
                                  height: 800,
                                  child: Column(
                                    children: [
                                      Text("--win--"),
                                      Container(
                                        width: 300,
                                        height: 200,
                                        child: ListView.builder(
                                            itemCount: _ParticipationPlayer.length,
                                            itemBuilder: (context, index) {
                                              if(_printWinIndex[index]){
                                                return Text(
                                                  '${_ParticipationPlayer[index]}  ${_tempPointArray[index]} ',
                                                  style: TextStyle(fontSize: 10),);
                                              }else{
                                                return Text("--",
                                                  style: TextStyle(fontSize: 10),);
                                              }
                                            }),
                                      ),
                                      Text("--lose--"),
                                      Container(
                                        width: 300,
                                        height: 200,
                                        child: ListView.builder(
                                            itemCount: _ParticipationPlayer.length,
                                            itemBuilder: (context, index) {
                                              if(_printLoseIndex[index]){
                                                return Text(
                                                  '${_ParticipationPlayer[index]}  ${_tempPointArray[index]} ',
                                                  style: TextStyle(fontSize: 10),);
                                              }else{
                                                return Text("--",
                                                  style: TextStyle(fontSize: 10),);
                                              }
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  FlatButton(
                                      child: Text("OK"),
                                      onPressed: (){
                                        _gamecount += 1;
                                        _nextGameFunc();
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
