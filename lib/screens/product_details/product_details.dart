import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/models/products.dart';
import 'package:aqua_meals_seller/providers/products_provider.dart';
import 'package:aqua_meals_seller/screens/my_profile/my_profile.dart';
import 'package:aqua_meals_seller/screens/product_details/update_product.dart';
import 'package:aqua_meals_seller/widgets/build_custom_back_button.dart';
import 'package:aqua_meals_seller/widgets/build_price_lebel_with_unit.dart';
import 'package:aqua_meals_seller/screens/product_details/build_product_image.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/widgets/build_custom_button.dart';
import 'package:aqua_meals_seller/widgets/build_star_rating.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  static const String routeName = "/ProductDetails";

  const ProductDetails({
    Key? key,
  }) : super(key: key);

  Future<void> deleteProduct(
      {required BuildContext context,
      required String? imageURL,
      required String? productID}) async {
    await GlobalMethods().showAlertMessage(
      context: context,
      title: "Delete Product",
      description: "Are you sure! you want to delete the product?",
      leftButtonText: "CANCEL",
      rightButtonText: "YES",
      onPressedLeftButton: () {
        Navigator.of(context).pop();
      },
      onPressedRightButton: () async {
        Navigator.pop(context);
        GlobalMethods().showIconLoading(context: context);
        try {
          final productProvider =
              Provider.of<ProductsProvider>(context, listen: false);
          await productProvider.removeProduct(
            imageURL: imageURL,
            productID: productID,
          );
          Navigator.of(context).popUntil((route) => route.isFirst);
        } on FirebaseException catch (e) {
          Navigator.pop(context);
          GlobalMethods().showErrorMessage(
            context: context,
            title: e.code,
            description: e.message,
            buttonText: "OK",
            onPressed: () {
              Navigator.of(context).pop();
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
      },
    );
  }

  updateProduct(BuildContext context, ProductModel product) async {
    GlobalMethods().showAlertMessage(
      context: context,
      title: "Update Product",
      description: "Are you sure! you want to update the product?",
      leftButtonText: "CANCEL",
      rightButtonText: "YES",
      onPressedLeftButton: () {
        Navigator.pop(context);
      },
      onPressedRightButton: () {
        Navigator.pop(context);
        navigatePush(
            context: context,
            widget: UpdateProduct(
              productData: product,
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    Color textColor = Theme.of(context).textTheme.bodyText1!.color!;
    Color dimmTextColor =
        Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5);
    final productProvider = Provider.of<ProductsProvider>(context);
    final currentProduct = productProvider.findProdById(productId);

    SizeConfig().init(context);
    return SafeArea(
      top: true,
      bottom: false,
      child: Scaffold(
        extendBody: true,
        bottomSheet: Container(
          color: Theme.of(context).canvasColor,
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenWidth(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BuildSmallButton(
                text: "DELETE",
                backgroundcolor: Colors.red.withOpacity(0.7),
                width: SizeConfig.screenWidth * 0.4,
                height: getProportionateScreenHeight(50),
                onPressed: () async {
                  await GlobalMethods().showAlertMessage(
                    context: context,
                    title: "Delete Product",
                    description:
                        "Are you sure! you want to delete the product?",
                    leftButtonText: "CANCEL",
                    rightButtonText: "YES",
                    onPressedLeftButton: () {
                      Navigator.of(context).pop();
                    },
                    onPressedRightButton: () async {
                      Navigator.pop(context);
                      GlobalMethods().showIconLoading(context: context);
                      try {
                        productProvider.removeProduct(
                          imageURL: currentProduct.imageUrl,
                          productID: productId,
                        );
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      } on FirebaseException catch (e) {
                        Navigator.pop(context);
                        GlobalMethods().showErrorMessage(
                          context: context,
                          title: e.code,
                          description: e.message,
                          buttonText: "OK",
                          onPressed: () {
                            Navigator.of(context).pop();
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
                    },
                  );
                },
              ),
              BuildSmallButton(
                text: "EDIT",
                backgroundcolor: Colors.green.withOpacity(0.7),
                width: SizeConfig.screenWidth * 0.4,
                height: getProportionateScreenHeight(50),
                onPressed: () {
                  GlobalMethods().showAlertMessage(
                    context: context,
                    title: "Update Product",
                    description:
                        "Are you sure! you want to update the product?",
                    leftButtonText: "CANCEL",
                    rightButtonText: "YES",
                    onPressedLeftButton: () {
                      Navigator.pop(context);
                    },
                    onPressedRightButton: () {
                      Navigator.pop(context);
                      navigatePush(
                          context: context,
                          widget: UpdateProduct(
                            productData: currentProduct,
                          ));
                    },
                  );
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  BuildProductImage(
                    productID: currentProduct.productId,
                    productImageUrl: currentProduct.imageUrl,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenHeight(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentProduct.name!.capitalize(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                            fontSize: getProportionateScreenWidth(20),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BuildStarRating(
                              ratingValue:
                                  ratingCalculator(currentProduct.rating!),
                            ),
                            BuildPriceLebelWithUnit(
                              regularPrice: currentProduct.regularPrice,
                              discountedPrice: currentProduct.discountedPrice,
                              unit: currentProduct.unit,
                              smallTextFontSize:
                                  getProportionateScreenWidth(12),
                              largeTextFontSize:
                                  getProportionateScreenWidth(17),
                            ),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Category: ${currentProduct.category!.capitalize()}",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionateScreenWidth(15),
                                color: textColor,
                              ),
                            ),
                            Text(
                              currentProduct.status == "0"
                                  ? "Out of Stock"
                                  : "In Stock",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                fontSize: getProportionateScreenWidth(15),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Text(
                          currentProduct.description!.capitalize(),
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            color: dimmTextColor,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              currentProduct.updatedDate != ""
                                  ? "Uploaded On: ${currentProduct.createdDate!}\nUpdated On: ${currentProduct.updatedDate!}"
                                  : "Uploaded On: ${currentProduct.createdDate!}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionateScreenWidth(15),
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(70)),
                ],
              ),
            ),
            BuildCustomBackButton(
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
