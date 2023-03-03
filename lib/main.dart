import 'package:flutter/material.dart';
import 'package:restaurants_apps/splash_screen.dart';
import 'package:restaurants_apps/ui/details_page.dart';
import 'package:restaurants_apps/ui/menu_list_page.dart';
import 'package:restaurants_apps/utils/fonts.dart';
import 'package:restaurants_apps/utils/styles.dart';

import 'model/restaurant.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: ThemeData(
        textTheme: myTextTheme,
        appBarTheme: const AppBarTheme(elevation: 0),
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: Colors.black,
              secondary: secondaryColor,
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: secondaryColor,
          onPrimary: Colors.white,
          textStyle: const TextStyle(),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
        )),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        MenuListPage.routeName: (context) => const MenuListPage(),
        DetailsPage.routeName: (context) => DetailsPage(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant),
      },
    );
  }
}
