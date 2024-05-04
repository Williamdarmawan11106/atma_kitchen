import 'dart:convert';

class History {
  String ID_Detail_Pesanan;
  int Jumlah;
  double Harga;
  String ID_Hampers;
  String ID_Produk;
  String ID_Pemesanan;

  History ({
    required this.ID_Detail_Pesanan,
    required this.Jumlah,
    required this.Harga,
    required this.ID_Hampers,
    required this.ID_Produk,
    required this.ID_Pemesanan,
  });

  factory History.fromRawJson(String str) => History.fromJson(json.decode(str));
  factory History.fromJson(Map<String, dynamic> json) => History(
    ID_Detail_Pesanan: json['ID_Detail_Pesanan'],
    Jumlah: json['Jumlah'],
    Harga: double.parse(json['Harga'].toString()),
    ID_Hampers: json['ID_Hampers'],
    ID_Produk: json['ID_Produk'],
    ID_Pemesanan: json['ID_Pemesanan'],
  );


  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'ID_Detail_Pesanan': ID_Detail_Pesanan,
        'Jumlah': Jumlah,
        'Harga': Harga,
        'ID_Hampers': ID_Hampers,
        'ID_Produk': ID_Produk,
        'ID_Pemesanan': ID_Pemesanan,
      };
}