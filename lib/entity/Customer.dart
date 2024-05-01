import 'dart:convert';

class Customer {
  String ID_Customer;
  String Nama_Customer;
  DateTime Tanggal_Lahir;
  String Email;
  String Password;
  int Promo_Poin;
  int Saldo;

  Customer ({
    required this.ID_Customer,
    required this.Nama_Customer,
    required this.Tanggal_Lahir,
    required this.Email,
    required this.Password,
    required this.Promo_Poin,
    required this.Saldo,
  });

  factory Customer.fromRawJson(String str) => Customer.fromJson(json.decode(str));
  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        ID_Customer: json['ID_Customer'],
        Nama_Customer: json['Nama_Customer'],
        Tanggal_Lahir: DateTime.parse(json['Tanggal_Lahir']),
        Email: json['Email'],
        Password: json['Password'],
        Promo_Poin: json['Promo_Poin'],
        Saldo: json['Saldo'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'ID_Customer': ID_Customer,
        'Nama_Customer': Nama_Customer,
        'Tanggal_Lahir': DateTime(Tanggal_Lahir.year, Tanggal_Lahir.month, Tanggal_Lahir.day),
        'Email': Email,
        'Password': Password,
        'Promo_Poin': Promo_Poin,
        'Saldo': Saldo,
      };
}