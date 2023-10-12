import 'dart:io';
import 'package:aqua_meals_seller/models/products.dart';
import 'package:aqua_meals_seller/models/users.dart';
import 'package:aqua_meals_seller/providers/products_provider.dart';
import 'package:aqua_meals_seller/widgets/build_category_units_dropdown.dart';
import 'package:aqua_meals_seller/widgets/build_custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/screens/add_Products/add_update_product_image.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/helper/validations.dart';
import 'package:aqua_meals_seller/widgets/build_status_dropdown_button_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductForm extends StatefulWidget {
  final bool? _isAddProduct;
  final ProductModel? _productData;
  const AddProductForm({
    Key? key,
    required bool? isAddProduct,
    ProductModel? productData,
  })  : _isAddProduct = isAddProduct,
        _productData = productData,
        super(key: key);

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  String? _currentProductStatusValue,
      _selectedCategory,
      _selectedUnit,
      _networkImageURL,
      _removedNetworkImageURL,
      _imagePath = "";
  File? _selectedImageFile;
  bool? _isProductImageSelected = true,
      _isCategorySelected = true,
      _isUnitSelected = true,
      _isStatusSelected = true;

  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController? _productNameController = TextEditingController();
  TextEditingController? _regularPriceController = TextEditingController();
  TextEditingController? _discountedPriceController = TextEditingController();
  TextEditingController? _productDescriptionController =
      TextEditingController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    if (widget._productData != null) {
      setState(() {
        _formKey = GlobalKey();
        _productNameController =
            TextEditingController(text: widget._productData!.name);
        _regularPriceController =
            TextEditingController(text: widget._productData!.regularPrice);
        _discountedPriceController =
            TextEditingController(text: widget._productData!.discountedPrice);
        _productDescriptionController =
            TextEditingController(text: widget._productData!.description);
        _currentProductStatusValue = widget._productData!.status;
        _selectedCategory = widget._productData!.category;
        _selectedUnit = widget._productData!.unit;
        _networkImageURL = widget._productData!.imageUrl;
        _imagePath = "";
        _selectedImageFile = null;
        _isProductImageSelected = true;
        _isCategorySelected = true;
        _isUnitSelected = true;
        _isStatusSelected = true;
      });
    }
  }

  void deleteImageFile() {
    setState(() {
      _imagePath = "";
      _selectedImageFile = null;
      _isProductImageSelected = false;
      _networkImageURL = null;
    });
  }

  void removeNetworkImage() {
    setState(() {
      _removedNetworkImageURL = _networkImageURL;
      _networkImageURL = null;
      _imagePath = "";
      _selectedImageFile = null;
      _isProductImageSelected = false;
    });
  }

  void emptyAllField() {
    setState(() {
      _formKey = GlobalKey();
      _productNameController = TextEditingController();
      _regularPriceController = TextEditingController();
      _discountedPriceController = TextEditingController();
      _productDescriptionController = TextEditingController();
      _currentProductStatusValue = null;
      _selectedCategory = null;
      _selectedUnit = null;
      _imagePath = "";
      _selectedImageFile = null;
      _networkImageURL = null;
      _removedNetworkImageURL = null;
      _isProductImageSelected = true;
      _isCategorySelected = true;
      _isUnitSelected = true;
      _isStatusSelected = true;
    });
  }

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final _image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImageFile = File(_image!.path);
      _imagePath = _image.path;
      _isProductImageSelected = true;
    });
  }

  void uploadProduct(BuildContext context) async {
    if (Users.getStatus != 0) {
      final FormState? _key = _formKey.currentState!;
      bool isValidated = FieldValidations.validationOnButton(formKey: _key);

      String? _createdDate = getCurrentDate();

      if (isValidated == true &&
          _imagePath != "" &&
          _currentProductStatusValue != null &&
          _selectedUnit != null &&
          _selectedCategory != null) {
        GlobalMethods().showIconLoading(context: context);
        try {
          final productProvider =
              Provider.of<ProductsProvider>(context, listen: false);
          String? _getProductImageUrl = await productProvider
              .uploadProductImageToStorage(imagePath: _imagePath);
          await productProvider.addProduct(
            productName: _productNameController!.text.trim(),
            imageURL: _getProductImageUrl,
            description: _productDescriptionController!.text.trim(),
            regularPrice: _regularPriceController!.text.trim(),
            discountedPrice: _discountedPriceController!.text.trim(),
            category: _selectedCategory,
            unit: _selectedUnit,
            status: _currentProductStatusValue,
            createdDate: _createdDate,
          );
          emptyAllField();
          GlobalMethods().showSnackbar(
            context: context,
            message: "The product uploaded successfully.",
          );
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
      } else {
        if (_imagePath == "") {
          setState(() {
            _isProductImageSelected = false;
          });
        }
        if (_currentProductStatusValue == null) {
          setState(() {
            _isStatusSelected = false;
          });
        }
        if (_selectedUnit == null) {
          setState(() {
            _isUnitSelected = false;
          });
        }
        if (_selectedCategory == null) {
          setState(() {
            _isCategorySelected = false;
          });
        }
      }
    } else {
      Navigator.popUntil(context, (route) => route.isFirst);
      GlobalMethods().showErrorMessage(
        context: context,
        title: "Unapproved Seller",
        description:
            "Sorry! you are unable to upload your products, the account will be approved within 48 hours. Thank You.",
        buttonText: "OK",
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  void updateProduct(BuildContext context) async {
    if (Users.getStatus != 0) {
      final FormState? _key = _formKey.currentState!;
      bool isValidated = FieldValidations.validationOnButton(formKey: _key);
      String? _updatedDate = getCurrentDate();
      if (isValidated == true &&
          ((_networkImageURL != null && _imagePath == "") ||
              (_networkImageURL == null && _imagePath != "")) &&
          _currentProductStatusValue != null &&
          _selectedUnit != null &&
          _selectedCategory != null) {
        GlobalMethods().showIconLoading(context: context);
        try {
          final productProvider =
              Provider.of<ProductsProvider>(context, listen: false);
          String? _getProductImageUrl = "";
          if (_networkImageURL == null && _imagePath != "") {
            await productProvider.deleteProductImageFromStorage(
                imageURL: _removedNetworkImageURL);
            _getProductImageUrl = await productProvider
                .uploadProductImageToStorage(imagePath: _imagePath);
          } else if (_networkImageURL != null && _imagePath == "") {
            _getProductImageUrl = _networkImageURL!;
          }
          await productProvider.updateProduct(
            productID: widget._productData!.productId,
            productName: _productNameController!.text.trim(),
            imageURL: _getProductImageUrl,
            description: _productDescriptionController!.text.trim(),
            regularPrice: _regularPriceController!.text.trim(),
            discountedPrice: _discountedPriceController!.text.trim(),
            category: _selectedCategory,
            unit: _selectedUnit,
            status: _currentProductStatusValue,
            updatedDate: _updatedDate,
          );
          emptyAllField();
          GlobalMethods().showSnackbar(
            context: context,
            message: "The product updated successfully.",
          );
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } on FirebaseException catch (e) {
          Navigator.pop(context);
          GlobalMethods().showErrorMessage(
            context: context,
            title: e.code,
            description: e.message,
            buttonText: "OK",
            onPressed: () {
              Navigator.pop(context);
            },
          );
        } catch (e) {
          Navigator.pop(context);
          GlobalMethods().showErrorMessage(
            context: context,
            title: "Unexpected Error",
            description: e.toString(),
            buttonText: "OK",
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }
      } else {
        if (_isProductImageSelected == false) {
          setState(() {
            _isProductImageSelected = false;
          });
        }
        if (_currentProductStatusValue == null) {
          setState(() {
            _isStatusSelected = false;
          });
        }
        if (_selectedUnit == null) {
          setState(() {
            _isUnitSelected = false;
          });
        }
        if (_selectedCategory == null) {
          setState(() {
            _isCategorySelected = false;
          });
        }
      }
    } else {
      Navigator.popUntil(context, (route) => route.isFirst);
      GlobalMethods().showErrorMessage(
        context: context,
        title: "Unapproved Seller",
        description:
            "Sorry! you are unable to upload your products, the account will be approved within 48 hours. Thank You.",
        buttonText: "OK",
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color dimmTextColor =
        Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5);
    Color primaryColorOfTheme = Theme.of(context).primaryColor;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AddUpdateProductImage(
            onTapAddImageFile: pickImage,
            onTapDeleteImageFile: deleteImageFile,
            onTapDeleteNetworkImage: removeNetworkImage,
            selectedImageFile: _selectedImageFile,
            networkImageURL: _networkImageURL ?? "",
            isProductImageSelected: _isProductImageSelected,
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          TextFormField(
            controller: _productNameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.sentences,
            cursorColor: context.isLightMode
                ? Theme.of(context).primaryColor
                : kLightCanvasColor,
            validator: (value) {
              return FieldValidations.isName(value: value);
            },
            style: TextStyle(fontSize: getProportionateScreenWidth(15)),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(13),
                  horizontal: getProportionateScreenHeight(13)),
              hintText: "Product name",
              hintStyle: TextStyle(
                color: dimmTextColor,
                fontSize: getProportionateScreenWidth(15),
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              enabledBorder: coloredOutlineInputBorder(context),
              border: coloredOutlineInputBorder(context),
              focusedBorder: coloredOutlineInputBorder(context),
              errorBorder: coloredErrorOutlineInputBorder(),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(160),
                child: TextFormField(
                  controller: _regularPriceController,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: context.isLightMode
                      ? Theme.of(context).primaryColor
                      : kLightCanvasColor,
                  maxLength: 4,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'(^\d*$)')),
                  ],
                  validator: (value) {
                    return FieldValidations.isRegularPrice(value: value);
                  },
                  style: TextStyle(fontSize: getProportionateScreenWidth(15)),
                  decoration: InputDecoration(
                    hintText: "Regular price",
                    hintStyle: TextStyle(
                      color: dimmTextColor,
                      fontSize: getProportionateScreenWidth(15),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(13),
                        horizontal: getProportionateScreenHeight(13)),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    enabledBorder: coloredOutlineInputBorder(context),
                    border: coloredOutlineInputBorder(context),
                    focusedBorder: coloredOutlineInputBorder(context),
                    errorBorder: coloredErrorOutlineInputBorder(),
                    counterText: "",
                    suffixText: "Rs",
                    suffixStyle: TextStyle(
                      color: context.isLightMode
                          ? primaryColorOfTheme
                          : kLightCanvasColor,
                      fontSize: getProportionateScreenWidth(16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(160),
                child: TextFormField(
                  controller: _discountedPriceController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  cursorColor: context.isLightMode
                      ? Theme.of(context).primaryColor
                      : kLightCanvasColor,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'(^\d*$)')),
                  ],
                  maxLength: 4,
                  validator: (value) {
                    return FieldValidations.isDiscountedPrice(
                      value: value,
                      regularPrice: _regularPriceController!.text.isNotEmpty
                          ? _regularPriceController!.text
                          : "0",
                    );
                  },
                  style: TextStyle(fontSize: getProportionateScreenWidth(15)),
                  decoration: InputDecoration(
                    hintText: "Discounted price",
                    hintStyle: TextStyle(
                      color: dimmTextColor,
                      fontSize: getProportionateScreenWidth(15),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(13),
                        horizontal: getProportionateScreenHeight(13)),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    enabledBorder: coloredOutlineInputBorder(context),
                    border: coloredOutlineInputBorder(context),
                    focusedBorder: coloredOutlineInputBorder(context),
                    errorBorder: coloredErrorOutlineInputBorder(),
                    counterText: "",
                    suffixText: "Rs",
                    suffixStyle: TextStyle(
                      color: context.isLightMode
                          ? primaryColorOfTheme
                          : kLightCanvasColor,
                      fontSize: getProportionateScreenWidth(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(160),
                child: CustomUnitsCategoryDropdown(
                  isCategory: true,
                  isSelected: _isCategorySelected,
                  onchanged: (newSelectedCategory) {
                    setState(() {
                      _selectedCategory = newSelectedCategory;
                      _isCategorySelected = true;
                    });
                  },
                  value: _selectedCategory,
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(160),
                child: CustomUnitsCategoryDropdown(
                  isCategory: false,
                  isSelected: _isUnitSelected,
                  onchanged: (newSelectedUnit) {
                    setState(() {
                      _selectedUnit = newSelectedUnit;
                      _isUnitSelected = true;
                    });
                  },
                  value: _selectedUnit,
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _productDescriptionController,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
            cursorColor:
                context.isLightMode ? primaryColorOfTheme : kLightCanvasColor,
            maxLines: 3,
            minLines: 3,
            validator: (value) {
              return FieldValidations.isDescription(value: value);
            },
            style: TextStyle(fontSize: getProportionateScreenWidth(15)),
            decoration: InputDecoration(
              hintText: "Product description",
              hintStyle: TextStyle(
                color: dimmTextColor,
                fontSize: getProportionateScreenWidth(15),
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              enabledBorder: coloredOutlineInputBorder(context),
              border: coloredOutlineInputBorder(context),
              focusedBorder: coloredOutlineInputBorder(context),
              errorBorder: coloredErrorOutlineInputBorder(),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          StatusDropdownButtonField(
            currentValue: _currentProductStatusValue,
            isSelected: _isStatusSelected,
            onChanged: (selectedProductStatusValue) {
              setState(() {
                _currentProductStatusValue = selectedProductStatusValue;
                _isStatusSelected = true;
              });
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          CustomLargeButton(
            text: widget._isAddProduct! ? "Add Product" : "Update Product",
            buttonColor: primaryColorOfTheme,
            isDisable: false,
            onPressed: widget._isAddProduct!
                ? () {
                    uploadProduct(context);
                  }
                : () {
                    updateProduct(context);
                  },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
        ],
      ),
    );
  }
}
