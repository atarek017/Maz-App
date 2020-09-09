import 'package:flutter/material.dart';
import 'package:ms_app_round3/src/core/provider/mony_provider.dart';
import 'package:ms_app_round3/src/screens/home_page.dart';
import 'package:ms_app_round3/src/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'core/provider/add_day_provider.dart';
import 'core/provider/product_provider.dart';
import 'core/provider/user_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: AddDayProvider()),
        ChangeNotifierProvider.value(value: ProductProvider()),
        ChangeNotifierProvider.value(value: MoneyProvider()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.green,
        ),
        home: SplashScreen(),
      ),
    );
  }
}