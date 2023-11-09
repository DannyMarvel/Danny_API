import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants/url.dart';
import '../../screens/authentication/login.dart';
import '../../screens/taskpage/home_page.dart';
import '../../utils/routers.dart';
import '../database/db_provider.dart';

class AuthenticationProvider extends ChangeNotifier {
  ///Base Url
  final requestBaseUrl = AppUrl.baseUrl;

  ///Setter is used to  know when our value changes
  bool _isLoading = false;
  String _resMessage = '';

  //Getter. This is what we are going to be listening to
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

//We also find the path users from the api
    String url = "$requestBaseUrl/users/";

//Make sure the body match the doccumentation of  the api
    final body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password
    };
    print(body);
//We wrap anything Network request in a try and catch function
    try {
      http.Response req = await http.post(
        Uri.parse(url),
//Sometimes we need to ask the backend dev if we need to json.encode OR Not
        body: json.encode(body),
      );

//200 and 201 means request is successfull
      if (req.statusCode == 200 || req.statusCode == 201) {
        _isLoading = false;
        _resMessage = "Account created!";
        notifyListeners();
        PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
      } else {
        final res = json.decode(req.body);
//Make sure you decode res before calling ['message']
        _resMessage = res['message'];

        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  //Login
  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();
//Check for the API path for the login request
    String url = "$requestBaseUrl/users/login";

    final body = {
      "email": email,
      "password": password,
    };
    print(body);

    try {
      http.Response req =
          await http.post(Uri.parse(url), body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);

        print(res);
        _isLoading = false;
        _resMessage = "Login successfull!";
        notifyListeners();

        ///Save users data and then navigate to homepage
//shared_preference is used to store the user data and token
//http package was used to make a request and login a new user
        final userId = res['user']['id'];
        final token = res['authToken'];
//Now we save the userId and token in our DatabaseProvider
        DatabaseProvider().saveToken(token);
        DatabaseProvider().saveUserId(userId);
//Once we have saved the data, we navigate the user to the homePage
        PageNavigator(ctx: context).nextPageOnly(page: const HomePage());
      } else {
        final res = json.decode(req.body);

        _resMessage = res['message'];

        print(res);
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
