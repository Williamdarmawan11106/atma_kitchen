import 'package:atma_kitchen/entity/Employee.dart';
import 'package:flutter/material.dart';
import 'package:atma_kitchen/entity/Customer.dart';
import 'package:atma_kitchen/Profile.dart';
import 'package:atma_kitchen/Presensi.dart';
import 'package:atma_kitchen/client/AuthClient.dart';
import 'package:atma_kitchen/client/ResetPasswordClient.dart';

class LoginView extends StatefulWidget {
  final Map? data;

  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    Future<Customer?> searchData() async {
      try {
        print(usernameController.text);
        Customer? data = await AuthClient.searchByName(usernameController.text);
        print(data);
        return data;
      } catch (e) {
        print(e);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Pengguna Tidak Ditemukan!'),
                content: const Text(
                    'Silahkan masukkan nama pengguna yang sudah terdaftar'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            });
        return null;
      }
    }

    Future<Customer?> loginCus() async {
      try {
        Customer? data = await AuthClient.loginCust(
            usernameController.text, passwordController.text);
        return data;
      } catch (e) {
        print(e);
        return null;
      }
    }

    Future<Employee?> loginEmp() async {
      try {
        Employee? data = await AuthClient.loginEmp(
            usernameController.text, passwordController.text);
        return data;
      } catch (e) {
        print(e);
        return null;
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Masuk',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromRGBO(0, 0, 0, 1.0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 100.0),
                  child: Text(
                    'Masuk menggunakan nama pengguna \ndan kata sandi yang telah terdaftar!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(0, 0, 0, 1.0),
                    ),
                  ),
                ),
                TextFormField(
                  key: const Key('usernameField'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Nama Pengguna Tidak Boleh Kosong";
                    }
                    return null;
                  },
                  controller: usernameController,
                  decoration: const InputDecoration(
                      hintText: "Username",
                      helperText: "Inputkan user yang telah didaftar",
                      icon: Icon(Icons.person)),
                ),
                TextFormField(
                  key: const Key("passwordField"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password Tidak Boleh Kosong";
                    }
                    return null;
                  },
                  obscureText: _isObscured,
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Password",
                    helperText: "Inputkan Password",
                    icon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      padding: const EdgeInsetsDirectional.only(end: 12.0),
                      icon: _isObscured
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                Column(
                  children: [
                    ElevatedButton(
                      key: const Key('Masuk'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Customer? dataCus = await loginCus();
                          Employee? dataEmp = await loginEmp();
                          if (dataCus != null) {
                            Customer customer = dataCus;
                            String? idCustomer = customer.ID_Customer;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login Berhasil!'),
                              ),
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Profile(id: idCustomer)));
                          } else if (dataEmp != null) {
                            print(dataEmp);
                            print(dataEmp.ID_Jabatan);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login Berhasil MO!'),
                              ),
                            );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const PresensiList()));
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                key: const Key('gagal'),
                                title:
                                    const Text('Username atau Password Salah'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel')),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        child: const Center(
                          child: Text(
                            'Masuk',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Masukkan Nama Pengguna Anda'),
                              content: TextField(
                                controller: usernameController,
                                decoration: const InputDecoration(
                                    labelText: 'Nama Pengguna'),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    print(usernameController.text);
                                    Customer? customer = await searchData();
                                    if (customer != null) {
                                      await Resetpasswordclient.sendEmail(
                                          customer.Nama_Customer);
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Email Telah Terkirim ke Email Terdaftar Anda'),
                                              content: const Text(
                                                  'Silahkan konfirmasi pada email anda'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Close the dialog
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  child: const Text('Submit'),
                                ),
                              ],
                            );
                          });
                    },
                    child: const Text('Ubah Kata Sandi')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
