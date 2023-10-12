import 'package:aqua_meals_seller/models/products.dart';
import 'package:aqua_meals_seller/screens/add_Products/components/add_product_form.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:flutter/material.dart';

class UpdateProduct extends StatefulWidget {
  static const String routeName = "/UpdateProduct";
  final ProductModel _productData;
  const UpdateProduct({Key? key, productData})
      : _productData = productData,
        super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      bottom: false,
      top: true,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text(
            "Update Product",
            style: TextStyle(fontSize: getProportionateScreenWidth(20)),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: Column(
                children: [
                  AddProductForm(
                      isAddProduct: false, productData: widget._productData),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
