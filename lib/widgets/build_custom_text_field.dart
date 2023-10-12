import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? _controller;
  final IconData? _prefixIcon;
  final String? _hintText;
  final TextInputType? _textInputType;
  final String? Function(String?)? _validator;
  const CustomTextFormField({
    Key? key,
    TextEditingController? controller,
    IconData? prefixIcon,
    String? hintText,
    TextInputType? textInputType,
    String? Function(String?)? validator,
  })  : _controller = controller,
        _prefixIcon = prefixIcon,
        _hintText = hintText,
        _textInputType = textInputType,
        _validator = validator,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color dimmWhiteLightColor = kLightCanvasColor.withOpacity(0.7);
    Color dimmWhiteDarkColor = kLightCanvasColor.withOpacity(0.5);
    return TextFormField(
      controller: _controller,
      validator: _validator,
      keyboardType: _textInputType,
      cursorColor: kLightCanvasColor,
      style: TextStyle(
          color: whiteColor, fontSize: getProportionateScreenWidth(15)),
      decoration: InputDecoration(
        hintText: _hintText,
        hintStyle: TextStyle(
            color:
                context.isLightMode ? dimmWhiteLightColor : dimmWhiteDarkColor),
        prefixIcon: Icon(_prefixIcon, color: kLightCanvasColor),
        contentPadding:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(13)),
        enabledBorder: loginSignupFieldsBorder(context),
        focusedBorder: loginSignupFieldsBorder(context),
        border: loginSignupFieldsBorder(context),
        errorBorder: coloredErrorOutlineInputBorder(),
        filled: true,
        fillColor: context.isLightMode
            ? whiteColor.withOpacity(0.35)
            : whiteColor.withOpacity(0.3),
      ),
    );
  }
}

class PasswordTextFormField extends StatefulWidget {
  final String? _hintText;
  final TextEditingController? _controller;
  final String? Function(String?)? _validator;
  // final String? _labelText;
  const PasswordTextFormField({
    Key? key,
    required String? hintText,
    required TextEditingController? controller,
    String? Function(String?)? validator,
  })  : _hintText = hintText,
        _controller = controller,
        _validator = validator,
        super(key: key);

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _obsecure = true;

  isPasswordVisibile() {
    setState(() {
      _obsecure = !_obsecure;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color dimmWhiteLightColor = kLightCanvasColor.withOpacity(0.7);
    Color dimmWhiteDarkColor = kLightCanvasColor.withOpacity(0.5);
    return TextFormField(
      controller: widget._controller,
      obscureText: _obsecure,
      validator: widget._validator,
      keyboardType: TextInputType.text,
      cursorColor: kLightCanvasColor,
      style: TextStyle(
          color: whiteColor, fontSize: getProportionateScreenWidth(15)),
      decoration: InputDecoration(
        hintText: widget._hintText,
        hintStyle: TextStyle(
            color:
                context.isLightMode ? dimmWhiteLightColor : dimmWhiteDarkColor),
        prefixIcon: const Icon(Icons.lock_outline, color: kLightCanvasColor),
        suffixIcon: GestureDetector(
          onTap: isPasswordVisibile,
          child: _obsecure
              ? Icon(Icons.visibility_off,
                  color: context.isLightMode
                      ? kLightCanvasColor.withOpacity(0.8)
                      : dimmWhiteLightColor)
              : const Icon(Icons.visibility, color: whiteColor),
        ),
        contentPadding:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(13)),
        enabledBorder: loginSignupFieldsBorder(context),
        focusedBorder: loginSignupFieldsBorder(context),
        border: loginSignupFieldsBorder(context),
        errorBorder: coloredErrorOutlineInputBorder(),
        filled: true,
        fillColor: context.isLightMode
            ? whiteColor.withOpacity(0.35)
            : whiteColor.withOpacity(0.3),
      ),
    );
  }
}
