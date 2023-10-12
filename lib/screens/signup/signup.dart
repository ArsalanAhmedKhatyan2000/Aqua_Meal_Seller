import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/screens/login/login.dart';
import 'package:aqua_meals_seller/screens/signup/components/circular_profile.dart';
import 'package:aqua_meals_seller/screens/signup/components/form.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/widgets/build_have_an_account_strip.dart';
import 'package:aqua_meals_seller/widgets/build_wave_logo_header.dart';
import 'package:aqua_meals_seller/widgets/build_login_signup_heading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget {
  static const String routeName = "/Signup";
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? _imagePath = "";

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final _image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imagePath = _image!.path;
    });
  }

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
                        horizontal: getProportionateScreenWidth(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const HeaderText(
                          firstText: "Sign up",
                          lastText: "Please sign up to register",
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        SignupForm(imagePath: _imagePath),
                        SizedBox(height: getProportionateScreenHeight(39)),
                        NoAccountStrip(
                          firstText: "Already have an account? ",
                          lastText: "Sign in",
                          onTap: () {
                            navigatePushReplacement(
                                context: context, widget: const Login());
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(220),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircularProfile(
                            onTap: pickImage,
                            imagePath: _imagePath.toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
