import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/helper/wave_clipper.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class WaveLogoHeader extends StatelessWidget {
  const WaveLogoHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperBottom(),
      child: Container(
        height: getProportionateScreenHeight(140),
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.all(getProportionateScreenWidth(20)),
        decoration: BoxDecoration(
          color: context.isLightMode ? whiteColor : kLightCanvasColor,
        ),
        child: Image.asset(
          context.isLightMode ? lightThemeLogo! : darkThemeLogo!,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
