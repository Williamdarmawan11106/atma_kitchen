import 'package:flutter/material.dart';
import 'package:atma_kitchen/entity/History.dart';
import 'package:atma_kitchen/client/HistoryClient.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<History>> futureHistory;

  @override
  void initState() {
    super.initState();
    futureHistory = PresensiClient.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: FutureBuilder<List<History>>(
        future: futureHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }

          // Filter history for customer with ID "CUS-001" and status "Selesai"
          List<History> customerHistory = snapshot.data!
              .where((history) =>
                  history.ID_Customer == 'CUS-001' &&
                  history.Status_Pemesanan == 'Selesai')
              .toList();

          if (customerHistory.isEmpty) {
            return Center(child: Text('No completed orders for this customer'));
          }

          return ListView.builder(
            itemCount: customerHistory.length,
            itemBuilder: (context, index) {
              var history = customerHistory[index];
              return ListTile(
                title: Text('Order ID: ${history.ID_Pemesanan}'),
                subtitle: Text('Total Amount: Rp ${history.Harga_Pesanan}'),
                // Add more details if needed
              );
            },
          );
        },
      ),
    );
  }
}
