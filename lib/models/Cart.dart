import 'package:shop_app/models/Product.dart';
import 'package:shop_app/SQLite/sqlite.dart';

class Cart {
  final Product product;
  int quantity;

  Cart({required this.product, required this.quantity});
}

List<Cart> demoCarts = [];

Future<void> addToCart(Product product) async {
  final dbHelper = DatabaseHelper.instance;

  final cartItem = demoCarts.firstWhere(
    (item) => item.product.id == product.id,
    orElse: () => Cart(product: product, quantity: 0),
  );

  if (cartItem.quantity == 0) {
    demoCarts.add(Cart(product: product, quantity: 1));
  } else {
    cartItem.quantity++;
  }

  // Add to database
  await dbHelper.insertCartItem(cartItem);
}

Future<void> removeFromCart(Product product) async {
  final dbHelper = DatabaseHelper.instance;

  final cartItem = demoCarts.firstWhere(
    (item) => item.product.id == product.id,
    orElse: () => Cart(product: product, quantity: 0),
  );

  if (cartItem.quantity > 1) {
    cartItem.quantity--;
  } else {
    demoCarts.removeWhere((item) => item.product.id == product.id);
  }

  // Update the quantity in the database or remove if the quantity is zero
  if (cartItem.quantity > 0) {
    await dbHelper.insertCartItem(cartItem);
  } else {
    await dbHelper.deleteCartItem(product.id);
  }
}

Future<void> loadCartItems() async {
  final dbHelper = DatabaseHelper.instance;
  demoCarts = await dbHelper.getCartItems();
}
