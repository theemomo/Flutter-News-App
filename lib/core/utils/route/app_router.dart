import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/features/bookmark/bookmark_cubit/bookmark_cubit.dart';
import 'package:news_app/features/bookmark/views/pages/bookmark_page.dart';
import 'package:news_app/features/home/article_cubit/article_cubit.dart';
import 'package:news_app/features/home/views/pages/article_details_page.dart';
import 'package:news_app/features/home/views/pages/home_page.dart';
import 'package:news_app/features/search/search_cubit/search_cubit.dart';
import 'package:news_app/features/search/views/pages/search_page.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return CupertinoPageRoute(builder: (context) => const HomePage());
      case AppRoutes.articleRoute:
        final article = settings.arguments as Article;
        return CupertinoPageRoute(
          settings: settings,
          builder: (context) => BlocProvider(
            create: (context) => ArticleCubit(),
            child: ArticleDetailsPage(article: article),
          ),
        );
      case AppRoutes.searchRoute:
        return CupertinoPageRoute(
          builder: (context) =>
              BlocProvider(create: (context) => SearchCubit(), child: const SearchPage()),
        );
      case AppRoutes.bookmarkRoute:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) {
              final cubit = BookmarkCubit();
              cubit.getBookmarked();
              return cubit;
            },
            child: const BookmarkPage(),
          ),
        );
      default:
        return CupertinoPageRoute(
          builder: (context) => const Scaffold(body: Center(child: Text("Page not found"))),
        );
    }
  }
}
