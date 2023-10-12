import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:flutter/material.dart';

const String? lightThemeLogo = "assets/images/lightThemeLogo.png";
const String? darkThemeLogo = "assets/images/darkThemeLogo.png";
const String? loadingFishImage = "assets/images/loadingFishImage.svg";

String? instagramAccountURL = "https://www.instagram.com/aqua_meals/";
String? twitterAccountURL = "https://twitter.com/AquaMeals";
String? facebookPageURL =
    "https://www.facebook.com/people/Aqua-Meals/100084544783230/";
String? youtubeChannelURL =
    "https://www.youtube.com/channel/UCWD8x7BudOgsWJCcGWeribQ";

String? aquaMealEmail = "aquameals19@gmail.com";
String? phoneNumber = "+923412234864";
String? whatsappNumber = "+923412234864";

const double orderTax = 100;
const double deliveryPrice = 150;
const double discountPercentage = 0;

const Map<int, Color> color = {
  50: Color.fromRGBO(33, 137, 235, .1),
  100: Color.fromRGBO(33, 137, 235, .2),
  200: Color.fromRGBO(33, 137, 235, .3),
  300: Color.fromRGBO(33, 137, 235, .4),
  400: Color.fromRGBO(33, 137, 235, .5),
  500: Color.fromRGBO(33, 137, 235, .6),
  600: Color.fromRGBO(33, 137, 235, .7),
  700: Color.fromRGBO(33, 137, 235, .8),
  800: Color.fromRGBO(33, 137, 235, .9),
  900: Color.fromRGBO(33, 137, 235, 1),
};

const MaterialColor colorCustom = MaterialColor(0xFF0977de, color);

//primary color
const Color kLightPrimaryColor = Color(0xFF2189eb);
const Color kDarkPrimaryColor = Color(0xFF000000);
//card Color
const Color klightCardColor = Color(0xFFffffff);
Color? kDarkCardColor = const Color(0xFF000000);
//Canvas Color
const Color kLightCanvasColor = Color(0xfff5f5f5);
Color? kDarkConvasColor = Colors.grey[900];
//Text Color
const Color klightTextColor = Color(0xFF000000);
const Color kDarkTextColor = Color(0xFFffffff);

const Color whiteColor = Color(0xFFffffff);

OutlineInputBorder coloredErrorOutlineInputBorder() {
  return OutlineInputBorder(
    borderRadius:
        BorderRadius.all(Radius.circular(getProportionateScreenWidth(30))),
    borderSide: const BorderSide(color: Colors.red),
  );
}

OutlineInputBorder coloredOutlineInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius:
        BorderRadius.all(Radius.circular(getProportionateScreenWidth(30))),
    borderSide: BorderSide(
      color: context.isLightMode
          ? Theme.of(context).primaryColor
          : kLightCanvasColor,
    ),
  );
}

OutlineInputBorder loginSignupFieldsBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius:
        BorderRadius.all(Radius.circular(getProportionateScreenWidth(30))),
    borderSide: const BorderSide(
      color: kLightCanvasColor,
    ),
  );
}

OutlineInputBorder buildCustomOutlineInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(
        color:
            context.isLightMode ? Theme.of(context).primaryColor : whiteColor),
  );
}
