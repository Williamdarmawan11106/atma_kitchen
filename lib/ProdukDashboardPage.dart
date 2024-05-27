import 'package:flutter/material.dart';
import 'package:atma_kitchen/client/ProdukDashboardClient.dart';
import 'package:atma_kitchen/entity/ProdukDashboard.dart';
import 'package:atma_kitchen/Login.dart';

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
        flexibleSpace: FlexibleSpaceBar(
          background: Image.asset(
            'images/UI P3L.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );
        },
        child: Icon(Icons.login),
        backgroundColor: Color.fromARGB(255, 233, 142, 68),
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

          var produk = snapshot.data!.produk;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  CategoryWidget(
                    categoryTitle: 'Cake',
                    products: produk.where((item) => item.kategori == 'Cake').toList(),
                    titleTextStyle: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF222222),
                      fontWeight: FontWeight.bold, 
                    ),
                  ),
                  SizedBox(height: 20),
                  CategoryWidget(
                    categoryTitle: 'Bread',
                    products: produk.where((item) => item.kategori == 'Roti').toList(),
                    titleTextStyle: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF222222),
                      fontWeight: FontWeight.bold, 
                    ),
                  ),
                  SizedBox(height: 20),
                  CategoryWidget(
                    categoryTitle: 'Minuman',
                    products: produk.where((item) => item.kategori == 'Minuman').toList(),
                    titleTextStyle: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF222222),
                      fontWeight: FontWeight.bold, 
                    ),
                  ),
                  SizedBox(height: 20),
                  CategoryWidget(
                    categoryTitle: 'Titipan',
                    products: produk.where((item) => item.kategori == 'Titipan').toList(),
                    titleTextStyle: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF222222),
                      fontWeight: FontWeight.bold, 
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final String categoryTitle;
  final List<Produk> products;
  final TextStyle titleTextStyle; 

  const CategoryWidget({
    required this.categoryTitle,
    required this.products,
    required this.titleTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          categoryTitle.toUpperCase(),
          style: titleTextStyle, 
        ),
        SizedBox(height: 10),
        Container(
          height: 300,
          child: GridView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.25,
            ),
            itemBuilder: (context, index) {
              var item = products[index];
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          item.gambarProduk != null ? 'http://10.0.2.2:8000/' + item.gambarProduk! : '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        item.namaProduk,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Rp ${item.harga.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        item.kategori == 'Titipan' ? 'Stok: ${item.stok}' : 'Kuota: ${item.kuota}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.shopping_cart),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginView()),
                              );
                            },
                          ),
                          SizedBox(width: 4), 
                          IconButton(
                            icon: Icon(Icons.info),
                            onPressed: () {
                              String availability = '';
                                if (item.kategori == 'Titipan') {
                                  availability = 'Stok: ${item.stok}';
                                } else if (item.kategori == 'Cake' || item.kategori == 'Roti' || item.kategori == 'Minuman') {
                                  availability = 'Kuota Produksi Hari Ini: ${item.kuota?.toString() ?? '0'}';
                                }
                               _showProductDetails(
                                context,
                                item.id,
                                item.namaProduk,
                                item.deskripsi ?? '',
                                item.gambarProduk != null ? 'http://10.0.2.2:8000/' + item.gambarProduk! : '',
                                'Rp ${item.harga.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}',
                                availability,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
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
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(gambarProduk),
              SizedBox(height: 10),
              Text(deskripsi),
              SizedBox(height: 10),
              Text(harga),
              SizedBox(height: 10),
              Text(kuota),
            ],
          ),
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


