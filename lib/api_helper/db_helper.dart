// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DbHelper {
//   static DbHelper dbHelper = DbHelper._();
//
//   DbHelper._();
//
//   Database? _db;
//
//   Future get database async => _db ?? await initDatabase();
//
//   // Future getDatabase()
//   // async {
//   //   if(_db!=null)
//   //     {
//   //       return _db;
//   //     }
//   //   else
//   //     {
//   //       return await initDatabase();
//   //     }
//   // }
//
//   Future initDatabase() async {
//     final path = await getDatabasesPath();
//     final dbPath = join(path, 'finance.db');
//     _db = await openDatabase(
//       dbPath,
//       version: 1,
//       onCreate: (db, version) async {
//         String sql = '''CREATE TABLE finance(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         amount REAL NOT NULL,
//         isIncome INTEGER NOT NULL,
//         category TEXT);
//         ''';
//         await db.execute(sql);
//       },
//     );
//     return _db;
//   }
//
//   Future insertData() async {
//     Database? db = await database;
//     String sql = '''INSERT INTO finance (amount,isIncome,category)
//     VALUES (1999,0,"Watch");
//     ''';
//     await db!.rawInsert(sql);
//   }
//
//   Future updateData() async {
//     Database? db = await database;
//     String sql = '''UPDATE finance SET category = "Laptop" WHERE amount = 82500;
//     ''';
//     await db!.rawUpdate(sql);
//   }
//
//   Future deleteData() async {
//     Database? db = await database;
//     String sql = '''DELETE FROM finance WHERE id = 22;
//     ''';
//     await db!.rawDelete(sql);
//   }
// }
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper dbHelper = DbHelper._();

  DbHelper._();

  Database? _db;

  Future get database async => _db ?? await initDatabase();

  // Future getDatabase()
  // async {
  //   if(_db!=null)
  //   {
  //     return _db;
  //   }
  //   else
  //   {
  //     return await initDatabase();
  //   }
  // }

  Future initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'finance.db');

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        String sql = '''CREATE TABLE finance(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        isIncome INTEGER NOT NULL,
        category TEXT);
        ''';
        await db.execute(sql);
      },
    );
    return _db;
  }

  Future insertData(double amount, int isIncome, String category) async {
    Database? db = await database;
    String sql = '''INSERT INTO finance (amount,isIncome,category)
    VALUES (?,?,?);
    ''';
    List args = [amount, isIncome, category];
    await db!.rawInsert(sql, args);
  }

  Future<List<Map>> readData() async {
    Database? db = await database;
    String sql = '''SELECT * FROM finance''';
    return await db!.rawQuery(sql);
  }

  Future deleteData(int id) async {
    Database? db = await database;
    String sql = '''DELETE FROM finance WHERE id = ?''';
    List args = [id];
    return await db!.rawDelete(sql, args);
  }

  Future updateData(double amount,int isIncome,String category,int id) async {
    Database? db = await database;
    String sql = '''UPDATE finance SET amount = ?, isIncome = ?, category = ? WHERE id = ?''';
    List args = [amount,isIncome,category,id];
    return await db!.rawDelete(sql, args);
  }
}
