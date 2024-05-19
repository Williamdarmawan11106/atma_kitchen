import 'package:atma_kitchen/Login.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:atma_kitchen/entity/Dashboard.dart';
import 'package:atma_kitchen/client/DashboardClient.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atma Kitchen',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.grey[50], 
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.brown[600], 
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Atma Kitchen'),
        ),
        body: Center(
          child: DashboardScreen(),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<Dashboard> futureDashboard;

  @override
  void initState() {
    super.initState();
    futureDashboard = DashboardClient.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atma Kitchen'),
      ),
      body: FutureBuilder<Dashboard>(
        future: futureDashboard,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildCarouselSlider(snapshot.data!.data),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: buildSectionTitle('Best Seller', 'Best Seller Product This Week!'),
                  ),
                  buildProductGrid(snapshot.data!.data),
                  buildPromoBanner(),
                  buildAboutUs(),
                  buildPartnerProducts(),
                  buildServices(),
                  buildFooter(),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildCarouselSlider(List<PopulerItem> products) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
        onPageChanged: (index, reason) {},
      ),
      items: products.map((product) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(color: Colors.amber),
              child: Image.network(product.gambar, fit: BoxFit.fill),
            );
          },
        );
      }).toList(),
    );
  }

  Widget buildSectionTitle(String title, String subtitle) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text(subtitle, style: TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }

  Widget buildProductGrid(List<PopulerItem> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return buildProductItem(products[index]);
      },
    );
  }

  Widget buildProductItem(PopulerItem product) {
    return Card(
      elevation: 4, // Memberikan sedikit bayangan ke card
      child: SizedBox(
        height: 200, // Tinggi tetap untuk setiap card produk
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Perataan tengah secara vertikal
          crossAxisAlignment: CrossAxisAlignment.center, // Perataan tengah secara horizontal
          children: [
            Expanded(
              child: Image.network(
                product.gambar,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Text(
              product.nama,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center, // Perataan tengah teks
            ),
            Text(
              'Rp ${product.harga.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center, // Perataan tengah teks
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPromoBanner() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Image.asset('images/produk/lapislegit.jpeg'),
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Treat Yourself Twice on Your Birthday', style: TextStyle(color: Colors.white, fontSize: 24)),
                SizedBox(height: 8),
                Text('Celebrate with us and earn double points on all purchases throughout your special week.',
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAboutUs() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(child: Image.asset('images/produk/lapislegit.jpeg')),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About Us', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                  "We're dedicated to crafting exceptional pastries and invigorating drinks using the finest ingredients. From indulgent treats to refreshing beverages, our menu promises a symphony of flavors. Join us for a delightful culinary journey at our bakery and beverage sanctuary.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPartnerProducts() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Partner Products', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                  "Discover our curated selection of locally sourced products at Atma Kitchen. Trusted by local vendors, our consignment offerings ensure quality and variety. Explore now and support our community!",
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Image.asset('images/produk/lapislegit.jpeg'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildServices() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildServiceItem('Shipping', 'Doorstep Delivery', Icons.local_shipping),
          buildServiceItem('Delivery on Time', 'Fast and Reliable', Icons.access_time),
          buildServiceItem('Online Ordering', 'Order Anytime', Icons.shopping_cart),
        ],
      ),
    );
  }

  Widget buildServiceItem(String title, String subtitle, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 40),
        SizedBox(height: 8),
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(subtitle, textAlign: TextAlign.center),
      ],
    );
  }

  Widget buildFooter() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact Us', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Phone: 081-123-456-7891'),
          Text('Email: cust.serv@atmakitch.com'),
          Text('Address: Jl. Babarsari No. 123, Yogyakarta'),
          SizedBox(height: 16),
          Text('Navigation', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Products'),
          Text('About Us'),
          Text('Our Service'),
          Text('Login'),
          Text('Register'),
          SizedBox(height: 16),
          Text('Categories', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Cake'),
          Text('Bread'),
          Text('Beverage'),
          Text('Hampers'),
          SizedBox(height: 16),
          Text('Follow Us', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Facebook: Atma_Kitchen'),
          Text('Instagram: @Atma_Kitchen'),
          Text('Twitter: @Atma_Kitchen'),
          SizedBox(height: 16),
          Center(child: Text('© Copyright 2024 | Atma Kitchen')),
        ],
      ),
    );
  }
}
