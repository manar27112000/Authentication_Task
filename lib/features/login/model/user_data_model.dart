class UserModel  {
  final String name;
  final String phone;
  final String image;

  UserModel ({
    required this.name,
    required this.phone,
    required this.image,
  });

  factory UserModel .fromJson(Map<String, dynamic> json) {
    return UserModel (
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? "https://ui-avatars.com/api/?name=إسلام.png",
    );
  }
}
