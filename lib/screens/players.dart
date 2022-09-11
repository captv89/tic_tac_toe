// A widget to capture the player names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:learning_ui/screens/game.dart';

class PlayerName extends StatefulWidget {
  const PlayerName({Key? key}) : super(key: key);

  @override
  PlayerNameState createState() => PlayerNameState();
}

class PlayerNameState extends State<PlayerName> {
  final _formKey = GlobalKey<FormState>();
  final _player1Controller = TextEditingController();
  final _player2Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPlayerNames();
  }

  @override
  void dispose() {
    _player1Controller.dispose();
    _player2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Tic Tac Toe'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Enter the player names',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _player1Controller,
                    decoration: const InputDecoration(
                      labelText: 'Player X:',
                      hintText: 'Enter Player X Nickname',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Player X Nickname';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _player2Controller,
                    decoration: const InputDecoration(
                      labelText: 'Player O:',
                      hintText: 'Enter Player O Nickname',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Player O Nickname';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _savePlayerNames().then((v) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GameScreen(),
                            ),
                          );
                        });
                      }
                    },
                    child: const Text('Start Game'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadPlayerNames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _player1Controller.text = prefs.getString('playerX') ?? '';
      _player2Controller.text = prefs.getString('playerO') ?? '';
    });
  }

  Future<void> _savePlayerNames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('playerX', _player1Controller.text);
    prefs.setString('playerO', _player2Controller.text);
  }
}
