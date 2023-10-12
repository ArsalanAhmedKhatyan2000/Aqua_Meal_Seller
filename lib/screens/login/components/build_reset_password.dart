import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class ResetPasswordStrip extends StatelessWidget {
  final Function()? _onTap;
  const ResetPasswordStrip({
    Key? key,
    required Function()? onTap,
  })  : _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: _onTap,
          child: Text(
            "Reset password?",
            style: TextStyle(
              color: kLightCanvasColor,
              fontSize: getProportionateScreenWidth(15),
            ),
          ),
        ),
      ],
    );
  }
}
