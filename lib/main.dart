import 'package:aqua_meals_seller/constraints.dart';
import 'package:aqua_meals_seller/models/about.dart';
import 'package:aqua_meals_seller/my_routes.dart';
import 'package:aqua_meals_seller/my_themes.dart';
import 'package:aqua_meals_seller/providers/buyer.dart';
import 'package:aqua_meals_seller/providers/category_provider.dart';
import 'package:aqua_meals_seller/providers/order_details_provider.dart';
import 'package:aqua_meals_seller/providers/orders_provider.dart';
import 'package:aqua_meals_seller/providers/products_provider.dart';
import 'package:aqua_meals_seller/providers/terms_and_condition_provider.dart';
import 'package:aqua_meals_seller/providers/units_provider.dart';
import 'package:aqua_meals_seller/screens/splash_screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    loadPreCacheImages(context); //load pre cache images.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => UnitsProvider()),
              ChangeNotifierProvider(create: (_) => CategoryProvider()),
              ChangeNotifierProvider(create: (_) => AboutProvider()),
              ChangeNotifierProvider(create: (_) => ProductsProvider()),
              ChangeNotifierProvider(create: (_) => BuyerProvider()),
              ChangeNotifierProvider(create: (_) => OrdersProvider()),
              ChangeNotifierProvider(create: (_) => OrderDetailsProvider()),
              ChangeNotifierProvider(
                  create: (_) => TermsAndConditionProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Aqua Meals Seller',
              themeMode: ThemeMode.system,
              theme: MyThemes.lightTheme(context),
              darkTheme: MyThemes.darkTheme(context),
              initialRoute: Splash.routeName,
              routes: myRoutes,
            ),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

loadPreCacheImages(BuildContext context) {
  Future.wait([
    precacheImage(
        Image.asset(lightThemeLogo!).image, context), //png image pre cache
    precacheImage(
        Image.asset(darkThemeLogo!).image, context), //png image pre cache
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, loadingFishImage!),
      null,
    ),
  ]);
}
