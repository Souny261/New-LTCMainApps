import 'package:ltcmainapp/FingerPrintHistory/Models/fingerModels.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  static const myTable = 'sum_fingerprintDB';
  static const Finger = 'Finger';
  static const dateTime = 'dateTime';
  static const inTime = 'inTime';
  static const outTime = 'outTime';
  static const leaveCut = 'leaveCut';
  static const leaveNormal = 'leaveNormal';
  static const leavePerson = 'leavePerson';
  static const OnDay = 'OnDay';
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  Database _database;
  Database _mediaDatabase;
  Future<Database> get database async {
    print("database getter called");
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'fingerDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating chat table");
        await database.execute(
          "CREATE TABLE $myTable ("
          "$dateTime DATETIME,"
          "$Finger TEXT,"
          "$inTime TEXT,"
          "$outTime TEXT,"
          "$leaveCut TEXT,"
          "$leaveNormal TEXT,"
          "$leavePerson TEXT,"
          "$OnDay TEXT"
          ")",
        );
      },
    );
  }

  Future<List<SumFingerModels>> getFingerBloc() async {
    final db = await database;
    final sql = '''SELECT * FROM $myTable
   ''';
    var messages = await db.rawQuery(sql);
    List<SumFingerModels> mesList = List<SumFingerModels>();
    messages.forEach((currentFood) {
      SumFingerModels mes = SumFingerModels.fromMap(currentFood);
      mesList.add(mes);
    });
    return mesList;
  }

  Future<SumFingerModels> insert(SumFingerModels mes) async {
    final db = await database;
    final sql = '''INSERT INTO $myTable
    (
      $dateTime,$Finger,$inTime,$outTime,$leaveCut,$leaveNormal,$leavePerson,$OnDay
    )
    VALUES (?,?,?,?,?,?,?,?)''';
    List<dynamic> params = [
      mes.dateTime,
      mes.Finger,
      mes.inTime,
      mes.outTime,
      mes.leaveCut,
      mes.leaveNormal,
      mes.leavePerson,
      mes.OnDay
    ];
    final result = await db.rawInsert(sql, params);
    print(result);
    return mes;
  }

  Future<int> delete() async {
    final db = await database;
    return await db.delete(myTable);
  }

  Future<int> countMessage() async {
    final db = await database;
    final data = await db.rawQuery('''SELECT COUNT(*) FROM $myTable''');
    int count = data[0].values.elementAt(0);
    int idForNewItem = count++;
    print(idForNewItem);
    return idForNewItem;
  }

  Future<int> update(SumFingerModels food) async {
    final db = await database;
    return await db.update(
      myTable,
      food.toMap(),
      where: "dateTime = ?",
      whereArgs: [food.dateTime],
    );
  }
}
