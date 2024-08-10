# QR Code Scanner & JWT Token Validator 

This is an example project that showcases scanning a QR code that is a JWT token and validating it based on 
its public key. The public key can be set at runtime using `--dart-define=PUBLIC_KEY_PEM=<public_key_pem>`
when running the app, or simply by changing the default value for the publicKeyPem variable defined in the `lib/main.dart` file.

This project can be used in conjunction with this [Kotlin JWT QR](https://github.com/Neuman968/JWT-Kotlin-Example)
project to generate signed QR code JWT tokens. View the `/qr` endpoint in your browser to get a qr code image
that can be validated by the scanner in this project.

# Platforms supported

Currently supported platforms are 

- macos
- web
- android

Linux at the moment cannot be supported due to the `mobile_scanner` dependency.
