import 'dart:convert';

AuthUser authUserFromJson(String str) => AuthUser.fromJson(json.decode(str));

String authUserToJson(AuthUser data) => json.encode(data.toJson());

class AuthUser {
  AuthUser({
    required this.username,
    required this.email,
    required this.phone,
    required this.address,
    required this.image,
  });

  final String? username;
  final String? email;
  final String? phone;
  final String? address;
  final String? image;

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      username: json["username"],
      email: json["email"],
      phone: json["phone"],
      address: json["address"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "phone": phone,
        "address": address,
        "image": image,
      };

  @override
  String toString() {
    return "$username, $email, $phone, $address, $image, ";
  }
}
