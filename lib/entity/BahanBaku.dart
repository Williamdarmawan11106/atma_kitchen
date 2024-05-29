import 'dart:convert';

class BahanBaku {
  int id;
  String nama_bahan_baku;
  double stok_bahan_baku;
  String satuan_bahan_baku;

  BahanBaku({
    required this.id,
    required this.nama_bahan_baku,
    required this.stok_bahan_baku,
    required this.satuan_bahan_baku,
  });

  factory BahanBaku.fromRawJson(String str) => BahanBaku.fromJson(json.decode(str));
  factory BahanBaku.fromJson(Map<String, dynamic> json) => BahanBaku(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) ?? 0 : 0,
        nama_bahan_baku: json['nama_bahan_baku'] ?? '',
        stok_bahan_baku: json['stok_bahan_baku'] != null ? double.tryParse(json['stok_bahan_baku'].toString()) ?? 0.0 : 0.0,
        satuan_bahan_baku: json['satuan_bahan_baku'] ?? '',
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_bahan_baku': nama_bahan_baku,
        'stok_bahan_baku': stok_bahan_baku,
        'satuan_bahan_baku': satuan_bahan_baku,
      };
}
