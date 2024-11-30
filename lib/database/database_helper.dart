import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:stan_horraire/models/favorite.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'favorites.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

Future<void> _onCreate(Database db, int version) async {
  await db.execute('''
    CREATE TABLE favorites(
      osmid_arret TEXT ,
      osmid_ligne TEXT ,
      libelle_arret TEXT ,
      num_ligne TEXT ,
      id_ligne TEXT ,
      libelle_ligne ,  

      Primary Key(osmid_arret, osmid_ligne)
    )
  ''');
}

  Future<void> insertFavorite(Favorite favorite) async {
    final db = await database;
    await db.insert('favorites', favorite.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Favorite>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) {
      return Favorite.fromMap(maps[i]);
    });
  }

  Future<void> deleteFavorite(Favorite favorite) async {
    print("suppression de favoris");
    final db = await database;
    await db.delete('favorites', where: 'osmid_arret = ? and osmid_ligne = ?', whereArgs: [favorite.arret.osmid, favorite.arret.ligne!.osmId]);
  }
}