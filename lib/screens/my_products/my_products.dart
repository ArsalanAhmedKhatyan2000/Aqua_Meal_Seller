import 'package:aqua_meals_seller/models/products.dart';
import 'package:aqua_meals_seller/providers/products_provider.dart';
import 'package:aqua_meals_seller/screens/my_products/components/my_product_tile.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/widgets/build_empty_screen.dart';
import 'package:aqua_meals_seller/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class MyProducts extends StatelessWidget {
  static const String routeName = "/MyProducts";
  const MyProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    productProvider.getProductsList.sort(
      (a, b) => a.createdDate!.compareTo(b.createdDate!),
    );
    List<ProductModel> productsList = productProvider.getProductsList;

    return SafeArea(
      top: true,
      bottom: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        extendBody: true,
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: Text(
            "My Products",
            style: TextStyle(fontSize: getProportionateScreenWidth(20)),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(15),
            right: getProportionateScreenWidth(15),
          ),
          child: productsList.isNotEmpty
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: productsList.length,
                  padding: EdgeInsets.only(
                    top: getProportionateScreenHeight(10),
                    bottom: getProportionateScreenHeight(60),
                  ),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: getProportionateScreenHeight(10)),
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: productsList[index],
                      child: const MyProductsTile(),
                    );
                  },
                )
              : const EmptyScreen(
                  icon: MdiIcons.cubeOutline,
                  title: "Oops! Products are empty!",
                  description: "Looks like you have not uploaded any product.",
                ),
        ),
      ),
    );
  }
}
