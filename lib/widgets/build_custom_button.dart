import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class BuildSmallButton extends StatelessWidget {
  final void Function()? _onPressed;
  final String? _text;
  final Color? _backgroundcolor;
  final double? _width, _hight;
  const BuildSmallButton({
    Key? key,
    required void Function()? onPressed,
    required String? text,
    Color? backgroundcolor,
    double? width = 100,
    double? height = 40,
  })  : _onPressed = onPressed,
        _text = text,
        _backgroundcolor = backgroundcolor,
        _width = width,
        _hight = height,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(_width!),
      height: getProportionateScreenHeight(_hight!),
      child: ElevatedButton(
        onPressed: _onPressed,
        child: Text(
          _text!,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenWidth(15),
          ),
        ),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(
            _backgroundcolor ?? whiteColor.withOpacity(0.3),
          ),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)))),
        ),
      ),
    );
  }
}

class CustomLargeButton extends StatelessWidget {
  final String? _text;
  final void Function()? _onPressed;
  final bool _isDisable;
  final Color? _buttonColor;
  final double? _width, _height;
  const CustomLargeButton({
    Key? key,
    required String? text,
    required void Function()? onPressed,
    bool isDisable = false,
    Color? buttonColor,
    double? width,
    double? height = 50,
  })  : _text = text,
        _onPressed = onPressed,
        _isDisable = isDisable,
        _buttonColor = buttonColor,
        _width = width,
        _height = height,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width ?? SizeConfig.screenWidth,
      height: getProportionateScreenHeight(_height!),
      child: ElevatedButton(
        onPressed: _onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              (_isDisable == true && _buttonColor == null)
                  ? Colors.white.withOpacity(0.3)
                  : (_isDisable == true && _buttonColor != null)
                      ? _buttonColor!.withOpacity(0.6)
                      : _buttonColor ?? whiteColor.withOpacity(0.5)),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(getProportionateScreenWidth(30))),
              side: BorderSide(
                color: _isDisable ? whiteColor.withOpacity(0.3) : whiteColor,
              ))),
        ),
        child: Text(
          _text!,
          style: TextStyle(
            color: _isDisable ? Colors.white.withOpacity(0.3) : whiteColor,
            fontWeight: FontWeight.w700,
            fontSize: getProportionateScreenWidth(16),
          ),
        ),
      ),
    );
  }
}
