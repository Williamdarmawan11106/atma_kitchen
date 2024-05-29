import 'dart:convert';

class PenarikanSaldo {
  int id;
  double nominal_penarikan;
  String bank;
  int no_rekening;
  int status;
  DateTime tanggal_penarikan;
  int id_customer;

  PenarikanSaldo({
    required this.id,
    required this.nominal_penarikan,
    required this.bank,
    required this.no_rekening,
    required this.status,
    required this.tanggal_penarikan,
    required this.id_customer,
  });

  factory PenarikanSaldo.fromRawJson(String str) => PenarikanSaldo.fromJson(json.decode(str));

  factory PenarikanSaldo.fromJson(Map<String, dynamic> json) {
    return PenarikanSaldo(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) ?? 0 : 0,
      nominal_penarikan: json['nominal_penarikan'] != null ? double.tryParse(json['nominal_penarikan'].toString()) ?? 0.0 : 0.0,
      bank: json['bank'] ?? '',
      no_rekening: json['no_rekening'] != null ? int.tryParse(json['no_rekening'].toString()) ?? 0 : 0,
      status: json['status'] != null ? int.tryParse(json['status'].toString()) ?? 0 : 0,
      tanggal_penarikan: json['tanggal_penarikan'] != null ? DateTime.tryParse(json['tanggal_penarikan'].toString()) ?? DateTime.now() : DateTime.now(),
      id_customer: json['id_customer'] != null ? int.tryParse(json['id_customer'].toString()) ?? 0 : 0,
    );
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'nominal_penarikan': nominal_penarikan,
        'bank': bank,
        'no_rekening': no_rekening.toString(),
        'status': status,
        'tanggal_penarikan': tanggal_penarikan.toIso8601String(),
        'id_customer': id_customer,
      };
}
