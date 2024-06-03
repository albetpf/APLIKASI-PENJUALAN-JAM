import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart' as Components; 
import 'package:shop_app/models/Product.dart';
import '../../details/details_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Popular Products",
            press: () {
              Navigator.pushNamed(context, '/products');  // Updated route
            },
          ),
        ),
        const SizedBox(height: 20), // Added spacing between title and products
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoProducts.length,
                (index) {
                  if (demoProducts[index].isPopular) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Components.ProductCard( // Using alias to resolve the conflict
                        product: demoProducts[index],
                        onPress: () => Navigator.pushNamed(
                          context,
                          DetailsScreen.routeName,  // Updated route
                          arguments: ProductDetailsArguments(
                              product: demoProducts[index]),
                        ),
                      ),
                    );
                  }

                  return const SizedBox.shrink(); // here by default width and height is 0
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
        )
      ],
    );
  }
}
