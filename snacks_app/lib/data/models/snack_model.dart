class Snack {
  final String id;
  final String name;
  final String image;
  final String price;
  final String category;

  Snack({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.category,
  });

  factory Snack.fromJson(Map<String, dynamic> json, String category) {
    return Snack(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: json['p20_99'] ?? '',
      category: category,
    );
  }
}
