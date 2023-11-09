import 'package:danny_api/provider/database/db_provider.dart';
import 'package:danny_api/screens/taskpage/home_page.dart';
import 'package:flutter/material.dart';

import 'screens/authentication/login.dart';
import 'utils/routers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: FlutterLogo()),
    );
  }

  void navigate() {
    //Now we keep a logged in user logged in
    Future.delayed(const Duration(seconds: 3), () {
      DatabaseProvider().getToken().then((value) {
        if (value == '') {
          PageNavigator(ctx: context).nextPageOnly(page: const LoginPage());
        } else {
          PageNavigator(ctx: context).nextPageOnly(page: const HomePage());
        }
      });
    });
  }
}
