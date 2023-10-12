import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/widgets/build_custom_circular_image_loading.dart';
import 'package:aqua_meals_seller/widgets/build_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

String? getCurrentDate() {
  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  return "$day/$month/$year";
}

extension StringExtension on String {
  String capitalize() {
    if (isNotEmpty) {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    } else {
      return "";
    }
  }
}

extension LightMode on BuildContext {
  /// is dark mode currently enabled?
  bool get isLightMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.light;
  }
}

navigatePushReplacement({BuildContext? context, Widget? widget}) {
  Navigator.pushReplacement(
      context!, MaterialPageRoute(builder: ((context) => widget!)));
}

navigatePush({BuildContext? context, Widget? widget}) {
  Navigator.push(context!, MaterialPageRoute(builder: ((context) => widget!)));
}

class GlobalMethods {
  showSnackbar({
    BuildContext? context,
    String? message,
  }) {
    return ScaffoldMessenger.of(context!)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message!,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(15),
            ),
          ),
          width: SizeConfig.screenWidth,
          dismissDirection: DismissDirection.down,
        ),
      );
  }

  Future<dynamic> showErrorMessage({
    BuildContext? context,
    String? title,
    String? description,
    String? buttonText,
    void Function()? onPressed,
  }) {
    return showDialog(
        context: context!,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.error_outline_rounded, color: Colors.red),
                SizedBox(width: getProportionateScreenWidth(5)),
                Flexible(
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            content: Text(
              description!,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
              ),
            ),
            elevation: 0,
            scrollable: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            actions: [
              BuildSmallButton(
                text: buttonText,
                onPressed: onPressed,
                width: 70,
                height: 40,
                backgroundcolor: Theme.of(context).primaryColor,
              ),
            ],
            contentPadding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10),
                horizontal: getProportionateScreenWidth(24)),
          );
        });
  }

  Future<dynamic> showAlertMessage({
    BuildContext? context,
    String? title,
    String? description,
    String? leftButtonText,
    void Function()? onPressedLeftButton,
    String? rightButtonText,
    void Function()? onPressedRightButton,
  }) {
    return showDialog(
        context: context!,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.error_outline_rounded, color: Colors.red),
                SizedBox(width: getProportionateScreenWidth(5)),
                Flexible(
                  child: Text(
                    title!,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(20),
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            content: Text(
              description!,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
              ),
            ),
            elevation: 0,
            scrollable: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            actions: [
              BuildSmallButton(
                text: leftButtonText!,
                backgroundcolor: Colors.green.withOpacity(0.7),
                onPressed: onPressedLeftButton,
              ),
              BuildSmallButton(
                text: rightButtonText!,
                backgroundcolor: Colors.red.withOpacity(0.7),
                onPressed: onPressedRightButton,
              ),
            ],
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actionsPadding:
                EdgeInsets.only(bottom: getProportionateScreenHeight(10)),
            contentPadding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10),
                horizontal: getProportionateScreenWidth(24)),
          );
        });
  }

  showIconLoading({required BuildContext context}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: LoadingIcon(),
      ),
    );
  }

  launchURL({required String? url, required BuildContext context}) async {
    try {
      Uri uri = Uri.parse(url!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw "Error occured, trying to launch.";
      }
    } catch (e) {
      GlobalMethods().showErrorMessage(
        context: context,
        title: "Unexpected Error",
        description: e.toString(),
        buttonText: "OK",
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }
  }
}
