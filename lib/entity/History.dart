import 'dart:convert';

class History {
  int id;
  String nama_produk;
  int jumlah;
  double harga;
  DateTime tanggal_diambil;

  History ({
    required this.id,
    required this.nama_produk,
    required this.jumlah,
    required this.harga,
    required this.tanggal_diambil,
  });

  factory History.fromRawJson(String str) => History.fromJson(json.decode(str));
  factory History.fromJson(Map<String, dynamic> json) => History(
    id: int.parse(json['id'].toString()),
    nama_produk: json['Nama_Produk'],
    jumlah: json['Jumlah'],
    harga: double.parse(json['harga'].toString()),
    tanggal_diambil: DateTime.parse(json['tanggal_diambil']),
  );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id' : id, 
        'nama_produk': nama_produk,
        'jumlah': jumlah,
        'harga': harga,
        'tanggal_diambil': tanggal_diambil.toIso8601String(),
      };
}
