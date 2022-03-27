import 'dart:convert';

import 'package:final_630710646/models/quiz_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/game_item.dart';
import 'data.dart';
import 'endgame.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);
  static var invalidanswer = 0;

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int index = 0;
  var _isLoading = false;
  int checkanswer = 1;

  @override
  void initState() {
    super.initState();
    _loadGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildimg(index),
                ],
              ),
            ),
            _buildchoice(index, 0),
            _buildchoice(index, 1),
            _buildchoice(index, 2),
            _buildchoice(index, 3),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(child: _buildtext(checkanswer)),
            const Padding(padding:  EdgeInsets.all(30.0)),
          ],
        ),
        if (_isLoading)
          const Center(
            child: SizedBox(
              width: 40.0,
              height: 40.0,
              child: CircularProgressIndicator(),
            ),
          ),
      ]),
    );
  }

  _loadGame() async {
    setState(() {
      _isLoading = true;
    });
    final url = Uri.parse('https://cpsu-test-api.herokuapp.com/quizzes');
    var response = await http.get(url, headers: {'id': '630710646'});
    setState(() {
      _isLoading = false;
    });

    var json = jsonDecode(response.body);
    var gameItem = GameItem.fromJson(json);

    setState(() {
      for (var element in gameItem.data) {
        var _gameitem = QuizItem.fromJson(element);
        GameData.list.add(_gameitem);
      }
    });
  }

  Widget _buildimg(int index) {
    return Image.network(GameData.list[index].img.toString());
  }

  Widget _buildchoice(int index, int choice) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      shadowColor: Colors.black.withOpacity(0.2),
      child: InkWell(
        onTap: () {
          checkanswers(index, choice);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(GameData.list[index].choice[choice].toString(),style: const TextStyle(
                fontSize: 20.0,
                color: Colors.blue,
              ),),
            ),
          ],
        ),
      ),
    );
  }

  bool checkanswers(int index,int choice) {
    var check = GameData.list[index];
    if(choice == check.answer){
      if(index == GameData.list.length-1){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const endgame()),
        );
      }
      setState(() {
        checkanswer = 2;
        this.index++;
      });
      return true;
    }
    setState(() {
      checkanswer = 3;
      homepage.invalidanswer++;
    });
    return false;
  }
  Text _buildtext(int check){
    if(check == 1){
      return Text('');
    }else if(check == 2){
      return const Text('ถูกต้อง',style:  TextStyle(
        fontSize: 20.0,
        color: Colors.black,
      ),);
    }else{
      return const Text('กรุณาลองใหม่',style:  TextStyle(
        fontSize: 20.0,
        color: Colors.black,
      ),);
    }
  }
}
//List<String>.from(json['choice_list'])
