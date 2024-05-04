import 'dart:convert';

class History {
  String ID_Pemesanan;
  int Jumlah_Pesanan;
  double Harga_Pesanan;
  DateTime Tanggal_Pesanan;
  DateTime Tanggal_Diambil;
  DateTime Tanggal_Pembayaran;
  String Bukti_Pembayaran;
  String Status_Pemesanan;
  int Akumulasi_PromoPoin;
  String ID_Customer;
  String ID_Alamat;
  String ID_PromoPoin;
  String ID_Detail_Pesanan;
  String Pengiriman;
  double Tip;

  History({
    required this.ID_Pemesanan,
    required this.Jumlah_Pesanan,
    required this.Harga_Pesanan,
    required this.Tanggal_Pesanan,
    required this.Tanggal_Diambil,
    required this.Tanggal_Pembayaran,
    required this.Bukti_Pembayaran,
    required this.Status_Pemesanan,
    required this.Akumulasi_PromoPoin,
    required this.ID_Customer,
    required this.ID_Alamat,
    required this.ID_PromoPoin,
    required this.ID_Detail_Pesanan,
    required this.Pengiriman,
    required this.Tip,
  });

  factory History.fromRawJson(String str) => History.fromJson(json.decode(str));
  factory History.fromJson(Map<String, dynamic> json) => History(
        ID_Pemesanan: json['ID_Pemesanan'],
        Jumlah_Pesanan: json['Jumlah_Pesanan'],
        Harga_Pesanan: double.parse(json['Harga_Pesanan'].toString()),
        Tanggal_Pesanan: DateTime.parse(json['Tanggal_Pesanan']),
        Tanggal_Diambil: DateTime.parse(json['Tanggal_Diambil']),
        Tanggal_Pembayaran: DateTime.parse(json['Tanggal_Pembayaran']),
        Bukti_Pembayaran: json['Bukti_Pembayaran'],
        Status_Pemesanan: json['Status_Pemesanan'],
        Akumulasi_PromoPoin: json['Akumulasi_PromoPoin'],
        ID_Customer: json['ID_Customer'],
        ID_Alamat: json['ID_Alamat'],
        ID_PromoPoin: json['ID_PromoPoin'],
        ID_Detail_Pesanan: json['ID_Detail_Pesanan'],
        Pengiriman: json['Pengiriman'],
        Tip: double.parse(json['Tip'].toString()),
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'ID_Pemesanan': ID_Pemesanan,
        'Jumlah_Pesanan': Jumlah_Pesanan,
        'Harga_Pesanan': Harga_Pesanan,
        'Tanggal_Pesanan': Tanggal_Pesanan.toIso8601String(),
        'Tanggal_Diambil': Tanggal_Diambil.toIso8601String(),
        'Tanggal_Pembayaran': Tanggal_Pembayaran.toIso8601String(),
        'Bukti_Pembayaran': Bukti_Pembayaran,
        'Status_Pemesanan': Status_Pemesanan,
        'Akumulasi_PromoPoin': Akumulasi_PromoPoin,
        'ID_Customer': ID_Customer,
        'ID_Alamat': ID_Alamat,
        'ID_PromoPoin': ID_PromoPoin,
        'ID_Detail_Pesanan': ID_Detail_Pesanan,
        'Pengiriman': Pengiriman,
        'Tip': Tip,
      };
}
