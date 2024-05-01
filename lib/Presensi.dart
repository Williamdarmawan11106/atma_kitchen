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

  @override
  void initState() {
    super.initState();
    futurePresensiList = PresensiClient.fetchAll();
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
                  return InkWell(
                    onTap: () {
                      editPresensi(snapshot.data![index], context);
                    },
                    child: ListTile(
                      title: Text(snapshot.data![index].ID_Presensi),
                      subtitle: Text(snapshot.data![index].Tanggal_Kehadiran.toString()),
                      // Add more fields here
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
