import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_apps/bloc/shared_pref/shared_pref_provider.dart';

import '../bloc/scheduling/scheduling_provider.dart';
import '../utils/styles.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(settingsTitle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Consumer<SharedPrefProvider>(
                builder: (context, provider, child) {
                  return Material(
                    child: ListTile(
                      title: const Text('Scheduling Restaurant'),
                      trailing: Consumer<SchedulingProvider>(
                        builder: (context, scheduled, _) {
                          return Switch.adaptive(
                            activeColor: secondaryColor,
                            value: provider.isDailyActive,
                            onChanged: (value) async {
                              scheduled.scheduledRestaurant(value);
                              provider.enableDailyActive(value);
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
