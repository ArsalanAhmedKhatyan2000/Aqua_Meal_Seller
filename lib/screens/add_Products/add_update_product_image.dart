import 'dart:io';
import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/screens/add_Products/components/build_delete_product_image.dart';
import 'package:flutter/material.dart';

class AddUpdateProductImage extends StatelessWidget {
  final void Function()? _onTapAddImageFile,
      _onTapDeleteImageFile,
      _onTapDeleteNetworkImage;
  final String? _networkImageURL;
  final File? _selectedImageFile;
  final bool? _isProductImageSelected;
  const AddUpdateProductImage({
    Key? key,
    void Function()? onTapAddImageFile,
    void Function()? onTapDeleteImageFile,
    void Function()? onTapDeleteNetworkImage,
    String? networkImageURL,
    File? selectedImageFile,
    bool? isProductImageSelected = true,
  })  : _onTapAddImageFile = onTapAddImageFile,
        _onTapDeleteImageFile = onTapDeleteImageFile,
        _onTapDeleteNetworkImage = onTapDeleteNetworkImage,
        _selectedImageFile = selectedImageFile,
        _networkImageURL = networkImageURL,
        _isProductImageSelected = isProductImageSelected,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return (_selectedImageFile != null)
        ? Stack(
            children: [
              Container(
                height: getProportionateScreenHeight(170),
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: context.isLightMode
                          ? Theme.of(context).primaryColor
                          : kLightCanvasColor),
                  borderRadius: BorderRadius.all(
                      Radius.circular(getProportionateScreenHeight(30))),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(getProportionateScreenHeight(30))),
                  child: Image.file(
                    _selectedImageFile!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              BuildDeleteProductImage(onTapDeleteButton: _onTapDeleteImageFile),
            ],
          )
        : (_networkImageURL!.isNotEmpty)
            ? Stack(
                children: [
                  Container(
                    height: getProportionateScreenHeight(170),
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: context.isLightMode
                              ? Theme.of(context).primaryColor
                              : kLightCanvasColor),
                      borderRadius: BorderRadius.all(
                          Radius.circular(getProportionateScreenHeight(30))),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                          Radius.circular(getProportionateScreenHeight(30))),
                      child: Image.network(
                        _networkImageURL!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  BuildDeleteProductImage(
                      onTapDeleteButton: _onTapDeleteNetworkImage),
                ],
              )
            : GestureDetector(
                onTap: _onTapAddImageFile,
                child: Container(
                  height: getProportionateScreenHeight(170),
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border.all(
                      color: (_isProductImageSelected! &&
                              context.isLightMode == true)
                          ? Theme.of(context).primaryColor
                          : ((_isProductImageSelected! &&
                                  context.isLightMode == false))
                              ? kLightCanvasColor
                              : Colors.red,
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(getProportionateScreenHeight(30))),
                  ),
                  child: Icon(
                    Icons.add_a_photo,
                    color: context.isLightMode
                        ? Theme.of(context).primaryColor
                        : kLightCanvasColor,
                  ),
                ),
              );
  }
}
