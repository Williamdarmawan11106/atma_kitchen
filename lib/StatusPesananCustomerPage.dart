import 'package:flutter/material.dart';
import 'package:atma_kitchen/client/StatusPesananCustomerClient.dart';
import 'package:atma_kitchen/entity/Pemesanan.dart';

class OrderStatusPage extends StatefulWidget {
  final int id;
  final ApiClient apiClient;

  OrderStatusPage({required this.id, required this.apiClient});

  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  late Future<List<Pemesanan>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = widget.apiClient.getAllStatuses(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Statuses'),
      ),
      body: FutureBuilder<List<Pemesanan>>(
        future: futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final order = snapshot.data![index];
                return ListTile(
                  title: Text('Product: ${order.namaProduk ?? "Unknown"}'),
                  subtitle: Text('Quantity: ${order.jumlah ?? 0}, Price: ${order.hargaPesanan ?? 0.0}'),
                  trailing: order.statusPesanan == 'sudah dikirim'
                      ? ElevatedButton(
                          onPressed: () => _completeOrder(order),
                          child: Text('Mark as Completed'),
                        )
                      : Text(order.statusPesanan ?? 'Unknown'),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _completeOrder(Pemesanan order) async {
    if (order.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order ID is null')),
      );
      return;
    }

    try {
      await widget.apiClient.completeOrder(order.id.toString());
      setState(() {
        futureOrders = widget.apiClient.getAllStatuses(widget.id.toString());
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order marked as completed')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to mark order as completed: $e')),
      );
    }
  }
}
