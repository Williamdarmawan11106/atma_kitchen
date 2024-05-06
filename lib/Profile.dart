import 'package:atma_kitchen/entity/User.dart';
import 'package:flutter/material.dart';
import 'package:atma_kitchen/client/CustomerClient.dart';
import 'HistoryPage.dart'; // Import file history_page.dart yang berisi halaman HistoryPage

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.id}) : super(key: key);

  final int? id;

  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<Profile> {
  late Future<User> futureProfile;

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
      ),
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder<User>(
            future: futureProfile,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('No data available');
              }

              User customer = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          backgroundImage:
                              const AssetImage('images/Profile.jpg'),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          customer.username,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 5),
                            Text(
                              'Promo Poin: ${customer.promo_poin}',
                              style: const TextStyle(
                                fontSize: 18,
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
                              'Saldo: Rp ${customer.saldo}',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HistoryPage(id: widget.id)),
                            );
                          },
                          child: const Text('Lihat Riwayat'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
