class HomeModel {
  final String title;
  final String image;
  final String description;
  final num price;

  HomeModel({
    required this.title,
    required this.image,
    required this.description,
    required this.price,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      title: json['title'],
      image: json['image'],
      description: json['description'],
      price: json['price'],
    );
  }
}
