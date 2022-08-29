import 'package:note_app/Models/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

  //creating getter of the database
  /*Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDB();
      return _database;
    }
  }*/

  Future<Database> get database async => _database ??= await initDB();
  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "note_app.db"),
        onCreate: (db, version) async {
      //create the first Table
      await db.execute('''
            CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT,
             title TEXT, 
             body TEXT, 
             creation_date DATE
             )''');
    }, version: 1);
  }

  //Create a function to add notes in db variable
  addNewNote(Notes notes) async {
    final db = await database;
    db.insert("notes", notes.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //Create function to fetch all the notes and return it
  Future<dynamic> getNotes() async {
    final db = await database;
    var res = await db.query("notes");
    if (res.isEmpty) {
      return Null;
    } else {
      var resultMap = res.toList();
      return resultMap.isNotEmpty ? resultMap : Null;
    }
  }
  //Create Method That Delete an Note with their specific Id
  Future<int> deleteNote(int id)async{
    final db = await database;
    int count  = await db.rawDelete('DELETE FROM notes WHERE id = ?', [id]);
    return count; // The Number Of Row Deleted


  }
  //Create Method That Update an Note
   Future<int> updateNote(Notes notes) async {
     final db = await database;
        return await db.update('notes', notes.toMap(),
            where: 'id = ?', 
            whereArgs: [notes.id],
            conflictAlgorithm: ConflictAlgorithm.replace
        );
    }
}
