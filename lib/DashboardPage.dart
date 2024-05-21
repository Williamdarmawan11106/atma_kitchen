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
          backgroundColor: Color(0xFFF5DEB3), 
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
                  SizedBox(height: 24),
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
              decoration: BoxDecoration(color: Color(0xFFF5DEB3)),
              child: Image.network(product.gambar, fit: BoxFit.fill),
            );
          },
        );
      }).toList(),
    );
  }

  Widget buildProductGrid(List<PopulerItem> products) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      color: Color(0xFFF5DEB3), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, 
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Text(
              'Best Seller',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: AutofillHints.countryName),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24),
          Center( 
            child: SizedBox(
              width: double.infinity,
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return buildProductItem(products[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildProductItem(PopulerItem product) {
    return Card(
      elevation: 4,
      color: Colors.white, 
      child: Padding(
        padding: const EdgeInsets.all(8.0), 
        child: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                textAlign: TextAlign.center,
              ),
              Text(
                'Rp ${product.harga.toStringAsFixed(0)}',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
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
      ),
    );
  }

  Widget buildPromoBanner() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9, 
            child: Image.asset(
              'images/produk/lapislegit.jpeg',
              fit: BoxFit.cover, 
            ),
          ),
          SizedBox(height: 16), 
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.brown.withOpacity(0.5), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Treat Yourself Twice on Your Birthday',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                SizedBox(height: 8),
                Text(
                  'Celebrate with us and earn double points on all purchases throughout your special week.',
                  style: TextStyle(color: Colors.black),
                ),
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
      color: Colors.brown[100],
      child: Row(
        children: [
          Expanded(child: Image.asset('images/produk/lapislegit.jpeg')),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About Us', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
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
      color: Colors.brown, 
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
        Icon(icon, size: 40, color: Color(0xFFF5DEB3)),
        SizedBox(height: 8),
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFF5DEB3))),
        SizedBox(height: 4),
        Text(subtitle, textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFF5DEB3)),),
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
          Container(
            color: Colors.grey[800], 
            padding: EdgeInsets.all(20.0), 
            child: Center(
              child: Text(
                '© Copyright 2024 | Atma Kitchen',
                style: TextStyle(color: Colors.white), // Warna teks putih
              ),
            ),
          ),
        ],
      ),
    );
  }
}
