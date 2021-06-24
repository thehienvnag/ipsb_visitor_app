class Product {
  bool? isSelected = false;
  final int? id;
  final String? name, description, imageUrl;
  final double? price;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
  });

  @override
  String toString() {
    return '$id,$name,$imageUrl';
  }
}
