import 'package:flutter/material.dart';
import 'package:atma_kitchen/entity/History.dart';
import 'package:atma_kitchen/client/HistoryClient.dart';
import 'package:atma_kitchen/client/SearchHistoryProductNameClient.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.id});

  final String? id;
  
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<History>> futureHistory;

  @override
  void initState() {
    super.initState();
    futureHistory = HistoryClient.fetchAll(widget.id);
    print(futureHistory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          List<History> historyList = snapshot.data!;
          print(historyList);

          if (historyList.isEmpty) {
            return const Center(child: Text('No history for this customer'));
          }

          return ListView.builder(
            itemCount: historyList.length,
            itemBuilder: (context, index) {
              var history = historyList[index];
              return ListTile(
                title: Text('Nama Produk: ${history.Nama_Produk}'),
                subtitle: Text('Total Amount: Rp ${history.Harga}'),
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
          title: const Text("Search by Product Name"),
          content: TextField(
            decoration: const InputDecoration(
              hintText: "Enter product name",
            ),
            onSubmitted: (productName) {
              searchHistory(widget.id, productName);
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
                searchHistory(widget.id, productName);
                Navigator.pop(context);
              },
              child: const Text("Clear"),
            ),
          ],
        );
      },
    );
  }

  void searchHistory(String? id, String productName) {
    setState(() {
      futureHistory = SearchHistoryProductNameClient.searchHistory(id, productName);
    });
  }
}
