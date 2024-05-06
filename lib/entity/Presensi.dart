import 'dart:convert';

class Presensi {
  int id;
  String nama_employee;
  DateTime tanggal_kehadiran;
  int status_kehadiran; 
  

  Presensi({
    required this.id,
    required this.tanggal_kehadiran,
    required this.status_kehadiran,
    required this.nama_employee,
  });

  factory Presensi.fromRawJson(String str) => Presensi.fromJson(json.decode(str));
  factory Presensi.fromJson(Map<String, dynamic> json) => Presensi(
        id: int.parse(json['id'].toString()),
        nama_employee: json['nama_employee'],
        tanggal_kehadiran: DateTime.parse(json['tanggal_kehadiran']),
        status_kehadiran: json['status_kehadiran'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_employee': nama_employee,
        'tanggal_kehadiran': tanggal_kehadiran.toIso8601String(),
        'status_kehadiran': status_kehadiran,
      };
}
