//import '/model/cats.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dogs.dart';
/*
// catsテーブルのカラム名を設定
const String columnId = '_id';
const String columnName = 'name';
const String columnGender = 'gender';
const String columnBirthday = 'birthday';
const String columnMemo = 'memo';
const String columnCreatedAt = 'createdAt';
*/
const String columnDogId = '_id';
const String columnDogName = 'name';
const String columnDogGender = 'gender';
const String columnDogBirthday = 'birthday';
const String columnDogMemo = 'memo';
const String columnDogCreatedAt = 'createdAt';

// catsテーブルのカラム名をListに設定
const List<String> columns = [
  // columnId,
  // columnName,
  // columnGender,
  // columnBirthday,
  // columnMemo,
  // columnCreatedAt,
  columnDogId,
  columnDogName,
  columnDogGender,
  columnDogBirthday,
  columnDogMemo,
  columnDogCreatedAt,
];

// catsテーブルへのアクセスをまとめたクラス
class DbHelper {
  // DbHelperをinstance化する
  static final DbHelper instance = DbHelper._createInstance();
  static Database? _database;

  DbHelper._createInstance();

  // databaseをオープンしてインスタンス化する
  Future<Database> get database async {
    return _database ??= await _initDB();       // 初回だったら_initDB()=DBオープンする
  }

  // データベースをオープンする
  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'dogs.db');
    //String dogpath = join(await getDatabasesPath(), 'dogs.db');
    // cats.dbのパスを取得する

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,      // cats.dbがなかった時の処理を指定する（DBは勝手に作られる）
    );
  }

  // データベースがなかった時の処理
  Future _onCreate(Database database, int version) async {
    //catsテーブルをcreateする
    /*
    await database.execute('''
      CREATE TABLE cats(
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        gender TEXT,
        birthday TEXT,
        memo TEXT,
        createdAt TEXT
      )
    ''');
    */
    await database.execute('''
      CREATE TABLE dogs(
        _dogid INTEGER PRIMARY KEY AUTOINCREMENT,
        dogname TEXT,
        doggender TEXT,
        dogbirthday TEXT,
        dogmemo TEXT,
        dogcreatedAt TEXT
      )
    ''');
  }
/*
  // catsテーブルのデータを全件取得する
  Future<List<Cats>> selectAllCats() async {
    final db = await instance.database;
    final catsData = await db.query('cats');          // 条件指定しないでcatsテーブルを読み込む

    return catsData.map((json) => Cats.fromJson(json)).toList();    // 読み込んだテーブルデータをListにパースしてreturn
  }
  */

  Future<List<Dogs>> selectAllDogs() async {
    final db = await instance.database;
    final dogsData = await db.query('dogs');          // 条件指定しないでcatsテーブルを読み込む

    return dogsData.map((json) => Dogs.fromJson(json)).toList();    // 読み込んだテーブルデータをListにパースしてreturn
  }
/*
// _idをキーにして1件のデータを読み込む
  Future<Cats> catData(int id) async {
    final db = await instance.database;
    var cat = [];
    cat = await db.query(
      'cats',
      columns: columns,
      where: '_id = ?',                     // 渡されたidをキーにしてcatsテーブルを読み込む
      whereArgs: [id],
    );
    return Cats.fromJson(cat.first);      // 1件だけなので.toListは不要
  }
*/
  Future<Dogs> dogData(int id) async {
    final db = await instance.database;
    var dog = [];
    dog = await db.query(
      'dogs',
      columns: columns,
      where: '_dogid = ?',                     // 渡されたidをキーにしてcatsテーブルを読み込む
      whereArgs: [id],
    );
    return Dogs.fromJson(dog.first);      // 1件だけなので.toListは不要
  }
/*
// データをinsertする
  Future insert(Cats cats) async {
    final db = await database;
    return await db.insert(
        'cats',
        cats.toJson()                         // cats.dartで定義しているtoJson()で渡されたcatsをパースして書き込む
    );
  }
*/
  Future doginsert(Dogs dogs) async {
    final db = await database;
    return await db.insert(
        'dogs',
        dogs.toJson()                         // cats.dartで定義しているtoJson()で渡されたcatsをパースして書き込む
    );
  }
/*
// データをupdateする
  Future update(Cats cats) async {
    final db = await database;
    return await db.update(
      'cats',
      cats.toJson(),
      where: '_id = ?',                   // idで指定されたデータを更新する
      whereArgs: [cats.id],
    );
  }
*/
  Future dogupdate(Dogs dogs) async {
    final db = await database;
    return await db.update(
      'dogs',
      dogs.toJson(),
      where: '_dogid = ?',                   // idで指定されたデータを更新する
      whereArgs: [dogs.dogid],
    );
  }
/*
// データを削除する
  Future delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'cats',
      where: '_id = ?',                   // idで指定されたデータを削除する
      whereArgs: [id],
    );
  }
*/
  Future dogdelete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'dogs',
      where: '_dogid = ?',                   // idで指定されたデータを削除する
      whereArgs: [id],
    );
  }
}