import 'dart:convert';

class History {
  String ID_Pemesanan;
  String Nama_Produk;
  int Jumlah;
  double Harga;
  DateTime Tanggal_Pesanan;

  History ({
    required this.ID_Pemesanan,
    required this.Nama_Produk,
    required this.Jumlah,
    required this.Harga,
    required this.Tanggal_Pesanan,
  });

  factory History.fromRawJson(String str) => History.fromJson(json.decode(str));
  factory History.fromJson(Map<String, dynamic> json) => History(
    ID_Pemesanan: json['ID_Pemesanan'],
    Nama_Produk: json['Nama_Produk'],
    Jumlah: json['Jumlah'],
    Harga: double.parse(json['Harga'].toString()),
    Tanggal_Pesanan: DateTime.parse(json['Tanggal_Pesanan']),
  );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'ID_Pemesanan' : ID_Pemesanan, 
        'Nama_Produk': Nama_Produk,
        'Jumlah': Jumlah,
        'Harga': Harga,
        'Tanggal_Pesanan': Tanggal_Pesanan.toIso8601String(),
      };
}
