import 'dart:convert';

class History {
  String Nama_Produk;
  int Jumlah;
  double Harga;
  DateTime Tanggal_Pesanan;

  History ({
    required this.Nama_Produk,
    required this.Jumlah,
    required this.Harga,
    required this.Tanggal_Pesanan,
  });

  factory History.fromRawJson(String str) => History.fromJson(json.decode(str));
  factory History.fromJson(Map<String, dynamic> json) => History(
    Nama_Produk: json['Nama_Produk'],
    Jumlah: json['Jumlah'],
    Harga: double.parse(json['Harga'].toString()),
    Tanggal_Pesanan: DateTime.parse(json['Tanggal_Pesanan']),
  );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'Nama_Produk': Nama_Produk,
        'Jumlah': Jumlah,
        'Harga': Harga,
        'Tanggal_Pesanan': Tanggal_Pesanan.toIso8601String(),
      };
}
