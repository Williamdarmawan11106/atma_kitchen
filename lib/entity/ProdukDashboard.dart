import 'dart:convert';

class ProdukDashboard {
  final List<Produk> produk;
  final List<Hampers> hampers;

  ProdukDashboard({required this.produk, required this.hampers});

  factory ProdukDashboard.fromJson(Map<String, dynamic> json) {
    var produkList = json['produk'] as List;
    var hampersList = json['hampers'] as List;

    List<Produk> produk = produkList.map((i) => Produk.fromJson(i)).toList();
    List<Hampers> hampers = hampersList.map((i) => Hampers.fromJson(i)).toList();

    return ProdukDashboard(
      produk: produk,
      hampers: hampers,
    );
  }
}

class Produk {
  final int id;
  final String namaProduk;
  final double? stok;
  final double? kuota;
  final double harga;
  final String? kategori;
  final String? ukuran;
  final String? deskripsi;
  final String? gambarProduk;
  final String? idPenitip;
  final String? createdAt;
  final String? updatedAt;

  Produk({
    required this.id,
    required this.namaProduk,
    required this.harga,
    this.stok,
    this.kuota,
    this.kategori,
    this.ukuran,
    this.deskripsi,
    this.gambarProduk,
    this.idPenitip,
    this.createdAt,
    this.updatedAt,
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'],
      namaProduk: json['nama_produk'],
      stok: json['stok'] != null ? (json['stok'] as num).toDouble() : null,
      kuota: json['kuota'] != null ? (json['kuota'] as num).toDouble() : null,
      harga: (json['harga'] as num).toDouble(),
      kategori: json['kategori'],
      ukuran: json['ukuran'],
      deskripsi: json['deskripsi'],
      gambarProduk: json['gambar_produk'],
      idPenitip: json['id_penitip'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Hampers {
  final int id;
  final String name;
  final List<DetailHampers> detailHampers;

  Hampers({required this.id, required this.name, required this.detailHampers});

  factory Hampers.fromJson(Map<String, dynamic> json) {
    var detailHampersList = json['detail_hampers'] as List;
    List<DetailHampers> detailHampers = detailHampersList.map((i) => DetailHampers.fromJson(i)).toList();

    return Hampers(
      id: json['id'],
      name: json['name'] ?? "",
      detailHampers: detailHampers,
    );
  }
}

class DetailHampers {
  final int id;
  final Produk produk;

  DetailHampers({required this.id, required this.produk});

  factory DetailHampers.fromJson(Map<String, dynamic> json) {
    return DetailHampers(
      id: json['id'],
      produk: Produk.fromJson(json['produk']),
    );
  }
}
