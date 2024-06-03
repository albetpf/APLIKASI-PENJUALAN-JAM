import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/popular_products.dart';
import 'components/home_header.dart';
import 'components/special_offers.dart';
import 'components/navbar.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 24),  // Increased padding
          child: Column(
            children: [
              SizedBox(
                height: 200,  // Increased height to accommodate larger banner
                child: HomeHeader(),  // Assuming HomeHeader contains the shopping cart widget
              ),
              SpecialOffers(),
              SizedBox(height: 30),  // Increased spacing
              PopularProducts(),  // Removed height parameter, handled within PopularProducts itself
              SizedBox(height: 30),  // Increased spacing
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),  // Assume NavBar has been adjusted for a larger display
    );
  }
}
