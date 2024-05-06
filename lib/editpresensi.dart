import 'package:atma_kitchen/PresensiPage.dart';
import 'package:flutter/material.dart';
import 'package:atma_kitchen/entity/Presensi.dart';
import 'package:atma_kitchen/client/PresensiClient.dart';

class EditPresensiPage extends StatefulWidget {
  final Presensi presensi;

  const EditPresensiPage({Key? key, required this.presensi}) : super(key: key);

  @override
  _EditPresensiPageState createState() => _EditPresensiPageState();
}

class _EditPresensiPageState extends State<EditPresensiPage> {
  late TextEditingController _controllerIDPresensi;
  late TextEditingController _controllerTanggalKehadiran;
  late TextEditingController _controllerNamaEmployee;

  final List<String> statusOptions = ['Hadir', 'Tidak Hadir']; 
  late String selectedStatus; 

  @override
  void initState() {
    super.initState();
    _controllerIDPresensi = TextEditingController(text: widget.presensi.id.toString());
    _controllerTanggalKehadiran = TextEditingController(text: widget.presensi.tanggal_kehadiran.toString());
    _controllerNamaEmployee = TextEditingController(text: widget.presensi.nama_employee);
    selectedStatus = widget.presensi.status_kehadiran == 1 ? 'Hadir' : 'Tidak Hadir'; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Presensi'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: _controllerIDPresensi,
              decoration: InputDecoration(
                labelText: 'ID Presensi',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _controllerTanggalKehadiran,
              decoration: InputDecoration(
                labelText: 'Tanggal Kehadiran',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _controllerNamaEmployee,
              decoration: InputDecoration(
                labelText: 'Nama Karyawan',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Dropdown for selecting status
            DropdownButtonFormField<String>(
              value: selectedStatus,
              onChanged: (newValue) {
                setState(() {
                  selectedStatus = newValue!;
                });
              },
              items: statusOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Status Kehadiran',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveChanges(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PresensiList(),
                  ),
                );
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveChanges(BuildContext context) async {
    try {
      String newIDPresensi = _controllerIDPresensi.text;
      String newTanggalKehadiran = _controllerTanggalKehadiran.text;
      String newNamaEmployee = _controllerNamaEmployee.text;

      int status = selectedStatus == 'Hadir' ? 1 : 0;

      Presensi updatedPresensi = Presensi(
        id: int.parse(newIDPresensi),
        tanggal_kehadiran: DateTime.parse(newTanggalKehadiran),
        status_kehadiran: status,
        nama_employee: newNamaEmployee,
      );

      await PresensiClient.update(updatedPresensi);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Presensi updated successfully'),
        ),
      );

    } catch (e) {
      print('Error while saving changes: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update presensi: $e'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controllerIDPresensi.dispose();
    _controllerTanggalKehadiran.dispose();
    _controllerNamaEmployee.dispose();
    super.dispose();
  }
}
