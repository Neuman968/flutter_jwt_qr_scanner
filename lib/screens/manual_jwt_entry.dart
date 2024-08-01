import 'package:flutter/material.dart';
import 'package:jwt_flutter_reader/jwt/jwt_validation.dart';

class ManualJwtEntry extends StatefulWidget {

  const ManualJwtEntry({super.key});

  @override
  _ManualJwtEntryState createState() => _ManualJwtEntryState();
}

class _ManualJwtEntryState extends State<ManualJwtEntry> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  void _verifyToken() {
    final token = _controller.text;
    final tokenState = verifyJwt(token);
    setState(() {
      _result = 'JWT State: $tokenState';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual JWT Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter JWT',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyToken,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            Text(_result),
          ],
        ),
      ),
    );
  }
}