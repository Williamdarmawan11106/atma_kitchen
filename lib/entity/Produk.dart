import 'dart:convert';

class Produk {
  int id;
  String nama_produk;
  double stok;
  double kuota;
  double harga;
  String kategori;
  String ukuran;
  String deskripsi;
  String gambar_produk;
  int id_penitip;
  DateTime created_at;
  DateTime updated_at;

  Produk({
    required this.id,
    required this.nama_produk,
    required this.stok,
    required this.kuota,
    required this.harga,
    required this.kategori,
    required this.ukuran,
    required this.deskripsi,
    required this.gambar_produk,
    required this.id_penitip,
    required this.created_at,
    required this.updated_at,
  });

  factory Produk.fromRawJson(String str) => Produk.fromJson(json.decode(str));
  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) ?? 0 : 0,
        nama_produk: json['nama_produk'] ?? '',
        stok: json['stok'] != null ? double.tryParse(json['stok'].toString()) ?? 0.0 : 0.0,
        kuota: json['kuota'] != null ? double.tryParse(json['kuota'].toString()) ?? 0.0 : 0.0,
        harga: json['harga'] != null ? double.tryParse(json['harga'].toString()) ?? 0.0 : 0.0,
        kategori: json['kategori'] ?? '',
        ukuran: json['ukuran'] ?? '',
        deskripsi: json['deskripsi'] ?? '',
        gambar_produk: json['gambar_produk'] ?? '',
        id_penitip: json['id_penitip']  ?? '',
        created_at: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
        updated_at: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_produk': nama_produk,
        'stok': stok,
        'kuota': kuota,
        'harga': harga,
        'kategori': kategori,
        'ukuran': ukuran,
        'deskripsi': deskripsi,
        'gambar_produk': gambar_produk,
        'id_penitip': id_penitip,
        'created_at': created_at.toIso8601String(),
        'updated_at': updated_at.toIso8601String(),
      };
}

