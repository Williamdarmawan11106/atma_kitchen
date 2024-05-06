import 'dart:convert';

class User {
  int id;
  String username;
  String email;
  String password;
  DateTime tanggal_lahir;
  int promo_poin;
  double saldo;
  String image;
  String role;
  String active;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.tanggal_lahir,
    required this.promo_poin,
    required this.saldo,
    required this.image,
    required this.role,
    required this.active,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        tanggal_lahir: DateTime.parse(json['tanggal_lahir']),
        promo_poin: json['promo_poin'],
        saldo: double.parse(json['saldo'].toString()),
        image: json['image'],
        role: json['role'],
        active: json['active'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'password': password,
        'tanggal_lahir': DateTime(
            tanggal_lahir.year, tanggal_lahir.month, tanggal_lahir.day),
        'promo_poin': promo_poin,
        'saldo': saldo,
        'image': image,
        'role': role,
        'active': active,
      };
}
