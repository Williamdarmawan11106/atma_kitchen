class Pemesanan {
  final String id;
  final String noNota;
  final double jumlahPesanan;
  final double hargaPesanan;
  final DateTime tanggalPesan;
  final DateTime tanggalDiambil;
  final DateTime tanggalPembayaran;
  final String buktiPembayaran;
  final String statusPesanan;
  final double nominalPembayaran;
  final double tip;
  final String delivery;
  final int poin;
  final int poinDipakai;
  final int idCustomer;
  final int idAlamat;
  final String jarak;
  final double ongkir;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pemesanan({
    required this.id,
    required this.noNota,
    required this.jumlahPesanan,
    required this.hargaPesanan,
    required this.tanggalPesan,
    required this.tanggalDiambil,
    required this.tanggalPembayaran,
    required this.buktiPembayaran,
    required this.statusPesanan,
    required this.nominalPembayaran,
    required this.tip,
    required this.delivery,
    required this.poin,
    required this.poinDipakai,
    required this.idCustomer,
    required this.idAlamat,
    required this.jarak,
    required this.ongkir,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pemesanan.fromJson(Map<String, dynamic> json) {
    return Pemesanan(
      id: json['id'],
      noNota: json['no_nota'],
      jumlahPesanan: json['jumlah_pesanan'],
      hargaPesanan: json['harga_pesanan'],
      tanggalPesan: DateTime.parse(json['tanggal_pesan']),
      tanggalDiambil: DateTime.parse(json['tanggal_diambil']),
      tanggalPembayaran: DateTime.parse(json['tanggal_pembayaran']),
      buktiPembayaran: json['bukti_pembayaran'],
      statusPesanan: json['status_pesanan'],
      nominalPembayaran: json['nominal_pembayaran'],
      tip: json['tip'] != null ? json['tip'].toDouble() : 0.0,
      delivery: json['delivery'],
      poin: json['poin'],
      poinDipakai: json['poin_dipakai'],
      idCustomer: json['id_customer'],
      idAlamat: json['id_alamat'],
      jarak: json['jarak'],
      ongkir: json['ongkir'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
