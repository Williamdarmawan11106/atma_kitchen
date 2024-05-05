import 'package:flutter/material.dart';
import 'package:atma_kitchen/client/CustomerClient.dart';
import 'package:atma_kitchen/entity/Customer.dart';
import 'HistoryPage.dart'; // Import file history_page.dart yang berisi halaman HistoryPage

class Profile extends StatefulWidget {
  const Profile({super.key, required this.id});

  final String? id;

  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<Profile> {
  late Future<Customer> futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = CustomerClient.fetch(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage(id: widget.id,)),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder<Customer>(
            future: futureProfile,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('No data available');
              }

              Customer customer = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                        ),
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/profile_image.png'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      customer.Nama_Customer,
                      style: const TextStyle(
                          fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        const SizedBox(width: 5),
                        Text(
                          'Promo Poin : ${customer.Promo_Poin}',
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.attach_money, color: Colors.green),
                        const SizedBox(width: 5),
                        Text(
                          'Saldo : Rp ${customer.Saldo}',
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
