import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/models/terms_and_condition.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/providers/terms_and_condition_provider.dart';
import 'package:aqua_meals_seller/widgets/build_custom_back_button.dart';
import 'package:aqua_meals_seller/widgets/build_wave_logo_header.dart';
import 'package:aqua_meals_seller/widgets/build_login_signup_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermsAndCondition extends StatelessWidget {
  static const String routeName = "/TermsAndCondition";

  const TermsAndCondition({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final termsAndConditionProvider =
        Provider.of<TermsAndConditionProvider>(context);
    List<TermsAndConditionModel> termsAndConditionList =
        termsAndConditionProvider.getTermsAndConditionList;
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  const WaveLogoHeader(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: Column(
                      children: [
                        const HeaderText(
                          firstText: "Terms & Condition",
                          lastText:
                              "Please read these terms & conditions carefully before using the Aqua Meal application.",
                        ),
                        ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                              height: getProportionateScreenHeight(10)),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(10)),
                          itemCount: termsAndConditionList.length,
                          itemBuilder: (context, index) =>
                              ChangeNotifierProvider.value(
                            value: termsAndConditionList[index],
                            child: const TitleWithDescriptionTile(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              BuildCustomBackButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleWithDescriptionTile extends StatelessWidget {
  const TitleWithDescriptionTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final termsAndConditionModel = Provider.of<TermsAndConditionModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          termsAndConditionModel.title!,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: context.isLightMode
                ? kLightCanvasColor
                : kLightCanvasColor.withOpacity(0.9),
            fontWeight: FontWeight.w700,
            fontSize: getProportionateScreenWidth(15),
          ),
        ),
        Text(
          termsAndConditionModel.descrition!,
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: context.isLightMode
                ? kLightCanvasColor.withOpacity(0.8)
                : kLightCanvasColor.withOpacity(0.5),
            fontSize: getProportionateScreenWidth(15),
          ),
        ),
      ],
    );
  }
}
