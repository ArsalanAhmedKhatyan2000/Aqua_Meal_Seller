// import 'package:aqua_meals_seller/crud/crud.dart';
// import 'package:aqua_meals_seller/screens/my_products/components/my_product_tile.dart';
// import 'package:aqua_meals_seller/helper/size_configuration.dart';
// import 'package:aqua_meals_seller/widgets/build_custom_circular_image_loading.dart';
// import 'package:aqua_meals_seller/widgets/build_empty_screen.dart';
// import 'package:aqua_meals_seller/widgets/my_drawer.dart';
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// class MyProducts extends StatelessWidget {
//   static const String routeName = "/MyProducts";
//   const MyProducts({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     CRUD _crudOperations = CRUD();
//     return SafeArea(
//       top: true,
//       bottom: false,
//       child: Scaffold(
//         backgroundColor: Theme.of(context).canvasColor,
//         extendBody: true,
//         drawer: const MyDrawer(),
//         appBar: AppBar(
//           title: const Text("My Products"),
//           centerTitle: true,
//         ),
//         body: Padding(
//           padding: EdgeInsets.only(
//             left: getProportionateScreenWidth(15),
//             right: getProportionateScreenWidth(15),
//             bottom: getProportionateScreenHeight(15),
//           ),
//           child: FutureBuilder(
//             future: _crudOperations.fetchProducts(),
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasError) {
//                 return const Center(child: Text("Error"));
//               }
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.data!.length > 0) {
//                   return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       return MyProductsTile(
//                         productData: snapshot.data[index],
//                       );
//                     },
//                   );
//                 } else {
//                   return const EmptyScreen(
//                     icon: MdiIcons.cubeOutline,
//                     title: "Oops! Products are empty!",
//                     description:
//                         "Looks like you have not uploaded any product.",
//                   );
//                 }
//               }
//               return const Center(child: LoadingIcon());
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
