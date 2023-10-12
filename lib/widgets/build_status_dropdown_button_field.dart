import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class StatusDropdownButtonField extends StatelessWidget {
  final Function(String?)? _onChanged;
  final String? _currentValue;
  final bool? _isSelected;

  StatusDropdownButtonField({
    Key? key,
    Function(String?)? onChanged,
    String? currentValue,
    bool? isSelected,
  })  : _onChanged = onChanged,
        _currentValue = currentValue,
        _isSelected = isSelected,
        super(key: key);

  final items = ['Active', 'In-Active'];

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      child: Text(item),
      value: item,
    );
  }

  OutlineInputBorder coloredOutlineInputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        color: (_isSelected! && context.isLightMode == true)
            ? Theme.of(context).primaryColor
            : ((_isSelected! && context.isLightMode == false))
                ? kLightCanvasColor
                : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color dimmTextColor =
        Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5);
    return InputDecorator(
      decoration: InputDecoration(
        enabledBorder: coloredOutlineInputBorder(context),
        border: coloredOutlineInputBorder(context),
        focusedBorder: coloredOutlineInputBorder(context),
        errorBorder: coloredErrorOutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(13),
            horizontal: getProportionateScreenHeight(13)),
        filled: true,
        fillColor: Theme.of(context).cardColor,
      ),
      isEmpty: _currentValue == '',
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          items: [
            DropdownMenuItem(
              child: Text(
                "Active".capitalize(),
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                ),
              ),
              value: "1",
            ),
            DropdownMenuItem(
              child: Text(
                "In-Active".capitalize(),
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                ),
              ),
              value: "0",
            ),
          ],
          hint: Text(
            "Select your product status",
            style: TextStyle(
              color: dimmTextColor,
              fontSize: getProportionateScreenWidth(15),
            ),
          ),
          iconEnabledColor: (_isSelected! && context.isLightMode == true)
              ? Theme.of(context).primaryColor
              : ((_isSelected! && context.isLightMode == false))
                  ? kLightCanvasColor
                  : Colors.red,
          value: _currentValue,
          isDense: true,
          isExpanded: true,
          onChanged: _onChanged,
        ),
      ),
    );
  }
}
