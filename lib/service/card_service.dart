import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CartService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cart.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE cart (id TEXT PRIMARY KEY, name TEXT, price INTEGER, quantity INTEGER, image BLOB)",
        );
      },
    );
  }

  // Add product to cart
  Future<void> addToCart(Map<String, dynamic> product) async {
    final db = await database;
    final existingProduct = await db.query("cart", where: "id = ?", whereArgs: [product['_id']]);

    if (existingProduct.isNotEmpty) {
      // Update quantity if product already exists
      int currentQty = existingProduct.first['quantity'] as int;
      await db.update(
        "cart",
        {"quantity": currentQty + 1},
        where: "id = ?",
        whereArgs: [product['_id']],
      );
    } else {
      await db.insert(
        "cart",
        {
          "id": product['_id'],
          "name": product['name'],
          "price": product['price'],
          "quantity": 1,
          "image": product['itemImage']?['data'], // Assuming image is stored in Uint8List
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // Remove product from cart
  Future<void> removeFromCart(String productId) async {
    final db = await database;
    await db.delete("cart", where: "id = ?", whereArgs: [productId]);
  }

  // Get all products from cart
  Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await database;
    return db.query("cart");
  }

  // Update quantity of a product
  Future<void> updateQuantity(String productId, int quantity) async {
    final db = await database;
    if (quantity > 0) {
      await db.update(
        "cart",
        {"quantity": quantity},
        where: "id = ?",
        whereArgs: [productId],
      );
    } else {
      await removeFromCart(productId);
    }
  }

  // Check if product is in cart
  Future<bool> isProductInCart(String productId) async {
    final db = await database;
    final result = await db.query("cart", where: "id = ?", whereArgs: [productId]);
    return result.isNotEmpty;
  }
}
