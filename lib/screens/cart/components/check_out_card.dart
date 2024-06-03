import 'package:flutter/material.dart';
import 'package:shop_app/SQLite/sqlite.dart';
import 'package:shop_app/screens/home/home_screen.dart';

class CheckoutCard extends StatefulWidget {
  final double totalPrice;

  const CheckoutCard({
    Key? key,
    required this.totalPrice,
  }) : super(key: key);

  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  bool _paymentConfirmed = false;

  @override
  Widget build(BuildContext context) {
    final isCartEmpty = widget.totalPrice == 0;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: "\$${widget.totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!_paymentConfirmed && !isCartEmpty)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _showConfirmationDialog(context);
                      },
                      child: const Text("Check Out"),
                    ),
                  ),
              ],
            ),
            if (isCartEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Your cart is empty. Please add items before proceeding.",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ),
            if (_paymentConfirmed) ...[
              const SizedBox(height: 20),
              const Text(
                "Payment Successful!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                },
                child: const Text("Back to Home"),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Payment"),
          content: const Text("Are you sure you want to proceed with the payment?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Confirm"),
              onPressed: () {
                _confirmPayment();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmPayment() async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.clearCart();
    setState(() {
      _paymentConfirmed = true;
    });
  }
}
