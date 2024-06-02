class DetailPesanan {
  final String id;
  final int jumlah;
  final double harga;
  final int idProduk;
  final int idHampers;
  final int idPemesanan;
  final DateTime createdAt;
  final DateTime updatedAt;

  DetailPesanan({
    required this.id,
    required this.jumlah,
    required this.harga,
    required this.idProduk,
    required this.idHampers,
    required this.idPemesanan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DetailPesanan.fromJson(Map<String, dynamic> json) {
    return DetailPesanan(
      id: json['id'],
      jumlah: json['jumlah'],
      harga: json['harga'],
      idProduk: json['id_produk'],
      idHampers: json['id_hampers'],
      idPemesanan: json['id_pemesanan'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
