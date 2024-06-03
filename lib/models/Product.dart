import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final double rating, price;
  final bool isFavourite, isPopular;
  int quantity;

  Product({
    required this.id,
    required this.images,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
    this.quantity = 1,
  });
}

List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "assets/images/RolexPro.png",
    ],
    title: "Round Black Rolex Analog™",
    price: 100.99,
    description:
        "This sleek and stylish round black Rolex Analog™ watch is the epitome of elegance. It features a high-quality black stainless steel band and a black dial with silver hands and hour markers. Elevate your style with this timeless timepiece.",
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 2,
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    title: "Patek Philippe Calibre 89",
    price: 50.5,
    description:
        "The Patek Philippe Calibre 89 is a legendary timepiece known for its precision and craftsmanship. Featuring a stunning gold case and a luxurious leather strap, this watch exudes sophistication and class. Make a statement with this iconic masterpiece.",
    rating: 4.1,
    isPopular: true,
    isFavourite: true,
  ),
  Product(
    id: 3,
    images: [
      "assets/images/glap.png",
    ],
    title: "Richard Mille Flyback",
    price: 36.55,
    description:
        "Experience the ultimate in luxury with the Richard Mille Flyback watch. This exquisite timepiece boasts unparalleled design and functionality, with its sleek black case and intricate detailing. Elevate your everyday style with this stunning accessory.",
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 4,
    images: [
      "assets/images/RolexGMT.png",
    ],
    title: "Rolex Yacht-Master GMT Master",
    price: 20.20,
    description:
        "Set sail in style with the Rolex Yacht-Master GMT Master. Featuring a durable stainless steel case and a striking black dial, this watch is perfect for the modern adventurer. Whether you're exploring the seas or the city, this timepiece will always keep you on course.",
    rating: 4.1,
    isFavourite: true,
  ),
  Product(
    id: 5,
    images: [
      "assets/images/Luxurygoods.png",
    ],
    title: "Luxury goods Patek Philippe™",
    price: 64.99,
    description:
        "Indulge in luxury with the Patek Philippe™ watch from Luxury goods. Crafted with precision and attention to detail, this exquisite timepiece features a sleek silver case and a minimalist design. Elevate your look with this timeless accessory.",
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
];

class ProductCard extends StatefulWidget {
  final Product product;
  final Function() onPressedAdd;
  final Function() onPressedRemove;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onPressedAdd,
    required this.onPressedRemove,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Implementasi untuk menampilkan detail produk
            },
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${widget.product.id}",
                child: Image.asset(widget.product.images[0]),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            widget.product.title,
            style: TextStyle(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          "\$${widget.product.price}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                widget.onPressedRemove();
                setState(() {
                  if (widget.product.quantity > 0) {
                    widget.product.quantity--;
                  }
                });
              },
              icon: Icon(Icons.remove),
            ),
            Text(
              widget.product.quantity
                  .toString(), // Menampilkan jumlah produk yang dipilih
              style: TextStyle(fontSize: 16),
            ),
            IconButton(
              onPressed: () {
                widget.onPressedAdd();
                setState(() {
                  widget.product.quantity++;
                });
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
