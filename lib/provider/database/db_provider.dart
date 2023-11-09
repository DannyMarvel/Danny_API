import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/authentication/login.dart';
import '../../utils/routers.dart';

class DatabaseProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
//We set the data we want to use
  String _token = '';

  String _userId = '';
//Then create a getter to get the data
  String get token => _token;

  String get userId => _userId;

  void saveToken(String token) async {
    SharedPreferences value = await _pref;

    value.setString('token', token);
  }

  void saveUserId(String id) async {
    SharedPreferences value = await _pref;

    value.setString('id', id);
  }

  Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('token')) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getUserId() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('id')) {
      String data = value.getString('id')!;
      _userId = data;
      notifyListeners();
      return data;
    } else {
      _userId = '';
      notifyListeners();
      return '';
    }
  }

  void logOut(BuildContext context) async {
    final value = await _pref;

    value.clear();

    PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
  }
}
