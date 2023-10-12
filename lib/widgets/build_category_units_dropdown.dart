import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/models/categories.dart';
import 'package:aqua_meals_seller/models/units.dart';
import 'package:aqua_meals_seller/providers/category_provider.dart';
import 'package:aqua_meals_seller/providers/units_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomUnitsCategoryDropdown extends StatelessWidget {
  final String? _value;
  final bool? _isCategory;
  final void Function(String?)? _onchanged;
  final bool? _isSelected;
  const CustomUnitsCategoryDropdown({
    Key? key,
    String? value,
    bool? isCategory = false,
    void Function(String?)? onchanged,
    bool? isSelected,
  })  : _value = value,
        _onchanged = onchanged,
        _isCategory = isCategory,
        _isSelected = isSelected,
        super(key: key);

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
    final unitsProvider = Provider.of<UnitsProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final List<UnitsModel> unitsList = unitsProvider.getUnitsList;
    final List<CategoryModel> categoryList = categoryProvider.getCategories;

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
      isEmpty: _value == '',
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          onChanged: _onchanged,
          value: _value,
          items: _isCategory == true
              ? (categoryList).map((value) {
                  return DropdownMenuItem(
                    child: Text(
                      value.name!,
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(15)),
                    ),
                    value: value.name!,
                  );
                }).toList()
              : unitsList.map((value) {
                  return DropdownMenuItem(
                    child: Text(
                      value.name!,
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(15)),
                    ),
                    value: value.name!,
                  );
                }).toList(),
          isDense: true,
          iconEnabledColor: (_isSelected! && context.isLightMode == true)
              ? Theme.of(context).primaryColor
              : ((_isSelected! && context.isLightMode == false))
                  ? kLightCanvasColor
                  : Colors.red,
          isExpanded: true,
          hint: Text(
            _isCategory == true ? "Categories" : "Units",
            style: TextStyle(
              color: dimmTextColor,
              fontSize: getProportionateScreenWidth(15),
            ),
          ),
        ),
      ),
    );
  }
}
