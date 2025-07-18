class UserModel {
  final String userId;
  final String name;
  final String email;
  final String image;
  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.image,
  });

  // Create a model from Supabase (Map<String, dynamic>)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      image: map['image'] ?? '',
    );
  }

  // Convert the model to JSON (Map<String, dynamic>)
  Map<String, dynamic> toJson() {
    return {'userId': userId, 'name': name, 'email': email, 'image': image};
  }
}
