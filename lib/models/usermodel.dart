class UserModel {
  String userId;
  String name;
  int value;

  UserModel({required this.userId, required this.name, this.value = 0});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      name: json['name'],
      value: json['value'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'value': value,
    };
  }
}
