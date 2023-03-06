// Flutter imports:
import 'package:flutter/material.dart';
import 'package:restaurants_apps/utils/styles.dart';


class SearchIntro extends StatelessWidget {
  final bool? visible;

  const SearchIntro({Key? key, this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: visible == true ? 1.0 : 0.0,
      child: Container(
        alignment: FractionalOffset.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20.0),
            Icon(Icons.info, color: Colors.green[200], size: 50.0),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 80.0),
              child: const Text(
                "Masukkan kata untuk memulai pencarian",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: appPrimaryText,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
