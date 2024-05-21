import 'package:atma_kitchen/Login.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:atma_kitchen/entity/Dashboard.dart';
import 'package:atma_kitchen/client/DashboardClient.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:video_player/video_player.dart';

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
      body: FutureBuilder<Dashboard>(
        future: futureDashboard,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 48.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFFFEBCD), Color(0xFFF5DEB3)],
                        ),
                        borderRadius: BorderRadius.zero,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), 
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Welcome to Atma Kitchen',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
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
    return Padding(
      padding: EdgeInsets.only(top: 24.0), 
      child: CarouselSlider(
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
      ),
    );
  }


  Widget buildProductGrid(List<PopulerItem> products) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.0, right: 12.0, left: 12.0, top: 24.0),
      color: Color(0xFFF5DEB3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Our Best Seller Products',
                style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
                color: Colors.black,
                ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 12),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                ),
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
        padding: const EdgeInsets.all(0.0),
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
                style: TextStyle(fontSize: 14, color: Colors.black),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity, 
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                'images/Birthday.jpg',
                fit: BoxFit.cover, 
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.0),
            color: Color(0xFFF5DEB3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Treat Yourself Twice on Your Birthday',
                  style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
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
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 190, 
                  child: Image.asset('images/About_us.jpg', fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
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
        ],
      ),
    );
  }

  Widget buildPartnerProducts() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Color(0xFFF5DEB3),
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
            child: Container(
              height: 190, 
              child: Image.asset('images/Titipan.jpg', fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildServices() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.brown[100],
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
        Icon(icon, size: 40, color: Colors.black),
        SizedBox(height: 8),
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 94, 40, 20))),
        SizedBox(height: 4),
        Text(subtitle, textAlign: TextAlign.center, style: TextStyle(color: const Color.fromARGB(255, 94, 40, 20))),
      ],
    );
  }

  Widget buildFooter() {
    return Container(
      padding: EdgeInsets.only(top: 16.0),
      color: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Phone: 081-123-456-7891'),
                SizedBox(height: 4),
                Text('Email: cust.serv@atmakitch.com'),
                SizedBox(height: 4),
                Text('Address: Jl. Babarsari No. 123, Yogyakarta'),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Follow Us',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FaIcon(FontAwesomeIcons.instagram, color: Colors.pink),
                        SizedBox(width: 8),
                        Text('@Atma_Kitchen'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('@Atma_Kitchen'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FaIcon(FontAwesomeIcons.twitter, color: Colors.lightBlue),
                        SizedBox(width: 8),
                        Text('@Atma_Kitchen'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            color: Colors.brown[100],
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                '© Copyright 2024 | Atma Kitchen',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

