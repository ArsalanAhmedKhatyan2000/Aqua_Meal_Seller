import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BuildStarRating extends StatelessWidget {
  final double? _ratingValue;

  const BuildStarRating({
    Key? key,
    required double? ratingValue,
  })  : _ratingValue = ratingValue,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RatingBar.builder(
          initialRating: _ratingValue!,
          minRating: 0,
          maxRating: 5,
          itemBuilder: ((context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              )),
          ignoreGestures: true,
          onRatingUpdate: (newRatingValue) {},
          updateOnDrag: false,
          allowHalfRating: true,
          glow: false,
          itemCount: 5,
          itemSize: getProportionateScreenWidth(20),
          textDirection: TextDirection.ltr,
        ),
        SizedBox(width: getProportionateScreenWidth(5)),
        Container(
          height: getProportionateScreenHeight(20),
          width: getProportionateScreenWidth(55),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Theme.of(context).disabledColor,
              borderRadius: BorderRadius.all(
                  Radius.circular(getProportionateScreenWidth(10)))),
          child: Text(
            "$_ratingValue/5",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: getProportionateScreenWidth(12),
            ),
          ),
        ),
      ],
    );
  }
}
