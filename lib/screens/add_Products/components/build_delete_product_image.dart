import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class BuildDeleteProductImage extends StatelessWidget {
  const BuildDeleteProductImage({
    Key? key,
    required void Function()? onTapDeleteButton,
  })  : _onTapDeleteButton = onTapDeleteButton,
        super(key: key);

  final void Function()? _onTapDeleteButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(170),
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        border: Border.all(
            color: context.isLightMode
                ? Theme.of(context).primaryColor
                : kLightCanvasColor),
        borderRadius:
            BorderRadius.all(Radius.circular(getProportionateScreenHeight(30))),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: _onTapDeleteButton,
                child: Container(
                  alignment: Alignment.center,
                  height: getProportionateScreenHeight(50),
                  padding: EdgeInsets.only(
                    right: getProportionateScreenWidth(10),
                    left: getProportionateScreenWidth(10),
                  ),
                  decoration: BoxDecoration(
                    color: context.isLightMode
                        ? Theme.of(context).primaryColor
                        : kLightCanvasColor,
                    borderRadius: BorderRadius.only(
                      topRight:
                          Radius.circular(getProportionateScreenHeight(30)),
                      bottomLeft:
                          Radius.circular(getProportionateScreenHeight(30)),
                    ),
                  ),
                  child: Icon(
                    Icons.delete,
                    color: context.isLightMode ? whiteColor : kDarkPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
