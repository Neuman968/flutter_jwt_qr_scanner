import 'package:flutter/material.dart';
import 'package:jwt_flutter_reader/screens/manual_jwt_entry.dart';

import 'screens/qr_scanner.dart'; // Import the QRScanner widget

// Replace with another public key, or override with --dart-define at runtime.
const publicKeyPem = String.fromEnvironment('PUBLIC_KEY_PEM',
    defaultValue: """-----BEGIN PUBLIC KEY-----
MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEYi1sxMbI2O8ahbk01xd9wKjxrFPB
GQIyPx/5rd872ccxTPb5AiVfYii7ug4bUpQtPfgtews3JOH3ki7LlvZxRg==
-----END PUBLIC KEY-----""");

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JWT QR Code',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JWT Encoded QR Code Validator"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QRScanner()),
                );
              },
              child: const Text('Scan QR Code'),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManualJwtEntry(),
                  ),
                );
              },
              child: const Text('Manually Enter Token'),
            ),
          ],
        ),
      ),
    );
  }
}
