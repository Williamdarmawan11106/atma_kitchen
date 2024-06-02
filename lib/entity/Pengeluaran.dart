import 'dart:convert';

class Pengeluaran {
  int id;
  String nama_pengeluaran;
  double biaya;
  DateTime tanggal_pengeluaran;
  String nota_pengeluaran;
  DateTime created_at;
  DateTime updated_at;

  Pengeluaran({
    required this.id,
    required this.nama_pengeluaran,
    required this.biaya,
    required this.tanggal_pengeluaran,
    required this.nota_pengeluaran,
    required this.created_at,
    required this.updated_at,
  });

  factory Pengeluaran.fromRawJson(String str) => Pengeluaran.fromJson(json.decode(str));
  factory Pengeluaran.fromJson(Map<String, dynamic> json) => Pengeluaran(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) ?? 0 : 0,
        nama_pengeluaran: json['nama_pengeluaran'] ?? '',
        biaya: json['biaya'] != null ? double.tryParse(json['biaya'].toString()) ?? 0.0 : 0.0,
        tanggal_pengeluaran: json['tanggal_pengeluaran'] != null ? DateTime.parse(json['tanggal_pengeluaran']) : DateTime.now(),
        nota_pengeluaran: json['nota_pengeluaran'] ?? '',
        created_at: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
        updated_at: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_pengeluaran': nama_pengeluaran,
        'biaya': biaya,
        'tanggal_pengeluaran': tanggal_pengeluaran.toIso8601String(),
        'nota_pengeluaran': nota_pengeluaran,
        'created_at': created_at.toIso8601String(),
        'updated_at': updated_at.toIso8601String(),
      };
}
