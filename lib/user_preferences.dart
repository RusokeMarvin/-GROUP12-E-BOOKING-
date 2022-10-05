import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bounce/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';
  static const myUser = User(
    imagePath:
        'https://nnmedia.nation.africa/uploads/2021/05/Azawi-1320x880.jpg',
    name: 'Azawi Official',
    email: 'azawiofficial@gmail.com',
    about:
        'Priscilla Zawedde better known by her stage name Azawi is a Ugandan singer, songwriter and dancer signed by Swangz Avenue in 2019. She sings Afrobeats in both Luganda and English. She became the first female Ugandan act to appear on the New York "Times Square" and Los Angelos billboards.',
    isDarkMode: false,
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final json = user.toJson();
    await docUser.set(json);

    final jsoni = jsonEncode(user.toJson());
    await _preferences.setString(_keyUser, jsoni);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
