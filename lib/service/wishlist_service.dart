import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

class WishlistService {
  static Database? _database;

  Future<Database> get _db async {
    if (_database != null) return _database!;

    _database = await _initDb();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'wishlist.db');
    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE wishlist(
            id TEXT PRIMARY KEY,
            name TEXT,
            price INTEGER,
            image BLOB
          )
        ''');
      },
      version: 1,
    );
  }

  // Add item to wishlist
  Future<void> addToWishlist(Map<String, dynamic> product) async {
    final db = await _db;

    await db.insert(
      'wishlist',
      {
        'id': product['_id'],
        'name': product['name'],
        'price': product['price'],
        'image': json.encode(product['itemImage']['data']),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Remove item from wishlist
  Future<void> removeFromWishlist(String productId) async {
    final db = await _db;

    await db.delete(
      'wishlist',
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  // Get all wishlist items
  Future<List<Map<String, dynamic>>> getWishlist() async {
    final db = await _db;

    return await db.query('wishlist');
  }
}
