class DetailHampers {
  final String id;
  final int idHampers;
  final int idProduk;
  final int jumlah;

  DetailHampers({
    required this.id,
    required this.idHampers,
    required this.idProduk,
    required this.jumlah,
  });

  factory DetailHampers.fromJson(Map<String, dynamic> json) {
    return DetailHampers(
      id: json['id'],
      idHampers: json['id_hampers'],
      idProduk: json['id_produk'],
      jumlah: json['jumlah'],
    );
  }
}
