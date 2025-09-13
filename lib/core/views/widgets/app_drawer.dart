import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Drawer(
      width: MediaQuery.of(context).size.shortestSide > 600
          ? orientation == Orientation.portrait
                ? MediaQuery.of(context).size.width * 0.6
                : MediaQuery.of(context).size.width * 0.3
          : orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width * 0.7
          : MediaQuery.of(context).size.width * 0.4,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
              padding: const EdgeInsetsGeometry.all(0),
              child: Container(
                decoration: const BoxDecoration(color: AppColors.primaryColor),
                child: Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: CachedNetworkImage(
                      imageUrl: "https://cdn-icons-png.flaticon.com/512/7989/7989484.png",
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.house_fill),
            title: Text(
              "Home",
              style: MediaQuery.of(context).size.shortestSide > 600
                  ? Theme.of(context).textTheme.headlineSmall
                  : Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(CupertinoIcons.bookmark_fill),
            title: Text(
              "Bookmarks",
              style: MediaQuery.of(context).size.shortestSide > 600
                  ? Theme.of(context).textTheme.headlineSmall
                  : Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.bookmarkRoute);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              "Profile",
              style: MediaQuery.of(context).size.shortestSide > 600
                  ? Theme.of(context).textTheme.headlineSmall
                  : Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
