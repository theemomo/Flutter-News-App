import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
              padding: const EdgeInsetsGeometry.all(0),
              child: DecoratedBox(
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
            leading: const Icon(Icons.home),
            title: Text("Home", style: Theme.of(context).textTheme.titleMedium),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(CupertinoIcons.bookmark_fill),
            title: Text("Bookmarks", style: Theme.of(context).textTheme.titleMedium),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.bookmarkRoute);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text("Profile", style: Theme.of(context).textTheme.titleMedium),
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
