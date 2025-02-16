class Product {
  final String imagePath; // Path to the local asset image
  final String name;
  final double price;
  final String description;
  final double review;
   int quantity=1;

  Product({
    required this.imagePath,
    required this.name,
    required this.price,
    required this.description,
    required this.review,
    this.quantity=0,
  });
}
