import 'package:flutter/material.dart';
import 'package:atma_kitchen/entity/PenarikanSaldo.dart';
import 'package:atma_kitchen/client/PenarikanSaldoClient.dart';
import 'package:atma_kitchen/entity/User.dart'; // Import User entity
import 'package:atma_kitchen/client/CustomerClient.dart'; // Import CustomerClient

class PenarikanSaldoPage extends StatefulWidget {
  final int? id;

  PenarikanSaldoPage({required this.id});

  @override
  _PenarikanSaldoPageState createState() => _PenarikanSaldoPageState();
}

class _PenarikanSaldoPageState extends State<PenarikanSaldoPage> {
  List<PenarikanSaldo> _penarikanSaldoList = [];
  bool _isLoading = true;
  bool _isCustomerLoading = true;
  late int _customerId;
  String _selectedBank = '';
  double _customerSaldo = 0.0;

  final _formKey = GlobalKey<FormState>();
  final _nominalController = TextEditingController();
  final _rekeningController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _customerId = widget.id!;
    _fetchPenarikanSaldo();
    _fetchCustomerDetails();

    // Ambil saldo pengguna saat initState
    _fetchUserSaldo();
  }

  Future<void> _fetchPenarikanSaldo() async {
    try {
      var penarikanSaldoList = await PenarikanSaldoClient.fetchAll(_customerId);
      setState(() {
        _penarikanSaldoList = penarikanSaldoList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data: $e')),
      );
    }
  }

  Future<void> _fetchCustomerDetails() async {
    try {
      var customer = await CustomerClient.fetch(_customerId);
      setState(() {
        _customerSaldo = customer.saldo;
        _isCustomerLoading = false;
      });
    } catch (e) {
      setState(() {
        _isCustomerLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load customer data: $e')),
      );
    }
  }

  Future<void> _fetchUserSaldo() async {
    try {
      var customer = await CustomerClient.fetch(_customerId);
      setState(() {
        _customerSaldo = customer.saldo;

        // Setel nilai awal untuk _nominalController dengan saldo pengguna
        _nominalController.text = _customerSaldo.toString();
      });
    } catch (e) {
      setState(() {
        _isCustomerLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load customer data: $e')),
      );
    }
  }

  Future<void> _createPenarikanSaldo() async {
    try {
      int noRekening = int.parse(_rekeningController.text);

      var newPenarikanSaldo = PenarikanSaldo(
        id: 0,
        nominal_penarikan: double.parse(_nominalController.text),
        bank: _selectedBank,
        no_rekening: noRekening,
        status: 0,
        tanggal_penarikan: DateTime.now(),
        id_customer: _customerId,
      );

      var createdPenarikanSaldo = await PenarikanSaldoClient.createPenarikanSaldo(newPenarikanSaldo);

      if (createdPenarikanSaldo != null) {
        await _fetchPenarikanSaldo();
        // Setel saldo pengguna menjadi 0 setelah penarikan berhasil
        setState(() {
          _customerSaldo = 0.0;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully created')),
        );
      } else {
        throw Exception('Failed to create: Response was null');
      }
    } catch (e) {
      print('Error creating penarikan saldo: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create: $e')),
      );
    }
  }

  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Penarikan Saldo'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nominalController,
                    decoration: InputDecoration(
                      labelText: 'Nominal Penarikan',
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a nominal value';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _selectedBank.isNotEmpty ? _selectedBank : null,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedBank = newValue ?? '';
                      });
                    },
                    items: <String>['BCA', 'BNI', 'BRI', 'Mandiri', 'CIMB NIAGA', 'Danamon']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Nama Bank',
                      prefixIcon: Icon(Icons.account_balance),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _rekeningController,
                    decoration: InputDecoration(
                      labelText: 'No Rekening',
                      prefixIcon: Icon(Icons.account_balance_wallet),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a rekening number';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _createPenarikanSaldo();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPenarikanSaldoCard(PenarikanSaldo penarikanSaldo) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.amber,
          child: Icon(Icons.money, color: Colors.white),
        ),
        title: Text('Nominal: ${penarikanSaldo      .nominal_penarikan}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rekening: ${penarikanSaldo.no_rekening}'),
            Text('Bank: ${penarikanSaldo.bank}'),
            Text('Status: ${penarikanSaldo.status == 0 ? 'Pending' : 'Completed'}'),
            Text('Tanggal: ${penarikanSaldo.tanggal_penarikan}'),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.0),
      color: Color(0xFFF5DEB3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Penarikan Saldo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Here you can view and manage your balance withdrawals.',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 8),
          _isCustomerLoading
              ? CircularProgressIndicator()
              : Text(
                  'Saldo: Rp $_customerSaldo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atma Kitchen'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchPenarikanSaldo,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: _penarikanSaldoList
                            .map((penarikanSaldo) =>
                                _buildPenarikanSaldoCard(penarikanSaldo))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
    );
  }
}

