class Dashboard {
  final bool status;
  final String message;
  final List<PopulerItem> data;

  Dashboard({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    var dataJson = json['data'] as List;
    List<PopulerItem> dataList = dataJson.map((i) => PopulerItem.fromJson(i)).toList();

    return Dashboard(
      status: json['status'],
      message: json['message'],
      data: dataList,
    );
  }
}

class PopulerItem {
  final String nama;
  final double harga;
  final String gambar;
  final int jumlah;
  final String tipe;

  PopulerItem({
    required this.nama,
    required this.harga,
    required this.gambar,
    required this.jumlah,
    required this.tipe,
  });

  factory PopulerItem.fromJson(Map<String, dynamic> json) {
    return PopulerItem(
      nama: json['nama'],
      harga: json['harga'].toDouble(),
      gambar: json['gambar'],
      jumlah: int.parse(json['jumlah'].toString()),
      tipe: json['tipe'],
    );
  }
}

