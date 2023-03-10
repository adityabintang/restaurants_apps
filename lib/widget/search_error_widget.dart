// Flutter imports:
import 'package:flutter/material.dart';
import 'package:restaurants_apps/widget/load_data_error.dart';

// Project imports:

class SearchErrorWidget extends StatelessWidget {
  final bool? visible;
  final Function()? onRefresh;

  const SearchErrorWidget({Key? key, this.visible, this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: visible == true ? 1.0 : 0.0,
      child: Center(
        child: LoadDataError(
          onTap: onRefresh ?? (){},
          title: 'Problem Occured',
          subtitle: 'Something Went Wrong',
          bgColor: Colors.red,
        ),
      ),
    );
  }
}
