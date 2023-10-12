import 'package:aqua_meals_seller/crud/crud.dart';
import 'package:aqua_meals_seller/helper/bottom_navigation_key.dart';
import 'package:aqua_meals_seller/helper/general_methods.dart';
import 'package:aqua_meals_seller/helper/size_configuration.dart';
import 'package:aqua_meals_seller/helper/tab_bar.dart';
import 'package:aqua_meals_seller/models/users.dart';
import 'package:aqua_meals_seller/screens/about_us/about_us.dart';
import 'package:aqua_meals_seller/screens/login/login.dart';
import 'package:aqua_meals_seller/screens/support/support.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              currentAccountPicture: Users.getProfileImageURL!.isEmpty
                  ? Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.person_outline_outlined,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        size: getProportionateScreenWidth(30),
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          CachedNetworkImageProvider(Users.getProfileImageURL!),
                    ),
              margin: EdgeInsets.zero,
              accountName: Text(
                  Users.getName!.isEmpty ? "" : Users.getName!.capitalize()),
              accountEmail: Text(
                  Users.getEmail!.isEmpty ? "" : Users.getEmail!.capitalize()),
            ),
          ),
          ListTile(
            title: const Text("Home"),
            leading: const Icon(Icons.home_outlined),
            onTap: () {
              BottomNavigationBarKey.getBottomNavigationBarKey()
                  .currentState!
                  .setPage(2);
            },
          ),
          ListTile(
            title: const Text("My Profile"),
            leading: const Icon(Icons.person_outline),
            onTap: () {
              BottomNavigationBarKey.getBottomNavigationBarKey()
                  .currentState!
                  .setPage(4);
            },
          ),
          ListTile(
            title: const Text("My Products"),
            leading: const Icon(MdiIcons.cubeOutline),
            onTap: () {
              BottomNavigationBarKey.getBottomNavigationBarKey()
                  .currentState!
                  .setPage(0);
            },
          ),
          ListTile(
            title: const Text("My Orders"),
            leading: const Icon(MdiIcons.clipboardTextOutline),
            onTap: () {
              TabBarPageIndex.setTabBarIndex(newTabBarIndex: 0);
              BottomNavigationBarKey.getBottomNavigationBarKey()
                  .currentState!
                  .setPage(1);
            },
          ),
          // ListTile(
          //   title: const Text("My Balance"),
          //   leading: const Icon(MdiIcons.cash),
          //   onTap: () {},
          // ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text("Support"),
            onTap: () {
              Navigator.pushNamed(context, Support.routeName);
            },
          ),
          ListTile(
            title: const Text("About Us"),
            leading: const Icon(Icons.info_outlined),
            onTap: () {
              Navigator.pushNamed(context, AboutUs.routeName);
            },
          ),
          ListTile(
            title: const Text("Signout"),
            leading: const Icon(Icons.logout),
            onTap: () {
              GlobalMethods().showAlertMessage(
                context: context,
                title: "Sign out",
                description: "Are you sure! you want to sign out?",
                leftButtonText: "CANCEL",
                rightButtonText: "YES",
                onPressedLeftButton: () {
                  Navigator.pop(context);
                },
                onPressedRightButton: () async {
                  Navigator.pop(context);
                  await CRUD().signout();
                  Users.setAllFieldsNull();
                  Navigator.pushReplacementNamed(context, Login.routeName);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
