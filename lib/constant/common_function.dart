import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_color.dart';


class CommonFunction {
  static void showLoadingDialog(BuildContext context) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center( // Center the loading indicator
        child: SpinKitFadingCircle(
          size: 50.0,
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: index.isOdd ? AppColor.primary : AppColor.secondary,
              ),
            );
          },
        ),
      );
    },
  );

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(); // Close the dialog
  }

  static Widget showLoadingIndicator() {
    return const Center(
      child: SpinKitThreeBounce(
        color: Colors.white,
        size: 20.0,
      ),
    );
  }

  static void showToast(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
