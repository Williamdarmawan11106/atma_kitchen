import 'package:flutter/material.dart';
import 'package:atma_kitchen/entity/History.dart';
import 'package:atma_kitchen/client/HistoryClient.dart';
import 'package:atma_kitchen/client/SearchHistoryProductNameClient.dart';

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
    futureHistory = HistoryClient.fetchAll();
    print(futureHistory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearchDialog(context);
            },
          ),
        ],
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

          List<History> customerHistory = snapshot.data!
              .where((history) =>
                  history.ID_Customer == 'CUS-001')
              .toList();

          if (customerHistory.isEmpty) {
            return Center(child: Text('No completed orders for this customer'));
          }

          return ListView.builder(
            itemCount: customerHistory.length,
            itemBuilder: (context, index) {
              var history = customerHistory[index];
              return ListTile(
                title: Text('Nama Produk: ${history.ID_Pemesanan}'),
                subtitle: Text('Total Amount: Rp ${history.Harga_Pesanan}'),
              );
            },
          );
        },
      ),
    );
  }

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Search by Product Name"),
          content: TextField(
            decoration: InputDecoration(
              hintText: "Enter product name",
            ),
            onSubmitted: (productName) {
              searchHistory(productName);
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final productName = '';
                searchHistory(productName);
                Navigator.pop(context);
              },
              child: Text("Clear"),
            ),
          ],
        );
      },
    );
  }

  void searchHistory(String productName) {
    setState(() {
      futureHistory = SearchHistoryProductNameClient.searchHistory(productName);
    });
  }
}
