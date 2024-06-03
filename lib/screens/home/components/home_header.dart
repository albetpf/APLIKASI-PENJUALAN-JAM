import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/discount_banner.dart';
import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: DiscountBanner(),
          ),
          const SizedBox(width: 20),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            size: 32, // Increased size
            press: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
        ],
      ),
    );
  }
}

