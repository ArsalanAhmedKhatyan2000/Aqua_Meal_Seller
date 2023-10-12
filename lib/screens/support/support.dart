import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/screens/about_us/components/social_media_icons_strip.dart';
import 'package:aqua_meals_seller/screens/support/components/list_of_icon_with_label_button.dart';
import 'package:aqua_meals_seller/screens/support/components/my_dialog.dart';
import 'package:aqua_meals_seller/widgets/build_custom_back_button.dart';
import 'package:aqua_meals_seller/widgets/build_title_with_description.dart';
import 'package:aqua_meals_seller/widgets/build_wave_logo_header.dart';
import 'package:flutter/material.dart';

class Support extends StatelessWidget {
  static const String routeName = "/Support";
  const Support({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  const WaveLogoHeader(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const BuildTitleWithDescription(
                          title: "Customer Support",
                          description:
                              "Customer support service is available 24/7 by Aqua Meal customer help center, you can contact us through following mediums.",
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        const ListOfIconWithLabelButton(),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        const BuildTitleWithDescription(
                          title: "Follow Us",
                          description:
                              "For latest update please follow us on our social media platforms.",
                        ),
                        SizedBox(height: getProportionateScreenHeight(5)),
                        const SocialMediaIconsStrip(),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => const MyDialog(),
            );
          },
          child: const Icon(
            Icons.question_mark_rounded,
          ),
        ),
      ),
    );
  }
}
