import 'package:flutter/material.dart';
import 'package:flutterbloc/ui/components/button/login_signup_btn.dart';
import 'package:flutterbloc/ui/layers/screens/orderScreen.dart';

import '../../../model/productModel.dart';
import '../../components/snackbar/overlay.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  bool isfav = false; // Track the selected item index

  // List of products with local asset images
  final List<Product> products = [
    Product(
      imagePath: 'assets/glasses/black.jpeg', // Path to local asset
      name: 'Cat-Eye Sunglasses',
      price: 49.99,
      description: 'Stylish cat-eye sunglasses with UV protection.',
      review: 4.5,
    ),
    Product(
      imagePath: 'assets/glasses/blue.jpeg', // Path to local asset
      name: 'Aviator Sunglasses',
      price: 59.99,
      description: 'Classic aviator sunglasses with polarized lenses.',
      review: 4.7,
    ),
    Product(
      imagePath: 'assets/glasses/grey.jpeg', // Path to local asset
      name: 'Round Sunglasses',
      price: 39.99,
      description: 'Trendy round sunglasses for a retro look.',
      review: 4.2,
    ),
    Product(
      imagePath: 'assets/glasses/pink.jpeg', // Path to local asset
      name: 'Square Sunglasses',
      price: 45.99,
      description: 'Modern square sunglasses with a sleek design.',
      review: 4.0,
    ),
  ];
  void increaseQuantity(int index) {
    setState(() {
      products[index].quantity++;
      getTotalPrice();
    });
  }

  // Function to decrease quantity
  void decreaseQuantity(int index) {
    setState(() {
      if (products[index].quantity > 0) {
        products[index].quantity--;
      }
    });
  }

  double getTotalPrice() {
    return products[selectedIndex].price * products[selectedIndex].quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (isfav) {
                  showAnimatedSnackBar(
                    context: context,
                    message: 'Added to favourite',
                    backgroundColor: const Color.fromARGB(148, 0, 0, 0),
                    textColor: Colors.white,
                  );
                  isfav = false;
                } else {
                  isfav = true;
                  showAnimatedSnackBar(
                    context: context,
                    message: 'removed from favourite',
                    backgroundColor: const Color.fromARGB(148, 0, 0, 0),
                    textColor: Colors.white,
                  );
                }
              });
            },
            icon: isfav
                ? const Icon(Icons.favorite_border_outlined)
                : const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_sharp),
        ),
        centerTitle: true,
        title: const Text('Sun Glasses'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Header Container with the selected product details
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.35,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  products[selectedIndex].imagePath, // Use AssetImage
                  fit: BoxFit.cover,
                  height: 150,
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 5),
                Text(
                  'Price: \$${products[selectedIndex].price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  products[selectedIndex].description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
          _bottomUI(),
        ],
      ),
    );
  }

  Widget _bottomUI() {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color:  Color(0xffDCF6E6),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 20),
              child: Text(
                products[selectedIndex].name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Horizontal ListView
            SizedBox(
              height: 170, // Fixed height for the horizontal list
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Update the selected index and refresh the UI
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      width: 120, // Increased width to accommodate buttons
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: selectedIndex == index
                              ? Colors.black // Highlight selected container
                              : Colors.transparent,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            products[index].imagePath, // Use AssetImage
                            fit: BoxFit.cover,
                            height: 80,
                          ),
                          const SizedBox(height: 5),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => decreaseQuantity(index),
                                icon: const Icon(Icons.remove),
                                iconSize: 16,
                              ),
                              Text(
                                products[index].quantity.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () => increaseQuantity(index),
                                icon: const Icon(Icons.add),
                                iconSize: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Product Details',
                    style: TextStyle(
                      decoration:
                          TextDecoration.underline, // Underline the text
                      decorationColor: Colors.black, // Color of the underline
                      // Style of the underline (dashed, dotted, etc.)
                      decorationThickness: 2.0, // Thickness of the underline
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Product Reviews',
                    style: TextStyle(
                      decoration:
                          TextDecoration.underline, // Underline the text
                      decorationColor: Colors.black, // Color of the underline
                      // Style of the underline (dashed, dotted, etc.)
                      decorationThickness: 2.0, // Thickness of the underline
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      Text(
                        products[selectedIndex].review.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      decoration:
                          TextDecoration.underline, // Underline the text
                      decorationColor: Colors.black, // Color of the underline
                      // Style of the underline (dashed, dotted, etc.)
                      decorationThickness: 2.0, // Thickness of the underline
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '\$${getTotalPrice().toStringAsFixed(2)}',
                    style: const TextStyle(
                      decoration:
                          TextDecoration.underline, // Underline the text
                      decorationColor: Colors.black, // Color of the underline
                      // Style of the underline (dashed, dotted, etc.)
                      decorationThickness: 2.0, // Thickness of the underline
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 12),
              child: Center(
                child: MyButton(
                    text: 'Proceed', // Display total price
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdidasOrderPacking(
                                    context: context,
                                    imgpath: products[selectedIndex].imagePath,
                                    price: products[selectedIndex].price,
                                    quantity: products[selectedIndex].quantity,
                                    itemName: products[selectedIndex].name,
                                  )));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
