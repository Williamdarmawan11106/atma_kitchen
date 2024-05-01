import 'dart:convert';

class Presensi {
  String ID_Presensi;
  DateTime Tanggal_Kehadiran;
  int Status_Kehadiran;
  String ID_Employee; 

  Presensi({
    required this.ID_Presensi,
    required this.Tanggal_Kehadiran,
    required this.Status_Kehadiran,
    required this.ID_Employee,
  });

  factory Presensi.fromRawJson(String str) => Presensi.fromJson(json.decode(str));
  factory Presensi.fromJson(Map<String, dynamic> json) => Presensi(
        ID_Presensi: json['ID_Presensi'],
        Tanggal_Kehadiran: DateTime.parse(json['Tanggal_Kehadiran']),
        Status_Kehadiran: json['Status_Kehadiran'],
        ID_Employee: json['ID_Employee'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'ID_Presensi': ID_Presensi,
        'Tanggal_Kehadiran': Tanggal_Kehadiran.toIso8601String(),
        'Status_Kehadiran': Status_Kehadiran,
        'ID_Employee': ID_Employee,
      };
}
