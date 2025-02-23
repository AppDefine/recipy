import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:pointycastle/export.dart' as pc;

class EncryptionUtils {
  static const _aesKeySize = 128;
  static const _gcmIvLength = 12;
  static const _saltLength = 16;
  static const _masterKey = "RvDJFwzaaL1R20_FGRTD_LFNYJcaqoT7";

  // Lazy-initialized properties
  static Uint8List get salt => _salt ??= _generateSalt();
  static pc.KeyParameter get aesKey => _aesKey ??= _generateAesKey();

  static Uint8List? _salt;
  static pc.KeyParameter? _aesKey;

  // Helper method for salt generation
  static Uint8List _generateSalt() {
    var keyBytes = utf8.encode(_masterKey);
    return Uint8List.fromList(
        sha256.convert(keyBytes).bytes.sublist(0, _saltLength)
    );
  }

  // Helper method for AES key generation
  static pc.KeyParameter _generateAesKey() {
    final pbkdf2 = pc.PBKDF2KeyDerivator(pc.HMac(pc.SHA256Digest(), 64));
    pbkdf2.init(pc.Pbkdf2Parameters(salt, 65536, _aesKeySize ~/ 8));
    final key = pbkdf2.process(utf8.encode(_masterKey));
    return pc.KeyParameter(key);
  }

  static String encrypt(String data) {
    final encKey = enc.Key(aesKey.key);

    final iv = _generateRandomBytes(_gcmIvLength);
    final encrypter = enc.Encrypter(enc.AES(encKey, mode: enc.AESMode.gcm));
    final encrypted = encrypter.encrypt(data, iv: enc.IV(iv));
    final encryptedWithIv = iv + encrypted.bytes;
    return base64UrlEncode(encryptedWithIv);
  }

  static String decrypt(String data) {
    final encKey = enc.Key(aesKey.key);

    final encryptedData = base64Url.decode(data);
    final iv = encryptedData.sublist(0, _gcmIvLength);
    final cipherText = encryptedData.sublist(_gcmIvLength);

    final encrypter = enc.Encrypter(enc.AES(encKey, mode: enc.AESMode.gcm));
    final decrypted = encrypter.decrypt(enc.Encrypted(cipherText), iv: enc.IV(iv));
    return decrypted;
  }

  static Uint8List _generateRandomBytes(int length) {
    final random = Random.secure();
    return Uint8List.fromList(
        List.generate(length, (_) => random.nextInt(256))
    );
  }
}

class EncryptionUtilsVCS {
  String key1 = "ojy1vihe1f2ny5b30h8ax23mt9jdm2uk";
  String iv1 = "0123456789abcdef";

  String encrypt(String plainText) {
    final key = enc.Key.fromUtf8(key1);
    final iv = enc.IV.fromUtf8(iv1);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.ecb));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64.toString();
  }

  String decrypt(encryptedData) {
    final key = enc.Key.fromUtf8(key1);
    final iv = enc.IV.fromUtf8(iv1);
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.ecb));
    final decrypted =
    encrypter.decrypt(enc.Encrypted.from64(encryptedData), iv: iv);
    return decrypted.toString();
  }
}
