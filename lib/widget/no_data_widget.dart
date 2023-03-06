// Project imports:

import 'package:flutter/material.dart';
import 'package:restaurants_apps/utils/styles.dart';

class NoDataWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const NoDataWidget({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.asset(
                    'assets/no-data.png',
                    fit: BoxFit.fill,
                    // color: iconColor ?? MyColors.appPrimaryColor.withAlpha(200),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 2),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: kTextColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
