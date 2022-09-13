import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_ui/widgets/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learning_ui/utils/extensions.dart';
import 'package:sizer/sizer.dart';
import 'package:learning_ui/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:learning_ui/utils/db.dart';
import 'package:learning_ui/widgets/sidebar.dart';

int oScore = 0;
int xScore = 0;

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;

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
          appBar: MyAppBar(title: 'Tic Tac Toe', themeNotifier: themeNotifier),
          drawer: const SideBar(),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: LayoutBuilder(
            builder: (context, constraints) => Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 12.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Container(
                          width: 40.w,
                          height: 80,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Container(
                          width: 40.w,
                          height: 80,
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
                Stack(
                  children: [
                    Container(
                      height: 60.h,
                      width: 95.w,
                      padding: const EdgeInsets.only(top: 10),
                      child: GridView.builder(
                        padding: const EdgeInsets.all(10),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 9,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          // Set the height of the grid item to match the container height
                          mainAxisExtent: 17.h,
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
                                    fontFamily:
                                        GoogleFonts.indieFlowerTextTheme()
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
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SizedBox(
                    height: 10.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: ElevatedButton(
                            onPressed: _clearBoard,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: ElevatedButton(
                            onPressed: _clearScoreBoard,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
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
                ),
              ],
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
    bool winner = false;
    setState(() {
      if (oTurn && displayElement[index] == '') {
        // debugPrint('Player O turn');
        displayElement[index] = 'O';
        filledBoxes++;
        winner = _checkWinner();
        oTurn = false;
      } else if (!oTurn && displayElement[index] == '') {
        // debugPrint('Player X turn');
        displayElement[index] = 'X';
        filledBoxes++;
        winner = _checkWinner();
        oTurn = true;
      }
    });
    if (winner) {
      _showWinDialog(playerName);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  bool _checkWinner() {
    // debugPrint('Checking for winner');

    // Checking rows
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      return true;
    }
    if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      return true;
    }
    if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      return true;
    }

    // Checking Column
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      return true;
    }
    if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      return true;
    }
    if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      return true;
    }

    // Checking Diagonal
    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      return true;
    }
    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      return true;
    }
    return false;
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
