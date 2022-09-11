import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  getDatabasesPath() async {
    //  Get application directory path
    final directory = await getApplicationDocumentsDirectory();
    //  Join the path with the database name
    return join(directory.path, 'database.db');
  }

  initializeDB() async {
    //  Get the path of the database
    final path = await getDatabasesPath();
    //  Open the database
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        //  Create a table
        await db.execute(
          'CREATE TABLE leaders(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, score INTEGER)',
        );
      },
    );
  }

  Future<void> insertPlayer(String player, int score) async {
    final Database db = await initializeDB();

    await db.insert(
      'leaders',
      {'name': player, 'score': score},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getLeaders() async {
    final Database db = await initializeDB();

    return db.query('leaders');
  }

  Future<void> deleteLeader(int id) async {
    final Database db = await initializeDB();

    await db.delete(
      'leaders',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteAllLeaders() async {
    final Database db = await initializeDB();

    await db.delete('leaders');
  }

  Future<void> updateLeader(String player, int increment) async {
    final Database db = await initializeDB();

    // Get the current score of the player
    var playerInfo =
        await db.query('leaders', where: "name = ?", whereArgs: [player]);

    var score = playerInfo[0]['score'].toString();

    var newScore = int.parse(score) + increment;
    // Update the score of the player
    await db.update(
      'leaders',
      {'score': newScore},
      where: "name = ?",
      whereArgs: [player],
    );
  }
}
