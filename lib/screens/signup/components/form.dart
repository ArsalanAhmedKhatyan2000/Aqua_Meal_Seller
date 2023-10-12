import 'dart:io';
import 'package:aqua_meals_seller/screens/signup/components/build_checkbox.dart';
import 'package:aqua_meals_seller/widgets/build_custom_button.dart';
import 'package:aqua_meals_seller/widgets/build_custom_text_field.dart';
import 'package:path/path.dart';
import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/screens/login/login.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/helper/validations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  final String? _imagePath;
  const SignupForm({
    Key? key,
    required String? imagePath,
  })  : _imagePath = imagePath,
        super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isCheckedTermsAndCondition = false;

  final TextEditingController? _nameController = TextEditingController();
  final TextEditingController? _emailController = TextEditingController();
  final TextEditingController? _passwordController = TextEditingController();
  final TextEditingController? _confirmPasswordController =
      TextEditingController();
  final TextEditingController? _phoneNumberController = TextEditingController();
  final TextEditingController? _cnicController = TextEditingController();

  @override
  void dispose() {
    _nameController!.dispose();
    _emailController!.dispose();
    _passwordController!.dispose();
    _confirmPasswordController!.dispose();
    _phoneNumberController!.dispose();
    _cnicController!.dispose();
    // _formKey.currentState!.dispose();
    super.dispose();
  }

  void isCheckedTermsAndCondition() {
    setState(() {
      _isCheckedTermsAndCondition = !_isCheckedTermsAndCondition;
    });
  }

  void createUser(BuildContext context) async {
    final FormState? _key = _formKey.currentState!;
    bool isValidated = FieldValidations.validationOnButton(formKey: _key);

    String? _userCreatedDate = getCurrentDate();
    String _name = _nameController!.text.trim();
    String _email = _emailController!.text.trim();
    String _password = _passwordController!.text.trim();
    String _confirmPassword = _confirmPasswordController!.text.trim();
    String _phoneNumber = _phoneNumberController!.text.trim();
    String _cnic = _cnicController!.text.trim();

    File _profileImageFile = File(widget._imagePath!);
    String _imageBaseName = basename(_profileImageFile.path);

    if (isValidated == true) {
      if (_profileImageFile.path != "") {
        if (_isCheckedTermsAndCondition == true) {
          if (_password == _confirmPassword) {
            // showDialog(
            //   context: context,
            //   barrierDismissible: false,
            //   builder: (context) => const Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // );
            GlobalMethods().showIconLoading(context: context);
            try {
              FirebaseAuth auth = FirebaseAuth.instance;
              final UserCredential _user =
                  await auth.createUserWithEmailAndPassword(
                      email: _email, password: _confirmPassword);

              String _userID = _user.user!.uid;

              Reference ref = FirebaseStorage.instance.ref().child(
                  "images/Sellers/$_userID/userProfileImage/$_imageBaseName");

              await ref.putFile(_profileImageFile);
              String _getUserProfileImageUrl = await ref.getDownloadURL();

              FirebaseFirestore _db = FirebaseFirestore.instance;
              await _db
                  .collection("users")
                  .doc("WvamEGwHsbNkF3KImk2V")
                  .collection("sellers")
                  .doc(_userID)
                  .set({
                "userID": _userID,
                "name": _name,
                "email": _email,
                "password": _confirmPassword,
                "phoneNumber": _phoneNumber,
                "cnic": _cnic,
                "profileImage": _getUserProfileImageUrl,
                "createdDate": _userCreatedDate,
                "address": "",
                "status": 0,
                "rating": [],
              });
              Navigator.popUntil(context, (route) => route.isFirst);
              // Navigator.pushReplacementNamed(context, Login.routeName!);
              navigatePushReplacement(context: context, widget: const Login());
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
          } else {
            Navigator.popUntil(context, (route) => route.isFirst);
            GlobalMethods().showErrorMessage(
              context: context,
              title: "Invalid Password",
              description:
                  "Confirm password is not matched with the password, please provide the same password in both fields to proceed.",
              buttonText: "OK",
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            );
          }
        } else {
          Navigator.popUntil(context, (route) => route.isFirst);
          GlobalMethods().showErrorMessage(
            context: context,
            title: "Unchecked Terms and Conditions.",
            description:
                "Terms and Conditions checkbox is unchecked yet. please click on the terms and condition checkbox.",
            buttonText: "OK",
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          );
        }
      } else {
        Navigator.popUntil(context, (route) => route.isFirst);
        GlobalMethods().showErrorMessage(
          context: context,
          title: "Profile Image",
          description:
              "Profile image is not uploaded yet. please upload your profile image.",
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
            hintText: "Enter your name",
            prefixIcon: Icons.person_outline,
            textInputType: TextInputType.name,
            controller: _nameController,
            validator: (value) {
              return FieldValidations.isName(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
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
          PasswordTextFormField(
            hintText: "Confirm your password",
            controller: _confirmPasswordController,
            validator: (value) {
              return FieldValidations.isPassword(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          CustomTextFormField(
            hintText: "Enter your number",
            prefixIcon: Icons.phone_outlined,
            textInputType: TextInputType.number,
            controller: _phoneNumberController,
            validator: (value) {
              return FieldValidations.isPhoneNumber(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          CustomTextFormField(
            hintText: "Enter your CNIC number",
            prefixIcon: Icons.credit_card_outlined,
            textInputType: TextInputType.number,
            controller: _cnicController,
            validator: (value) {
              return FieldValidations.isCNIC(value: value);
            },
          ),
          SizedBox(height: getProportionateScreenHeight(4)),
          TermsConditionCheckBox(
            isCheckedTermsAndCondition: _isCheckedTermsAndCondition,
            onChange: (value) {
              isCheckedTermsAndCondition();
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          CustomLargeButton(
            text: "Sign up",
            isDisable: false,
            onPressed: () async {
              createUser(context);
            },
          ),
        ],
      ),
    );
  }
}
