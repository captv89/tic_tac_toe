import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_ui/screens/leaderboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learning_ui/utils/extensions.dart';
import 'package:sizer/sizer.dart';
import 'package:learning_ui/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:learning_ui/utils/db.dart';

int oScore = 0;
int xScore = 0;

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  final int _selectedIndex = 0;

  // 1st player is O
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];

  int filledBoxes = 0;

  String playerX = '';
  String playerO = '';

  @override
  void initState() {
    super.initState();
    _loadPlayerNames();
    _storePlayerNamesToDB();
  }

  _storePlayerNamesToDB() async {
    var existingPlayers = await SqliteService().getLeaders();
    existingPlayers.any((element) => element.values.contains(playerX)) == false
        ? SqliteService().insertPlayer(playerX, 0)
        : null;
    existingPlayers.any((element) => element.values.contains(playerO)) == false
        ? SqliteService().insertPlayer(playerO, 0)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tic Tac Toe'),
            actions: [
              IconButton(
                icon: Icon(
                  themeNotifier.isDarkMode
                      ? Icons.wb_sunny
                      : Icons.nightlight_round,
                ),
                onPressed: () {
                  themeNotifier.isDarkMode
                      ? themeNotifier.isDarkMode = false
                      : themeNotifier.isDarkMode = true;
                },
              ),
            ],
          ),
          drawer: SizedBox(
            width: 60.w,
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45, vertical: 55),
                    curve: Curves.easeIn,
                    duration: const Duration(seconds: 1),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primaryContainer,
                          Theme.of(context).colorScheme.tertiaryContainer,
                        ],
                      ),
                    ),
                    child: Text(
                      'Tic Tac Toe',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.rule),
                    title: Text(
                      'Rules',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text(
                      'Settings',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: Text(
                      'About',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: LayoutBuilder(
            builder: (context, constraints) => Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 2.h),
                        child: Container(
                          width: 40.w,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Player X',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                playerX.toUpperCase(),
                                style: context.titleSmall!.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              Text(
                                xScore.toString(),
                                style: context.titleMedium!.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 2.h),
                        child: Container(
                          width: 40.w,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Player O',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                playerO.toUpperCase(),
                                style: context.titleSmall!.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              Text(
                                oScore.toString(),
                                style: context.titleMedium!.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(20),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      mainAxisExtent: 100.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          var playerName = '';
                          if (oTurn) {
                            playerName = playerO;
                          } else {
                            playerName = playerX;
                          }
                          _tapped(index, playerName);
                        },
                        child: Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer
                                    .withOpacity(0.6),
                                Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer
                                    .withOpacity(0.2),
                              ],
                            ),
                            border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                width: 0.5),
                            shape: BoxShape.rectangle,
                          ),
                          child: Center(
                            child: Text(
                              displayElement[index],
                              style: context.titleLarge!.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                                fontSize: 60,
                                fontFamily: GoogleFonts.indieFlowerTextTheme()
                                    .headline1!
                                    .fontFamily,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 2.h),
                        child: ElevatedButton(
                          onPressed: _clearBoard,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            shadowColor: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          ),
                          child: const Text("Clear XO Board"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 2.h),
                        child: ElevatedButton(
                          onPressed: _clearScoreBoard,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            shadowColor: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          ),
                          child: const Text("Clear Score Board"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Theme.of(context).colorScheme.secondaryContainer,
              primaryColor: Theme.of(context).colorScheme.onSecondaryContainer,
              textTheme: Theme.of(context).textTheme.copyWith(
                    caption: const TextStyle(color: Colors.white),
                  ),
            ),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.leaderboard),
                  label: 'Leaderboard',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              onTap: (index) {
                if (index == 0) {
                  Scores().loadScores().then((value) {
                    xScore = value[0];
                    oScore = value[1];
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GameScreen(),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LeaderBoard(),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _loadPlayerNames() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      playerX = prefs.getString('playerX') ?? 'Player X';
      playerO = prefs.getString('playerO') ?? 'Player O';
    });
  }

  void _tapped(int index, String playerName) {
    setState(() {
      if (oTurn && displayElement[index] == '') {
        // debugPrint('Player O turn');
        displayElement[index] = 'O';
        filledBoxes++;
        _checkWinner(playerName);
        oTurn = false;
      } else if (!oTurn && displayElement[index] == '') {
        // debugPrint('Player X turn');
        displayElement[index] = 'X';
        filledBoxes++;
        _checkWinner(playerName);
        oTurn = true;
      }
    });
  }

  void _checkWinner(String playerName) {
    // debugPrint('Checking for winner');
    // Checking rows
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      _showWinDialog(playerName);
    }
    if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      _showWinDialog(playerName);
    }
    if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      _showWinDialog(playerName);
    }

    // Checking Column
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      _showWinDialog(playerName);
    }
    if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      _showWinDialog(playerName);
    }
    if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      _showWinDialog(playerName);
    }

    // Checking Diagonal
    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      _showWinDialog(playerName);
    }
    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      _showWinDialog(playerName);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Winner',
      desc: '${winner.toUpperCase()} won the game',
      btnOkOnPress: () => _clearBoard(),
      onDismissCallback: (DismissType dismissType) {
        debugPrint('Dialog Dismiss from callback $dismissType');
        _clearBoard();
      },
      buttonsTextStyle:
          TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
      dialogBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
    ).show();

    if (winner == playerO) {
      debugPrint("O is Winner");
      setState(() {
        oScore = oScore + 10;
        debugPrint("O Score is $oScore");
      });
    } else if (winner == playerX) {
      debugPrint("X is Winner");
      setState(() {
        xScore = xScore + 10;
        debugPrint("X Score is $xScore");
      });
    }

    // Save score to shared preferences
    Scores().saveScores(xScore, oScore);

    //  Update Db
    SqliteService().updateLeader(winner, 10);
  }

  void _showDrawDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      title: 'Draw',
      desc: 'Game was a Draw',
      btnOkOnPress: () => _clearBoard(),
      btnOkColor: Colors.blue,
      btnOkText: "Play Again",
      onDismissCallback: (DismissType dismissType) {
        debugPrint('Dialog Dismiss from callback $dismissType');
        _clearBoard();
      },
      buttonsTextStyle:
          TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
      dialogBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
    ).show();

    setState(() {
      xScore = xScore + 5;
      oScore = oScore + 5;
    });

    // Save score to shared preferences
    Scores().saveScores(xScore, oScore);

    //  Update Db
    SqliteService().updateLeader(playerX, 5);
    SqliteService().updateLeader(playerO, 5);
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
    });

    filledBoxes = 0;
  }

  void _clearScoreBoard() {
    Scores().resetScores();
    setState(() {
      xScore = 0;
      oScore = 0;
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
