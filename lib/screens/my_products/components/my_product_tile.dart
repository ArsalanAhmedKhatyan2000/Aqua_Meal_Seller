import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/models/products.dart';
import 'package:aqua_meals_seller/screens/my_products/components/product_tile_image.dart';
import 'package:aqua_meals_seller/screens/product_details/product_details.dart';
import 'package:aqua_meals_seller/widgets/build_price_lebel_with_unit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProductsTile extends StatelessWidget {
  const MyProductsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color dimmTextColor =
        Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5);
    final productModel = Provider.of<ProductModel>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetails.routeName,
            arguments: productModel.productId);
      },
      child: Padding(
        padding: EdgeInsets.only(top: getProportionateScreenHeight(0)),
        child: Container(
          width: SizeConfig.screenWidth,
          height: getProportionateScreenHeight(90),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(
                Radius.circular(getProportionateScreenWidth(10))),
          ),
          child: Row(
            children: [
              CardImage(
                tag: productModel.productId.toString(),
                imageURL: productModel.imageUrl!.toString(),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      right: getProportionateScreenWidth(8),
                      left: getProportionateScreenWidth(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: getProportionateScreenHeight(8)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: getProportionateScreenWidth(115),
                            child: Text(
                              productModel.name!.capitalize(),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color,
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionateScreenWidth(15),
                              ),
                            ),
                          ),
                          BuildPriceLebelWithUnit(
                            regularPrice: productModel.regularPrice,
                            discountedPrice: productModel.discountedPrice,
                            unit: productModel.unit,
                            largeTextFontSize: getProportionateScreenWidth(13),
                            smallTextFontSize: getProportionateScreenWidth(10),
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
                      Expanded(
                        child: Text(
                          productModel.description!.capitalize(),
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: dimmTextColor,
                          ),
                        ),
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
