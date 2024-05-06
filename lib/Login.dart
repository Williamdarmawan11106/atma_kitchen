import 'package:atma_kitchen/entity/User.dart';
import 'package:flutter/material.dart';
import 'package:atma_kitchen/Profile.dart';
import 'package:atma_kitchen/Presensi.dart';
import 'package:atma_kitchen/client/AuthClient.dart';
import 'package:atma_kitchen/client/ResetPasswordClient.dart';
import 'package:flutter/widgets.dart';

class LoginView extends StatefulWidget {
  final Map? data;

  const LoginView({Key? key, this.data}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    // Function untuk melakukan pencarian data pengguna berdasarkan nama
    Future<User?> searchData() async {
      try {
        print(emailController.text);
        User? data = await AuthClient.searchByEmail(emailController.text);
        return data;
      } catch (e) {
        print(e);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Pengguna Tidak Ditemukan!'),
              content:
                  const Text('Silahkan masukkan email yang sudah terdaftar'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
        return null;
      }
    }

    // Function untuk login pengguna sebagai customer
    Future<User?> login() async {
      try {
        User? data = await AuthClient.login(
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
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundColor:
                            Colors.transparent, // Transparent background
                        backgroundImage: AssetImage('images/UI P3L.jpg'),
                        // Adjust fit property to prevent cropping
                        // fit: BoxFit.cover, // Uncomment this line if necessary
                      ),
                      Text(
                        'Masuk',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromRGBO(0, 0, 0, 1.0),
                          fontWeight: FontWeight.w500,
                          fontFamily: AutofillHints.familyName,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Masuk menggunakan email dan kata sandi yang telah terdaftar!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(0, 0, 0, 1.0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.brown),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        key: const Key('usernameField'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email Tidak Boleh Kosong";
                          }
                          return null;
                        },
                        controller: usernameController,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          helperText: "Inputkan email yang telah didaftar",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 10),
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
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            padding:
                                const EdgeInsetsDirectional.only(end: 12.0),
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
                    ],
                  ),
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  key: const Key('Masuk'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      User? dataLogin = await login();
                      print(dataLogin?.username);
                      if (dataLogin?.active == '1') {
                        if (dataLogin?.role == 'Customer') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login Berhasil!'),
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Profile(id: dataLogin?.id),
                            ),
                          );
                        } else if (dataLogin?.role == 'MO') {
                          print(dataLogin?.role);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login Berhasil MO!'),
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PresensiList(),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              key: const Key('gagal'),
                              title: const Text('Email atau Password Salah'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            key: const Key('gagal'),
                            title: const Text('Pengguna Belum Terverifikasi!'),
                            content: const Text('Silahkan Cek Email Anda'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
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
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                              'Masukkan Email Anda yang Sudah Terdaftar'),
                          content: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                print(emailController.text);
                                User? customer = await searchData();
                                print(customer?.email);
                                if (customer != null) {
                                  await Resetpasswordclient.sendEmail(
                                      customer.username);
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
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Ubah Kata Sandi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
