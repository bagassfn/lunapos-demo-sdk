import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel("example.com/native-code-example");

  void runPosActivity() {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;

    if (firstName.isEmpty) {
      Fluttertoast.showToast(msg: "first name cannot be empty");
      return;
    }
    if (firstName.isEmpty) {
      Fluttertoast.showToast(msg: "last name cannot be empty");
      return;
    }
    if (firstName.isEmpty) {
      Fluttertoast.showToast(msg: "email cannot be empty");
      return;
    }
    if (firstName.isEmpty) {
      Fluttertoast.showToast(msg: "phone number cannot be empty");
      return;
    }

    try {
      platform.invokeMethod("startPos", {
        "firstName": firstName,
        "lastName": lastName,
        "email" : email,
        "phone": phone
      });
    } on PlatformException catch (e) {
      // ignore
    }
  }

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            Container(
              child: Text("Tanpa angka nol (0) di depan nomor handphone"),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
              onPressed: runPosActivity,
              child: const Text("Jalankan Luna")
            )
          ],
        ),
      ),
    );
  }
}
