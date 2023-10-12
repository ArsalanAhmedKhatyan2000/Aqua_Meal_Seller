import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BuildCircularPercentageIndicator extends StatelessWidget {
  final String? _centerText;
  final String? _bottomLabel;
  final double? _percentage;
  const BuildCircularPercentageIndicator({
    Key? key,
    String? centerText,
    String? bottomLabel,
    double? percentage,
  })  : _centerText = centerText,
        _bottomLabel = bottomLabel,
        _percentage = percentage,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CircularPercentIndicator(
        radius: getProportionateScreenWidth(60),
        lineWidth: getProportionateScreenWidth(10),
        animation: true,
        animationDuration: 500,
        percent: _percentage!,
        circularStrokeCap: CircularStrokeCap.round,
        backgroundColor:
            context.isLightMode ? const Color(0xFFB8C7CB) : kDarkCardColor!,
        progressColor: context.isLightMode
            ? Theme.of(context).primaryColor
            : kLightCanvasColor,
        center: Text(
          _centerText!,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: getProportionateScreenWidth(20)),
        ),
        footer: Text(
          _bottomLabel!.capitalize(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: getProportionateScreenWidth(16)),
        ),
      ),
    );
  }
}
