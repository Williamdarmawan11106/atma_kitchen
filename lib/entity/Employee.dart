import 'dart:convert';

class Employee {
  String ID_Employee;
  String Nama_Employee;
  String Nomor_Telepon;
  double Gaji;
  double Bonus;
  String ID_Jabatan;

  Employee({
    required this.ID_Employee,
    required this.Nama_Employee,
    required this.Nomor_Telepon,
    required this.Gaji,
    required this.Bonus,
    required this.ID_Jabatan,
  });

  factory Employee.fromRawJson(String str) =>
      Employee.fromJson(json.decode(str));
  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        ID_Employee: json['ID_Employee'],
        Nama_Employee: json['Nama_Employee'],
        Nomor_Telepon: json['Nomor_Telepon'],
        Gaji: double.parse(json['Gaji'].toString()),
        Bonus: double.parse(json['Bonus'].toString()),
        ID_Jabatan: json['ID_Jabatan'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'ID_Employee': ID_Employee,
        'Nama_Employee': Nama_Employee,
        'Nomor_Telepon': Nomor_Telepon,
        'Gaji': Gaji,
        'Bonus': Bonus,
        'ID_Jabatan': ID_Jabatan,
      };
}
