class Product {
  const Product({required this.name});
  final String name;
}

List<Product> getItems() {
    return [
      const Product(name: 'Eggs'),
      const Product(name: 'Flour'),
      const Product(name: 'Chocolate chips'),
      const Product(name: 'Apple Tea'),
    ];
}
