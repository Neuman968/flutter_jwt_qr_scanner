import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:jwt_flutter_reader/jwt/jwt_validation.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  Color backgroundColor = Colors.white;

  String? lastScannedToken;

  String _getResultMessage(JWTTokenState result) {
    switch (result) {
      case JWTTokenState.valid:
        return "Token is valid!";
      case JWTTokenState.expired:
        return "Token is expired!";
      case JWTTokenState.not_valid:
        return "Token is not valid!";
    }
  }

  void _onDetectHandler(BarcodeCapture barcodes) {
    for (var barcode in barcodes.barcodes) {
      if (barcode.rawValue != null && barcode.rawValue != lastScannedToken) {
        final String token = barcode.rawValue.toString();
        final result = verifyJwt(token);

        final message = _getResultMessage(result);

        final color = result == JWTTokenState.valid
            ? Colors.lightGreen
            : Colors.redAccent;

        setState(() {
          backgroundColor = color;
          lastScannedToken = barcode.rawValue;
        });

        // After 5 seconds, clear the scan.
        Future.delayed(const Duration(seconds: 5), () {
          setState(() {
            if (lastScannedToken == barcode.rawValue) {
              lastScannedToken = null;
            }
          });
        });
        _showMessageSnackbar(context, message);
      }
    }
  }

  void _showMessageSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 36.0),
        ),
      ),
      backgroundColor: Colors.blueGrey.withOpacity(0.8),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor.withOpacity(0.8),
        title: const Text('QR Scanner'),
      ),
      body: Container(
        color: backgroundColor.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 22.0,
          ),
          child: MobileScanner(
            onDetect: _onDetectHandler,
          ),
        ),
      ),
    );
  }
}
