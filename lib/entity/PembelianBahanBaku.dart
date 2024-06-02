import 'dart:convert';

class PembelianBahanBaku {
  int id;
  int jumlah_bahan_baku;
  double harga_bahan_baku;
  DateTime tanggal_pembelian;
  String nota_pembelian;
  int id_bahan_baku;
  DateTime created_at;
  DateTime updated_at;

  PembelianBahanBaku({
    required this.id,
    required this.jumlah_bahan_baku,
    required this.harga_bahan_baku,
    required this.tanggal_pembelian,
    required this.nota_pembelian,
    required this.id_bahan_baku,
    required this.created_at,
    required this.updated_at,
  });

  factory PembelianBahanBaku.fromRawJson(String str) => PembelianBahanBaku.fromJson(json.decode(str));
  factory PembelianBahanBaku.fromJson(Map<String, dynamic> json) => PembelianBahanBaku(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) ?? 0 : 0,
        jumlah_bahan_baku: json['jumlah_bahan_baku'] != null ? int.tryParse(json['jumlah_bahan_baku'].toString()) ?? 0 : 0,
        harga_bahan_baku: json['harga_bahan_baku'] != null ? double.tryParse(json['harga_bahan_baku'].toString()) ?? 0.0 : 0.0,
        tanggal_pembelian: json['tanggal_pembelian'] != null ? DateTime.parse(json['tanggal_pembelian']) : DateTime.now(),
        nota_pembelian: json['nota_pembelian'] ?? '',
        id_bahan_baku: json['id_bahan_baku'] != null ? int.tryParse(json['id_bahan_baku'].toString()) ?? 0 : 0,
        created_at: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
        updated_at: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'jumlah_bahan_baku': jumlah_bahan_baku,
        'harga_bahan_baku': harga_bahan_baku,
        'tanggal_pembelian': tanggal_pembelian.toIso8601String(),
        'nota_pembelian': nota_pembelian,
        'id_bahan_baku': id_bahan_baku,
        'created_at': created_at.toIso8601String(),
        'updated_at': updated_at.toIso8601String(),
      };
}
