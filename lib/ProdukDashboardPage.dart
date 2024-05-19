import 'package:flutter/material.dart';
import 'package:atma_kitchen/client/ProdukDashboardClient.dart'; 
import 'package:atma_kitchen/entity/ProdukDashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atma Kitchen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProdukDashboardPage(),
    );
  }
}

class ProdukDashboardPage extends StatefulWidget {
  @override
  _ProdukDashboardPageState createState() => _ProdukDashboardPageState();
}

class _ProdukDashboardPageState extends State<ProdukDashboardPage> {
  late Future<ProdukDashboard> futureProdukDashboard;

  @override
  void initState() {
    super.initState();
    futureProdukDashboard = ProdukDashboardClient.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/img/Logo-full.png', width: 100),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to login
            },
            child: Text('Login', style: TextStyle(color: Colors.black)),
          )
        ],
      ),
      body: FutureBuilder<ProdukDashboard>(
        future: futureProdukDashboard,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          }

          var produk = snapshot.data!.data.produk;
          var cakeProducts = produk.where((item) => item.kategori == 'Cake').toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      Text(
                        'CAKE',
                        style: TextStyle(fontSize: 24, color: Color(0xFF222222)),
                      ),
                      Text(
                        'Discovers The Best Cake In The Town!',
                        style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
                      ),
                    ],
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(8.0),
                  itemCount: cakeProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    var item = cakeProducts[index];
                    return Card(
                      child: Column(
                        children: [
                          Image.network(
                            'http://10.0.2.2:8000' + item.gambarProduk, // Adjust the image URL according to your backend setup
                            fit: BoxFit.cover,
                            height: 180,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  item.namaProduk,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Rp ${item.harga.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.shopping_cart),
                                  onPressed: () {
                                    // Handle cart action
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.info),
                                  onPressed: () {
                                    _showProductDetails(
                                      context,
                                      item.id,
                                      item.namaProduk,
                                      item.deskripsi,
                                      'http://10.0.2.2:8000' + item.gambarProduk,
                                      'Rp ${item.harga.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}',
                                      'Kuota Produksi Hari Ini: ${item.kuota}',
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showProductDetails(
    BuildContext context,
    int id,
    String namaProduk,
    String deskripsi,
    String gambarProduk,
    String harga,
    String kuota,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(namaProduk),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(gambarProduk),
            Text(deskripsi),
            Text(harga),
            Text(kuota),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
