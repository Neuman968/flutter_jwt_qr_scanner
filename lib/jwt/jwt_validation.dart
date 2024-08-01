import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:logger/logger.dart';

import '../main.dart';


final Logger logger = Logger();

enum JWTTokenState {
  valid,
  expired,
  not_valid,
}

JWTTokenState verifyJwt(String token) {
  try {
    // Verify the token
    final jwt = JWT.verify(
      token,
      ECPublicKey(publicKeyPem),
      checkHeaderType: false,
      checkExpiresIn: true,
      checkNotBefore: false,
    );

    // additional details of the JWT token can be validated.

    // If no exception is thrown, the token is valid
    return JWTTokenState.valid;
  } on JWTExpiredException catch (ex) {
    logger.e('JWT expired: ', error: ex);
    return JWTTokenState.expired;
  } on JWTException catch (ex) {
    logger.e('JWT error: ', error: ex);
    return JWTTokenState.not_valid;
  }
}
