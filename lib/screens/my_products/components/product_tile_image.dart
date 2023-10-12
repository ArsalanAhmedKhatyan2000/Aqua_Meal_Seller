import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  final String? _tag;
  final String? _imageURL;
  const CardImage({Key? key, String? tag, required String? imageURL})
      : _tag = tag,
        _imageURL = imageURL,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _imageURL!.isNotEmpty
        ? Hero(
            tag: _tag!,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                  Radius.circular(getProportionateScreenWidth(10))),
              child: CachedNetworkImage(
                imageUrl: _imageURL!,
                key: UniqueKey(),
                width: getProportionateScreenHeight(90),
                height: getProportionateScreenHeight(90),
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container(
            width: getProportionateScreenHeight(90),
            height: getProportionateScreenHeight(90),
            decoration: BoxDecoration(
              color: context.isLightMode
                  ? Theme.of(context).primaryColor
                  : Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(0.5),
              borderRadius: BorderRadius.all(
                  Radius.circular(getProportionateScreenWidth(10))),
            ),
          );
  }
}
