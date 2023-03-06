import 'package:flutter/material.dart';

class LoadDataError extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color bgColor;
  final Function onTap;

  const LoadDataError(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.bgColor,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: CircleAvatar(
                child: Text(':('),
                foregroundColor: Colors.white,
                backgroundColor: bgColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                title,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            Text.rich(
              TextSpan(
                text: subtitle,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // onTap != null
            //     ? ButtonSubmitWidget(
            //         width: Get.width / 2,
            //         title: "TRY_AGAIN".tr.toUpperCase(),
            //         bgColor: MyColors.appPrimaryColor,
            //         textColor: MyColors.white,
            //         onPressed: onTap,
            //         loading: false,
            //       )
            //     : Container(),
          ],
        ),
      ),
    );
  }
}
