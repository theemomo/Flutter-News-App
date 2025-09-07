import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/features/home/views/pages/home_page.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return CupertinoPageRoute(builder: (context) => const HomePage());
      default:
        return CupertinoPageRoute(builder: (context) => const Scaffold(body: Center(child: Text("Page not found"))));
    }
  }
}
