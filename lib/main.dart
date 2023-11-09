import 'package:danny_api/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/authProvider/auth_provider.dart';
import 'provider/database/db_provider.dart';
import 'styles/colors.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(create: (_) => AddTaskProvider()),
        ChangeNotifierProvider(create: (_) => DeleteTaskProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: primaryColor,
            ),
            floatingActionButtonTheme:
                FloatingActionButtonThemeData(backgroundColor: primaryColor),
            primaryColor: primaryColor),
        home: const SplashScreen(),
      ),
    );
  }
}
