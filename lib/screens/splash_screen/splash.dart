import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/crud/crud.dart';
import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/helper/preferences.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/models/about.dart';
import 'package:aqua_meals_seller/providers/buyer.dart';
import 'package:aqua_meals_seller/providers/category_provider.dart';
import 'package:aqua_meals_seller/providers/order_details_provider.dart';
import 'package:aqua_meals_seller/providers/orders_provider.dart';
import 'package:aqua_meals_seller/providers/products_provider.dart';
import 'package:aqua_meals_seller/providers/terms_and_condition_provider.dart';
import 'package:aqua_meals_seller/providers/units_provider.dart';
import 'package:aqua_meals_seller/screens/home/build_curved_bottom_navigation_bar.dart';
import 'package:aqua_meals_seller/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  static const String routeName = "/splashRoute";
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    _nextScreenNavigator();
    super.initState();
  }

  _nextScreenNavigator() async {
    await Future.delayed(const Duration(milliseconds: 1), () async {
      final String? token = await SharedPreferencesHelper().getAuthToken();
      final categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      final unitsProvider = Provider.of<UnitsProvider>(context, listen: false);
      final termsAndConditionProvider =
          Provider.of<TermsAndConditionProvider>(context, listen: false);
      final aboutProvider = Provider.of<AboutProvider>(context, listen: false);
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);

      final buyerProvider = Provider.of<BuyerProvider>(context, listen: false);
      final ordersProvider =
          Provider.of<OrdersProvider>(context, listen: false);
      final orderDetailsProvider =
          Provider.of<OrderDetailsProvider>(context, listen: false);
      await categoryProvider.fetchCategories();
      await unitsProvider.fetchUnits();
      await aboutProvider.fetchAboutData();
      await termsAndConditionProvider.fetchTermsAndCondition();
      if (token != null && token.isNotEmpty) {
        CRUD().fetchUserCredentials(userID: token);
        await productsProvider.fetchProducts();
        await ordersProvider.fetchOrders();
        await orderDetailsProvider.fetchOrdersDetails();
        buyerProvider.fetchBuyers();
        Navigator.pushReplacementNamed(
            context, BuildCurvedBottomNavigationBar.routeName);
      } else {
        Navigator.pushReplacementNamed(context, Login.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.isLightMode
          ? Theme.of(context).canvasColor
          : kDarkPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              context.isLightMode ? lightThemeLogo! : darkThemeLogo!,
              fit: BoxFit.cover,
              width: getProportionateScreenWidth(300),
            ),
          ),
        ],
      ),
    );
  }
}
