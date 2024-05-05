import 'package:flutter/material.dart';
import 'package:atma_kitchen/client/PresensiClient.dart';
import 'package:atma_kitchen/entity/Presensi.dart';
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
        child: FutureBuilder<List<Presensi>>(
          future: futurePresensiList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                            title: Text(snapshot.data![index].ID_Presensi),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Tanggal Kehadiran: ${snapshot.data![index].Tanggal_Kehadiran.toString()}'),
                                Text('Status: ${snapshot.data![index].Status_Kehadiran == 1 ? 'Hadir' : 'Tidak Hadir'}'),
                              ]
                            ),
                        trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          editPresensi(snapshot.data![index], context);
                        },
                      ),
                    ),
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
}
