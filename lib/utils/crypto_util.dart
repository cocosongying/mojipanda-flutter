import 'package:crypto/crypto.dart';
import 'dart:convert';

class CryptoUtil {
  static String sha1Digest(String data) {
    var bytes = utf8.encode(data);
    var digest = sha1.convert(bytes);
    return digest.toString();
  }
}
