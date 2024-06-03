import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/cart/components/cart_card.dart';
import 'package:shop_app/screens/cart/components/check_out_card.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/SQLite/sqlite.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Cart> demoCarts = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    final dbHelper = DatabaseHelper.instance;
    List<Cart> cartItems = await dbHelper.getCartItems();
    setState(() {
      demoCarts = cartItems;
    });
  }

  double calculateTotalPrice() {
    double total = 0.0;
    for (var cart in demoCarts) {
      total += cart.product.price * cart.quantity;
    }
    return total;
  }

  void _incrementQuantity(int index) {
    setState(() {
      demoCarts[index].quantity++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "Your Cart",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "${demoCarts.length} items",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
      body: demoCarts.isEmpty
          ? Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: demoCarts.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    key: Key(demoCarts[index].product.id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) async {
                      final dbHelper = DatabaseHelper.instance;
                      await dbHelper.deleteCartItem(demoCarts[index].product.id);
                      setState(() {
                        demoCarts.removeAt(index);
                      });
                    },
                    background: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const Spacer(),
                          SvgPicture.asset("assets/icons/Trash.svg"),
                        ],
                      ),
                    ),
                    child: CartCard(cart: demoCarts[index], onIncrement: () => _incrementQuantity(index)),
                  ),
                ),
              ),
            ),
      bottomNavigationBar: CheckoutCard(totalPrice: calculateTotalPrice()),
    );
  }
}
