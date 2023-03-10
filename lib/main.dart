import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_apps/bloc/favourite/favourite_provider.dart';
import 'package:restaurants_apps/bloc/scheduling/scheduling_provider.dart';
import 'package:restaurants_apps/bloc/shared_pref/shared_pref_provider.dart';
import 'package:restaurants_apps/data/helper/database_helper.dart';
import 'package:restaurants_apps/data/helper/shared_preferences_helper.dart';
import 'package:restaurants_apps/splash_screen.dart';
import 'package:restaurants_apps/ui/details_page.dart';
import 'package:restaurants_apps/ui/home_page.dart';
import 'package:restaurants_apps/ui/menu_list_page.dart';
import 'package:restaurants_apps/utils/fonts.dart';
import 'package:restaurants_apps/utils/navigator.dart';
import 'package:restaurants_apps/utils/styles.dart';
import 'package:restaurants_apps/widget/search_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/helper/notification_helper.dart';
import 'data/model/restaurants.dart';
import 'data/services/background_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initIsolate();

  await AndroidAlarmManager.initialize();

  await notificationHelper.initNotification(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => FavouriteProvider(
                  databaseHelper: DatabaseHelper(),
                )),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SharedPrefProvider(
            sharedPrefHelper: SharedPrefHelper(
              sharedPreference: SharedPreferences.getInstance(),
            ),
          ),
        ),

      ],
      child: Consumer<SharedPrefProvider>(
        builder: (context, provider, child){
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
                    backgroundColor: secondaryColor,
                    foregroundColor: Colors.white,
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
            navigatorKey: navigatorKey,
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => const SplashScreen(),
              MenuListPage.routeName: (context) => const MenuListPage(),
              SearchScreen.routeName: (context) => SearchScreen(),
              HomePage.routeName: (context) => const HomePage(),
              DetailsPage.routeName: (context) => DetailsPage(
                  restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant),
            },
          );
        },
      ),
    );
  }
}
