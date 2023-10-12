import 'package:aqua_meals_seller/crud/crud.dart';
import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/helper/preferences.dart';
import 'package:aqua_meals_seller/screens/home/build_curved_bottom_navigation_bar.dart';
import 'package:aqua_meals_seller/screens/login/components/build_reset_password.dart';
import 'package:aqua_meals_seller/screens/login/reset_password_screen.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/helper/validations.dart';
import 'package:aqua_meals_seller/widgets/build_custom_button.dart';
import 'package:aqua_meals_seller/widgets/build_custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final TextEditingController? _emailController = TextEditingController();

  final TextEditingController? _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }

  void signInUser(BuildContext context) async {
    final FormState? _key = _formKey.currentState!;
    bool isValidated = FieldValidations.validationOnButton(formKey: _key);

    String _email = _emailController!.text.trim();
    String _password = _passwordController!.text.trim();

    if (isValidated == true) {
      GlobalMethods().showIconLoading(context: context);
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        final UserCredential _user = await auth.signInWithEmailAndPassword(
            email: _email, password: _password);

        String _userID = _user.user!.uid;

        CRUD().fetchUserCredentials(userID: _userID);
        await SharedPreferencesHelper().setAuthToken(_userID);

        Navigator.popUntil(context, (route) => route.isFirst);

        navigatePushReplacement(
            context: context, widget: const BuildCurvedBottomNavigationBar());
      } on FirebaseException catch (e) {
        Navigator.popUntil(context, (route) => route.isFirst);
        GlobalMethods().showErrorMessage(
          context: context,
          title: e.code,
          description: e.message,
          buttonText: "OK",
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        );
      } catch (e) {
        Navigator.popUntil(context, (route) => route.isFirst);
        GlobalMethods().showErrorMessage(
          context: context,
          title: "Unexpected Error",
          description: e.toString(),
          buttonText: "OK",
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(
            hintText: "Enter your email",
            prefixIcon: Icons.email_outlined,
            textInputType: TextInputType.emailAddress,
            controller: _emailController,
            validator: (value) {
              return FieldValidations.isEmail(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          PasswordTextFormField(
            hintText: "Enter your password",
            controller: _passwordController,
            validator: (value) {
              return FieldValidations.isPassword(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          ResetPasswordStrip(
            onTap: () {
              navigatePush(
                  context: context,
                  widget: ResetPassword(
                    emailControllerText: _emailController!.text == ""
                        ? ""
                        : _emailController!.text,
                  ));
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          CustomLargeButton(
            text: "Sign in",
            isDisable: false,
            onPressed: () {
              signInUser(context);
            },
          ),
        ],
      ),
    );
  }
}
