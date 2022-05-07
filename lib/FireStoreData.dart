import 'package:flutter/material.dart';



class GameDataClass{
  int gameNumber;
  int score;
  int point;
  String team;

  GameDataClass({required this.gameNumber, required this.score, required this.point, required this.team});

}

class PlayerDataClass{
  String name;
  int hdcp;
  List<GameDataClass> gameData;

  PlayerDataClass({required this.name, required this.hdcp, required this.gameData});
}


class MatchDataClass{
  int date;
  String field;
  int numberOfmatchs;
  bool onGoing;
  List<PlayerDataClass> playerData;

  MatchDataClass({required this.date, required this.field, required this.numberOfmatchs, required this.onGoing, required this.playerData});
}

