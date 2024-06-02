class Resep {
  final String id;
  final double jumlahBahanBaku;
  final int idProduk;
  final int idBahanBaku;
  final DateTime createdAt;
  final DateTime updatedAt;

  Resep({
    required this.id,
    required this.jumlahBahanBaku,
    required this.idProduk,
    required this.idBahanBaku,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Resep.fromJson(Map<String, dynamic> json) {
    return Resep(
      id: json['id'],
      jumlahBahanBaku: json['jumlah_bahan_baku'],
      idProduk: json['id_produk'],
      idBahanBaku: json['id_bahan_baku'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
