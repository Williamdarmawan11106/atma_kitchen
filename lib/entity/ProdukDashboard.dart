import 'dart:convert';

class ProdukDashboard {
  final bool status;
  final String message;
  final ProdukData data;

  ProdukDashboard({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProdukDashboard.fromJson(Map<String, dynamic> json) {
    return ProdukDashboard(
      status: json['status'],
      message: json['message'],
      data: ProdukData.fromJson(json['data']),
    );
  }
}

class ProdukData {
  final List<Produk> produk;
  final List<Hampers> hampers;

  ProdukData({
    required this.produk,
    required this.hampers,
  });

  factory ProdukData.fromJson(Map<String, dynamic> json) {
    var produkJson = json['produk'] as List;
    List<Produk> produkList = produkJson.map((i) => Produk.fromJson(i)).toList();

    var hampersJson = json['hampers'] as List;
    List<Hampers> hampersList = hampersJson.map((i) => Hampers.fromJson(i)).toList();

    return ProdukData(
      produk: produkList,
      hampers: hampersList,
    );
  }
}

class Produk {
  final int id;
  final String namaProduk;
  final int stok;
  final int kuota;
  final double harga;
  final String kategori;
  final String ukuran;
  final String packaging;
  final String deskripsi;
  final String gambarProduk;
  final int idPenitip;
  final int idHampers;

  Produk({
    required this.id,
    required this.namaProduk,
    required this.stok,
    required this.kuota,
    required this.harga,
    required this.kategori,
    required this.ukuran,
    required this.packaging,
    required this.deskripsi,
    required this.gambarProduk,
    required this.idPenitip,
    required this.idHampers,
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'],
      namaProduk: json['nama_produk'],
      stok: json['stok'],
      kuota: json['kuota'],
      harga: json['harga'].toDouble(),
      kategori: json['kategori'],
      ukuran: json['ukuran'],
      packaging: json['packaging'],
      deskripsi: json['deskripsi'],
      gambarProduk: json['gambar_produk'],
      idPenitip: json['id_penitip'],
      idHampers: json['id_hampers'],
    );
  }
}

class Hampers {
  final int id;
  final String namaHampers;
  final double hargaHampers;
  final String packagingHampers;
  final List<DetailHampers> detailHampers;

  Hampers({
    required this.id,
    required this.namaHampers,
    required this.hargaHampers,
    required this.packagingHampers,
    required this.detailHampers,
  });

  factory Hampers.fromJson(Map<String, dynamic> json) {
    var detailHampersJson = json['detailHampers'] as List;
    List<DetailHampers> detailHampersList = detailHampersJson.map((i) => DetailHampers.fromJson(i)).toList();

    return Hampers(
      id: json['id'],
      namaHampers: json['nama_hampers'],
      hargaHampers: json['harga_hampers'].toDouble(),
      packagingHampers: json['packaging_hampers'],
      detailHampers: detailHampersList,
    );
  }
}

class DetailHampers {
  final int id;
  final int jumlah;
  final Produk produk;

  DetailHampers({
    required this.id,
    required this.jumlah,
    required this.produk,
  });

  factory DetailHampers.fromJson(Map<String, dynamic> json) {
    return DetailHampers(
      id: json['id'],
      jumlah: json['jumlah'],
      produk: Produk.fromJson(json['produk']),
    );
  }
}
