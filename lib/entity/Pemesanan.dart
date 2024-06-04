import 'dart:convert';

class Pemesanan {
  final int? id;
  final String? noNota;
  final double? jumlahPesanan;
  final double? hargaPesanan;
  final DateTime? tanggalPesan;
  final DateTime? tanggalDiambil;
  final DateTime? tanggalPembayaran;
  final String? buktiPembayaran;
  final String? statusPesanan;
  final double? nominalPembayaran;
  final double? tip;
  final String? delivery;
  final int? poin;
  final int? poinDipakai;
  final int? idCustomer;
  final int? idAlamat;
  final String? jarak;
  final double? ongkir;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? namaProduk;
  final double? jumlah;

  Pemesanan({
    this.id,
    this.noNota,
    this.jumlahPesanan,
    this.hargaPesanan,
    this.tanggalPesan,
    this.tanggalDiambil,
    this.tanggalPembayaran,
    this.buktiPembayaran,
    this.statusPesanan,
    this.nominalPembayaran,
    this.tip,
    this.delivery,
    this.poin,
    this.poinDipakai,
    this.idCustomer,
    this.idAlamat,
    this.jarak,
    this.ongkir,
    this.createdAt,
    this.updatedAt,
    this.namaProduk,
    this.jumlah,
  });

  factory Pemesanan.fromJson(Map<String, dynamic> json) {
    print('Parsing order: $json');
    return Pemesanan(
      id: json['id'] != null ? int.parse(json['id'].toString()) : null,
      noNota: json['no_nota'],
      jumlahPesanan: json['jumlah_pesanan'] != null ? double.parse(json['jumlah_pesanan'].toString()) : null,
      hargaPesanan: json['harga_pesanan'] != null ? double.parse(json['harga_pesanan'].toString()) : null,
      tanggalPesan: json['tanggal_pesan'] != null ? DateTime.parse(json['tanggal_pesan']) : null,
      tanggalDiambil: json['tanggal_diambil'] != null ? DateTime.parse(json['tanggal_diambil']) : null,
      tanggalPembayaran: json['tanggal_pembayaran'] != null ? DateTime.parse(json['tanggal_pembayaran']) : null,
      buktiPembayaran: json['bukti_pembayaran'],
      statusPesanan: json['status_pesanan'],
      nominalPembayaran: json['nominal_pembayaran'] != null ? double.parse(json['nominal_pembayaran'].toString()) : null,
      tip: json['tip'] != null ? double.parse(json['tip'].toString()) : 0.0,
      delivery: json['delivery'],
      poin: json['poin'],
      poinDipakai: json['poin_dipakai'],
      idCustomer: json['id_customer'],
      idAlamat: json['id_alamat'],
      jarak: json['jarak'],
      ongkir: json['ongkir'] != null ? double.parse(json['ongkir'].toString()) : null,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      namaProduk: json['nama_produk'],
      jumlah: json['jumlah_pesanan'] != null ? double.parse(json['jumlah_pesanan'].toString()) : null,
    );
  }
}
