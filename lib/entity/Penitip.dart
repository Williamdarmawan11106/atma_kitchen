import 'dart:convert';

class Penitip {
  int id;
  String nama_penitip;
  String no_telp;
  DateTime created_at;
  DateTime updated_at;

  Penitip({
    required this.id,
    required this.nama_penitip,
    required this.no_telp,
    required this.created_at,
    required this.updated_at,
  });

  factory Penitip.fromRawJson(String str) => Penitip.fromJson(json.decode(str));
  factory Penitip.fromJson(Map<String, dynamic> json) => Penitip(
        id: json['id'] ?? '',
        nama_penitip: json['nama_penitip'] ?? '',
        no_telp: json['no_telp'] ?? '',
        created_at: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
        updated_at: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_penitip': nama_penitip,
        'no_telp': no_telp,
        'created_at': created_at.toIso8601String(),
        'updated_at': updated_at.toIso8601String(),
      };
}
