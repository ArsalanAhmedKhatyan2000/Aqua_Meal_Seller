import 'dart:async';
import 'dart:io';
import 'package:aqua_meals_seller/crud/crud.dart';
import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/helper/validations.dart';
import 'package:aqua_meals_seller/models/users.dart';
import 'package:aqua_meals_seller/providers/products_provider.dart';
import 'package:aqua_meals_seller/screens/my_profile/build_custom_tile.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/screens/my_profile/components/circular_file_image.dart';
import 'package:aqua_meals_seller/screens/my_profile/components/circular_netword_image.dart';
import 'package:aqua_meals_seller/screens/my_profile/components/circular_no_image_widget.dart';
import 'package:aqua_meals_seller/screens/my_profile/components/custom_bottom_modal_sheet.dart';
import 'package:aqua_meals_seller/widgets/build_custom_button.dart';
import 'package:aqua_meals_seller/widgets/build_star_rating.dart';
import 'package:aqua_meals_seller/widgets/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  static const String routeName = "/MyProfile";
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  final TextEditingController? _oldPasswordController = TextEditingController();
  final TextEditingController? _newPasswordController = TextEditingController();
  TextEditingController? _phoneNumberController;
  TextEditingController? _cnicController;
  TextEditingController? _addressController;

  final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneNoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _addressFormKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  String? _imagePath = "";
  File? _selectedImageFile;

  List? _ratingList;
  String? _currentName,
      _currentEmail,
      _currentPhoneNumber,
      _currentAddress,
      _currentCnicNumber,
      _currentProfileNetworkImageURL,
      _duplicateProfileNetworkImageURL;

  String? currentPassword;
  String? passwordSterric;

  bool? _isEmailVarified = false;
  Timer? timer;

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _currentProfileNetworkImageURL = Users.getProfileImageURL ?? "";
    _duplicateProfileNetworkImageURL = _currentProfileNetworkImageURL;
    _currentName = Users.getName ?? "";
    _currentEmail = Users.getEmail ?? "";
    _currentPhoneNumber = Users.getPhoneNumber ?? "";
    _currentAddress = Users.getAddress ?? "";
    _currentCnicNumber = Users.getCnic ?? "";
    currentPassword = Users.getPassword ?? "";
    _nameController = TextEditingController(text: _currentName);
    _emailController = TextEditingController(text: _currentEmail);
    _phoneNumberController = TextEditingController(text: _currentPhoneNumber);
    _cnicController = TextEditingController(text: _currentCnicNumber);
    _addressController = TextEditingController(text: _currentAddress);
    _ratingList = Users.getRating ?? [];
    _isEmailVarified = CRUD().isEmailVerified();
    passwordSterric = createPasswordStaric(password: currentPassword);

    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      checkIsEmailVerified();
    });
  }

  updateUserName({required BuildContext? contextt}) async {
    final FormState? _key = _nameFormKey.currentState!;
    bool isValidated = FieldValidations.validationOnButton(formKey: _key);
    String? _newName = _nameController!.text;
    if (isValidated == true) {
      if (_newName != _currentName) {
        GlobalMethods().showIconLoading(context: context);
        try {
          await CRUD().updateUserProfileDataFieldToFirestore(
            fieldName: "name",
            fieldValue: _newName,
          );
          Users.setName(newName: _newName);
          setState(() {
            _currentName = _newName;
            _nameController!.text = _newName;
          });
          Navigator.popUntil(context, (route) => route.isFirst);
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
    } else {
      setState(() {
        _nameController!.text = Users.getName!;
      });
    }
  }

  updateUserPhoneNumber({required BuildContext? contextt}) async {
    final FormState? _key = _phoneNoFormKey.currentState!;
    bool isValidated = FieldValidations.validationOnButton(formKey: _key);
    String? _newPhoneNumber = _phoneNumberController!.text;
    if (isValidated == true) {
      if (_newPhoneNumber != _currentPhoneNumber) {
        GlobalMethods().showIconLoading(context: context);
        try {
          await CRUD().updateUserProfileDataFieldToFirestore(
            fieldName: "phoneNumber",
            fieldValue: _newPhoneNumber,
          );
          Users.setPhoneNumber(newPhoneNumber: _newPhoneNumber);
          setState(() {
            _currentPhoneNumber = _newPhoneNumber;
            _phoneNumberController!.text = _newPhoneNumber;
          });
          Navigator.popUntil(context, (route) => route.isFirst);
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
    } else {
      setState(() {
        _phoneNumberController!.text = Users.getPhoneNumber!;
      });
    }
  }

  updateUserPassword({required BuildContext? contextt}) async {
    final FormState? _key = _passwordFormKey.currentState!;
    bool isValidated = FieldValidations.validationOnButton(formKey: _key);
    String? _oldPassword = _oldPasswordController!.text;
    String? _newPassword = _newPasswordController!.text;
    if (isValidated == true) {
      if (_newPassword != currentPassword) {
        GlobalMethods().showIconLoading(context: context);
        try {
          CRUD crud = CRUD();
          await crud.reAuthenticateCurrentUser();
          await crud.updatePasswordToAuth(newPassword: _newPassword);
          await crud.updateUserProfileDataFieldToFirestore(
            fieldName: "password",
            fieldValue: _newPassword,
          );
          Users.setPassword(newPassword: _newPassword);
          setState(() {
            currentPassword = _newPassword;
            passwordSterric = createPasswordStaric(password: currentPassword);
            _oldPasswordController!.clear();
            _newPasswordController!.clear();
          });

          Navigator.popUntil(context, (route) => route.isFirst);
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
      } else {}
    } else {
      setState(() {
        _phoneNumberController =
            TextEditingController(text: Users.getPhoneNumber);
      });
    }
  }

  updateUserAddress({required BuildContext? contextt}) async {
    final FormState? _key = _addressFormKey.currentState!;
    bool isValidated = FieldValidations.validationOnButton(formKey: _key);
    String? _newAddress = _addressController!.text;
    if (isValidated == true) {
      if (_newAddress != _currentAddress) {
        GlobalMethods().showIconLoading(context: context);
        try {
          await CRUD().updateUserProfileDataFieldToFirestore(
            fieldName: "address",
            fieldValue: _newAddress,
          );
          Users.setAddress(newAddress: _newAddress);
          setState(() {
            _currentAddress = _newAddress;
            _addressController!.text = _newAddress;
          });
          Navigator.popUntil(context, (route) => route.isFirst);
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
    } else {
      setState(() {
        _addressController!.text = Users.getAddress!;
      });
    }
  }

  updateEmail({required BuildContext? contextt}) async {
    final FormState? _key = _emailFormKey.currentState!;
    bool isValidated = FieldValidations.validationOnButton(formKey: _key);
    String? _newEmail = _emailController!.text;
    if (isValidated == true) {
      if (_newEmail != _currentEmail) {
        GlobalMethods().showIconLoading(context: context);
        try {
          CRUD crud = CRUD();
          await crud.reAuthenticateCurrentUser();
          await crud.updateEmailToAuth(newEmail: _newEmail);
          await crud.updateUserProfileDataFieldToFirestore(
            fieldName: "email",
            fieldValue: _newEmail,
          );
          Users.setEmail(newEmail: _newEmail);
          setState(() {
            _currentEmail = _newEmail;
            _emailController!.text = _newEmail;
          });
          Navigator.popUntil(context, (route) => route.isFirst);
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
      } else {}
    } else {
      setState(() {
        _emailController!.text = Users.getEmail!;
      });
    }
  }

  String? createPasswordStaric({String? password}) {
    int passwordLength = password!.length;
    String? stars = "";

    for (var i = 0; i < passwordLength; i++) {
      stars = stars! + "*";
    }
    return stars;
  }

  emailVerification({BuildContext? contextt}) async {
    try {
      await CRUD().emailVerificationSend().then((value) {
        GlobalMethods().showSnackbar(
          context: contextt,
          message:
              "The email verification link has been sent to ${Users.getEmail}",
        );
      });
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

  checkIsEmailVerified() async {
    CRUD crud = CRUD();
    await crud.reloadUser();
    setState(() {
      _isEmailVarified = crud.isEmailVerified();
    });
    if (_isEmailVarified!) {
      timer!.cancel();
    }
  }

  pickImage({ImageSource? imageSource}) async {
    final imageFile = await _picker.pickImage(source: imageSource!);
    setState(() {
      _selectedImageFile = File(imageFile!.path);
      _imagePath = imageFile.path;
    });
  }

  updateProfileImage() async {
    if (_imagePath != "") {
      GlobalMethods().showIconLoading(context: context);
      try {
        CRUD crud = CRUD();
        String? newProfileImageURL =
            await crud.uploadUserImageToStorage(imagePath: _imagePath);
        crud.updateUserProfileImageDataToFirestore(
            imageURL: newProfileImageURL);
        crud.deleteUserProfileImageFromStorage(
            imageURL: _currentProfileNetworkImageURL);
        Users.setprofileImage(newProfileImage: newProfileImageURL);
        setState(() {
          _currentProfileNetworkImageURL = newProfileImageURL;
          _duplicateProfileNetworkImageURL = newProfileImageURL;
        });
        Navigator.popUntil(context, (route) => route.isFirst);
      } on FirebaseException catch (e) {
        setState(() {
          _currentProfileNetworkImageURL = _duplicateProfileNetworkImageURL;
          _imagePath = "";
          _selectedImageFile = null;
        });
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
        setState(() {
          _currentProfileNetworkImageURL = _duplicateProfileNetworkImageURL;
          _imagePath = "";
          _selectedImageFile = null;
        });
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
      Navigator.pop(context);
    }
  }

  Widget changeProfileImageBottomSheet() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(getProportionateScreenWidth(20)),
          topLeft: Radius.circular(getProportionateScreenWidth(20)),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(getProportionateScreenWidth(20)),
            topLeft: Radius.circular(getProportionateScreenWidth(20)),
          ),
        ),
        padding: EdgeInsets.only(
          right: getProportionateScreenWidth(20),
          left: getProportionateScreenWidth(20),
          top: getProportionateScreenHeight(20),
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: getProportionateScreenHeight(20),
          ),
          child: Wrap(
            runSpacing: getProportionateScreenWidth(10),
            children: [
              Text(
                "Choose Profile Photo",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: getProportionateScreenWidth(17),
                ),
              ),
              Row(
                children: [
                  TextButton.icon(
                    icon: const Icon(
                      Icons.camera,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      pickImage(imageSource: ImageSource.camera);
                    },
                    label: Text(
                      "Camera",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenWidth(15),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    icon: const Icon(
                      Icons.photo,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      pickImage(imageSource: ImageSource.gallery);
                    },
                    label: Text(
                      "Gallery",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenWidth(15),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BuildSmallButton(
                    text: "CANCEL",
                    onPressed: () {
                      setState(() {
                        _imagePath = "";
                        _selectedImageFile = null;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  BuildSmallButton(
                    text: "SAVE",
                    onPressed: () {
                      updateProfileImage();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileImageWidget() {
    return Center(
      child: Stack(
        children: [
          (_selectedImageFile != null)
              ? CircularFileImage(selectedImageFile: _selectedImageFile)
              : (_currentProfileNetworkImageURL!.isNotEmpty)
                  ? CircularNetworkImage(
                      imageURL: _currentProfileNetworkImageURL)
                  : const CircularNoImageWidget(
                      icon: Icons.person_outline_rounded),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  // isDismissible: false,
                  builder: (builder) => changeProfileImageBottomSheet(),
                );
              },
              child: Container(
                width: getProportionateScreenWidth(50),
                height: getProportionateScreenWidth(50),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final productsList = productsProvider.getProductsList;
    double ratingValueOfSeller = 0;
    for (var products in productsList) {
      ratingValueOfSeller =
          ratingCalculator(products.rating!)! + ratingValueOfSeller;
    }

    ratingValueOfSeller = double.parse(
        (ratingValueOfSeller / productsList.length).toStringAsFixed(1));
    SizeConfig().init(context);
    return SafeArea(
      bottom: false,
      top: true,
      child: Scaffold(
        extendBody: true,
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: Text(
            "My Profile",
            style: TextStyle(fontSize: getProportionateScreenWidth(20)),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(0)),
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),
                profileImageWidget(),
                SizedBox(height: getProportionateScreenHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BuildStarRating(ratingValue: ratingValueOfSeller
                        // ratingCalculator(_ratingList!)
                        ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Column(
                  children: [
                    BuildCustomTile(
                      title: "Name",
                      subTitle: _currentName!.capitalize(),
                      leadingIcon: Icons.person,
                      trailingIcon: Icons.edit,
                      onTap: () {
                        customBottomModalSheet(
                          context: context,
                          title: "Change Name",
                          controller: _nameController,
                          inputType: TextInputType.name,
                          hintText: "Enter your name",
                          prefixIcon: Icons.person_outline_rounded,
                          formKey: _nameFormKey,
                          validator: (value) {
                            return FieldValidations.isName(
                              value: value,
                              isProfileScreenName: true,
                              currentName: _currentName,
                            );
                          },
                          onCancel: () {
                            Navigator.pop(context);
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) {
                              setState(() {
                                _nameController!.text = _currentName!;
                              });
                            });
                          },
                          onSave: () {
                            updateUserName(contextt: context);
                          },
                        );
                      },
                    ),
                    BuildCustomTile(
                      title: "Email",
                      subTitle: _currentEmail!.capitalize(),
                      leadingIcon: Icons.email_rounded,
                      trailingIcon: Icons.edit,
                      isEmail: true,
                      isEmailVerified: _isEmailVarified,
                      emailVerificationOnTap: () {
                        emailVerification(contextt: context);
                      },
                      onTap: () {
                        customBottomModalSheet(
                          context: context,
                          title: "Change Email",
                          controller: _emailController,
                          inputType: TextInputType.emailAddress,
                          hintText: "Enter your email",
                          prefixIcon: Icons.email_outlined,
                          formKey: _emailFormKey,
                          validator: (value) {
                            return FieldValidations.isEmail(
                              value: value,
                              isProfileScreenEmail: true,
                              currentEmail: _currentEmail,
                            );
                          },
                          onCancel: () {
                            Navigator.pop(context);
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) {
                              setState(() {
                                _emailController!.text = _currentEmail!;
                              });
                            });
                          },
                          onSave: () {
                            updateEmail(contextt: context);
                          },
                        );
                      },
                    ),
                    BuildCustomTile(
                      title: "Password",
                      subTitle: passwordSterric,
                      leadingIcon: Icons.lock,
                      trailingIcon: Icons.edit,
                      onTap: () {
                        customBottomModalSheet(
                          context: context,
                          title: "Change Password",
                          controller: _oldPasswordController,
                          controllerSecondPass: _newPasswordController,
                          isPass: true,
                          hight: 325,
                          inputType: TextInputType.text,
                          hintText: "Enter your old password",
                          prefixIcon: Icons.lock_outline_rounded,
                          formKey: _passwordFormKey,
                          validator: (value) {
                            return FieldValidations.isCurrentPassword(
                              value: value,
                              currentPassword: currentPassword,
                            );
                          },
                          validatorSecondPass: (value) {
                            return FieldValidations.isCurrentPassword(
                              value: value,
                              isNewPassword: true,
                              currentPassword: currentPassword,
                            );
                          },
                          onCancel: () {
                            Navigator.pop(context);
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) {
                              setState(() {
                                _oldPasswordController!.clear();
                                _newPasswordController!.clear();
                              });
                            });
                          },
                          onSave: () {
                            updateUserPassword(contextt: context);
                          },
                        );
                      },
                    ),
                    BuildCustomTile(
                      title: "Phone Number",
                      subTitle: _currentPhoneNumber,
                      leadingIcon: Icons.phone,
                      trailingIcon: Icons.edit,
                      onTap: () {
                        customBottomModalSheet(
                          context: context,
                          title: "Change Phone Number",
                          controller: _phoneNumberController,
                          inputType: TextInputType.number,
                          hintText: "Enter your phone number",
                          prefixIcon: Icons.phone_outlined,
                          formKey: _phoneNoFormKey,
                          validator: (value) {
                            return FieldValidations.isPhoneNumber(
                              value: value,
                              isProfileScreenPhone: true,
                              currentPhoneNumber: _currentPhoneNumber,
                            );
                          },
                          onCancel: () {
                            Navigator.pop(context);
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) {
                              setState(() {
                                _phoneNumberController!.text =
                                    _currentPhoneNumber!;
                              });
                            });
                          },
                          onSave: () {
                            updateUserPhoneNumber(
                              contextt: context,
                            );
                          },
                        );
                      },
                    ),
                    BuildCustomTile(
                      title: "Address",
                      subTitle: _currentAddress!.capitalize(),
                      leadingIcon: Icons.person_pin_circle_rounded,
                      trailingIcon: Icons.edit,
                      onTap: () {
                        customBottomModalSheet(
                          context: context,
                          title: "Change Address",
                          controller: _addressController,
                          inputType: TextInputType.text,
                          hintText: "Enter your address",
                          prefixIcon: Icons.person_pin_circle_outlined,
                          formKey: _addressFormKey,
                          validator: (value) {
                            return FieldValidations.isAddress(
                              value: value,
                              isProfileScreenAddress: true,
                              currentAddress: _currentAddress,
                            );
                          },
                          onCancel: () {
                            Navigator.pop(context);
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) {
                              setState(() {
                                _addressController!.text = _currentAddress!;
                              });
                            });
                          },
                          onSave: () {
                            updateUserAddress(contextt: context);
                          },
                        );
                      },
                    ),
                    BuildCustomTile(
                      title: "CNIC Number",
                      subTitle: _currentCnicNumber,
                      leadingIcon: Icons.credit_card_outlined,
                      trailingIcon: Icons.edit,
                      isEditable: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

double? ratingCalculator(List ratingList) {
  double ratingValue = 0;
  int count = 0;
  if (ratingList.isNotEmpty) {
    for (String? value in ratingList) {
      ratingValue = ratingValue + double.parse(value!);
      count += 1;
    }
    ratingValue = ratingValue / count;
    int decimalValue =
        int.parse((ratingValue - ratingValue.truncate()).toString()[2]);
    double value = 0;
    switch (decimalValue) {
      case 1:
        value = 0.0;
        break;
      case 2:
        value = 0.0;
        break;
      case 3:
        value = 0.0;
        break;
      case 4:
        value = 0.5;
        break;
      case 5:
        value = 0.5;
        break;
      case 6:
        value = 0.5;
        break;
      case 7:
        value = 0.5;
        break;
      case 8:
        value = 0.5;
        break;
      case 9:
        value = 1;
        break;
      default:
        value = 0.0;
        break;
    }

    return (ratingValue.truncate() + value);
  } else {
    return 0;
  }
}
