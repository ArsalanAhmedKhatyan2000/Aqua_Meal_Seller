import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/models/about.dart';
import 'package:aqua_meals_seller/screens/about_us/components/social_media_icons_strip.dart';
import 'package:aqua_meals_seller/widgets/build_custom_back_button.dart';
import 'package:aqua_meals_seller/widgets/build_title_with_description.dart';
import 'package:aqua_meals_seller/widgets/build_wave_logo_header.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutUs extends StatelessWidget {
  static const String routeName = "/AboutUs";
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final aboutProvider = Provider.of<AboutProvider>(context);
    List<AboutModel> aboutDataList = aboutProvider.getAboutList;
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
                  padding: EdgeInsets.fromLTRB(
                    getProportionateScreenWidth(20),
                    0,
                    getProportionateScreenWidth(20),
                    getProportionateScreenHeight(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: aboutDataList.length,
                        separatorBuilder: ((context, index) => SizedBox(
                              height: getProportionateScreenHeight(10),
                            )),
                        padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(10),
                        ),
                        itemBuilder: ((context, index) {
                          return BuildTitleWithDescription(
                            title: aboutDataList[index].getTitle,
                            description: aboutDataList[index].getDescription,
                          );
                        }),
                      ),
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
    ));
  }
}
