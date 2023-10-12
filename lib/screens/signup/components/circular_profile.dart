import 'dart:io';

import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class CircularProfile extends StatelessWidget {
  final void Function()? _onTap;
  final String? _imagePath;

  const CircularProfile({
    Key? key,
    void Function()? onTap,
    String? imagePath,
  })  : _onTap = onTap,
        _imagePath = imagePath,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    File _selectedImageFile = File(_imagePath!);
    return InkWell(
      onTap: _onTap,
      borderRadius: BorderRadius.circular(100),
      child: (_imagePath != "")
          ? Container(
              width: getProportionateScreenWidth(100),
              height: getProportionateScreenHeight(100),
              decoration: BoxDecoration(
                color: kLightCanvasColor,
                shape: BoxShape.circle,
                border: Border.all(color: kLightCanvasColor, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.file(
                  _selectedImageFile,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Container(
              width: getProportionateScreenWidth(100),
              height: getProportionateScreenHeight(100),
              decoration: BoxDecoration(
                color: kLightCanvasColor.withOpacity(0.3),
                border: Border.all(color: kLightCanvasColor),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add_a_photo, color: kLightCanvasColor),
            ),
    );
  }
}
