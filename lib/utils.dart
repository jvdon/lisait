import 'package:flutter/material.dart';
import 'package:lisait/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension Pallete on Color {
  static Color green = HexColor.fromHex("#279557");
  static Color blue = HexColor.fromHex("#064A6F");
  static Color gray = HexColor.fromHex("#151515");
  static Color black = HexColor.fromHex("#0D0D0D");
  static Color red = HexColor.fromHex("#EB5757");
  static Color white = HexColor.fromHex("#F2F2F2");
}

InputBorder border = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(15)),
  borderSide: BorderSide(
    color: Pallete.red,
    width: 2,
  ),
);


extension UserPreference on SharedPreferences {
  // Recupera o usuário do SharedPreferences
  User? getUser() {
    String? userJSON = this.getString("user");

    if (userJSON == null) {
      return null;
    }

    return User.fromJson(userJSON);
  }

  // Transforma o usuário em json e salva no SharedPreferences
  Future<bool> saveUser(User user) async {
    return await setString("user", user.toJson());
  }
}