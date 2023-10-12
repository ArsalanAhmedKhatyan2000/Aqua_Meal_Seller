import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/screens/login/components/form.dart';
import 'package:aqua_meals_seller/screens/signup/signup.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/widgets/build_have_an_account_strip.dart';
import 'package:aqua_meals_seller/widgets/build_wave_logo_header.dart';
import 'package:aqua_meals_seller/widgets/build_login_signup_heading.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  static const String routeName = "/signin";
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const WaveLogoHeader(),
              SizedBox(
                height:
                    SizeConfig.screenHeight - getProportionateScreenHeight(175),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: [
                      const HeaderText(
                        firstText: "Welcome back!",
                        lastText: "Please sign in to continue",
                      ),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      const SigninForm(),
                      const Spacer(),
                      NoAccountStrip(
                        firstText: "Don't have an account? ",
                        lastText: "Sign up",
                        onTap: () {
                          navigatePushReplacement(
                              context: context, widget: const Signup());
                        },
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
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
