import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;

String decryptAES(String? cipherText) {
  if(cipherText == null || cipherText.isEmpty){
    return "";
  }
  String key = "UlearnFile2023!@";
  String iv = "UlearnFile2023!@"; // Make sure IV is 16 bytes

  if (key.length != 16) {
    throw Exception(
        "Invalid AES key length. Key must be 128 bits (16 bytes) long.");
  }

  final encryptedBytes = base64.decode(cipherText);

  final decryptionKey = encrypt.Key.fromUtf8(key)
;
  final decrypter = encrypt.Encrypter(
      encrypt.AES(decryptionKey, mode: encrypt.AESMode.cbc, padding: "PKCS7"));

  final decrypted = decrypter.decryptBytes(
    encrypt.Encrypted(encryptedBytes),
    iv: encrypt.IV.fromUtf8(iv),
  );

  final decryptedText = utf8.decode(decrypted);
  return decryptedText.split('').reversed.join('');
}