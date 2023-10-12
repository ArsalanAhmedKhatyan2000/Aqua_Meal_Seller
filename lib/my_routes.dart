import 'package:aqua_meals_seller/screens/about_us/about_us.dart';
import 'package:aqua_meals_seller/screens/add_Products/add_products.dart';
import 'package:aqua_meals_seller/screens/login/login.dart';
import 'package:aqua_meals_seller/screens/home/build_curved_bottom_navigation_bar.dart';
import 'package:aqua_meals_seller/screens/home/home.dart';
import 'package:aqua_meals_seller/screens/login/reset_password_screen.dart';
import 'package:aqua_meals_seller/screens/my_orders/confirmed_orders.dart';
import 'package:aqua_meals_seller/screens/my_orders/order_tabbar.dart';
import 'package:aqua_meals_seller/screens/my_orders/pending_orders.dart';
import 'package:aqua_meals_seller/screens/my_products/my_products.dart';
import 'package:aqua_meals_seller/screens/my_profile/my_profile.dart';
import 'package:aqua_meals_seller/screens/orders_details/order_details.dart';
import 'package:aqua_meals_seller/screens/product_details/product_details.dart';
import 'package:aqua_meals_seller/screens/signup/signup.dart';
import 'package:aqua_meals_seller/screens/signup/terms_condition.dart';
import 'package:aqua_meals_seller/screens/splash_screen/splash.dart';
import 'package:aqua_meals_seller/screens/support/support.dart';

var myRoutes = {
  Splash.routeName: (context) => const Splash(),
  Login.routeName: (context) => const Login(),
  Signup.routeName: (context) => const Signup(),
  ResetPassword.routeName: (context) => const ResetPassword(),
  TermsAndCondition.routeName: (context) => const TermsAndCondition(),
  Home.routeName: (context) => const Home(),
  AddProduct.routeName: (context) => const AddProduct(),
  OrdersTabBar.routeName: (context) => const OrdersTabBar(),
  PendingOrders.routeName: (context) => const PendingOrders(),
  ConfirmedOrders.routeName: (context) => const ConfirmedOrders(),
  OrdersDetails.routeName: (context) => const OrdersDetails(),
  MyProducts.routeName: (context) => const MyProducts(),
  ProductDetails.routeName: (context) => const ProductDetails(),
  MyProfile.routeName: (context) => const MyProfile(),
  AboutUs.routeName: (context) => const AboutUs(),
  Support.routeName: (context) => const Support(),
  BuildCurvedBottomNavigationBar.routeName: (context) =>
      const BuildCurvedBottomNavigationBar(),
};
