import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wigilabs/users_tab/models/user_model.dart';

class UsersDatabase {
  static final UsersDatabase instance = UsersDatabase._init();
  static Database? _database;
  UsersDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';
    await db.execute('''
CREATE TABLE $usersTable (
  ${UserFields.id} $idType,
  ${UserFields.email} $textType,
  ${UserFields.firstName} $textType,
  ${UserFields.lastName} $textType,
  ${UserFields.avatar} $textType
)
''');
  }

  Future<User> create(User user) async {
    final db = await instance.database;
    final id = await db.insert(usersTable, user.toJson());
    return user.copy(id: id);
  }

  Future<User?> readUser(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      usersTable,
      columns: UserFields.values,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return User.fromJsonDB(maps.first);
    } else {
      return null;
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
