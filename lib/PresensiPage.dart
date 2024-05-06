import 'package:flutter/material.dart';
import 'package:atma_kitchen/client/PresensiClient.dart';
import 'package:atma_kitchen/entity/Presensi.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'editpresensi.dart'; 

class PresensiList extends StatefulWidget {
  const PresensiList({Key? key}) : super(key: key);

  @override
  _PresensiListState createState() => _PresensiListState();
}

class _PresensiListState extends State<PresensiList> {
  late Future<List<Presensi>> futurePresensiList;

  void refresh() async {
    final data = PresensiClient.fetchAll();
    setState(() {
      futurePresensiList = data;
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Presensi List'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search by Employee Name',
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                ),
                onChanged: (value) {
                  searchPresensi(value);
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Presensi>>(
                future: futurePresensiList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final presensiList = snapshot.data!;
                    final groupedPresensi = groupBy(presensiList, (Presensi presensi) => presensi.tanggal_kehadiran);

                    return ListView.separated(
                      itemCount: groupedPresensi.length,
                      separatorBuilder: (BuildContext context, int index) => Divider(),
                      itemBuilder: (context, index) {
                        final tanggal = groupedPresensi.keys.elementAt(index);
                        final presensiByDate = groupedPresensi[tanggal]!;
                        
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                DateFormat('yyyy-MM-dd').format(tanggal),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ...presensiByDate.map((presensi) {
                              return ListTile(
                                title: Text(presensi.nama_employee),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Tanggal Kehadiran: ${presensi.tanggal_kehadiran.toString()}'),
                                    Text('Status: ${presensi.status_kehadiran == 1 ? 'Hadir' : 'Tidak Hadir'}'),
                                  ]
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    editPresensi(presensi, context);
                                  },
                                ),
                              );
                            }).toList(),
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void editPresensi(Presensi presensi, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPresensiPage(presensi: presensi),
      ),
    );
  }

  void searchPresensi(String employeeName) {
    setState(() {
      futurePresensiList = PresensiClient.searchByEmployeeName(employeeName);
    });
  }
}
