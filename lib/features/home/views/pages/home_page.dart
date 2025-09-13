import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';
import 'package:news_app/core/views/widgets/app_drawer.dart';
import 'package:news_app/features/home/home_cubit/home_cubit.dart';
import 'package:news_app/features/home/views/widgets/custom_carousel_slider.dart';
import 'package:news_app/features/home/views/widgets/recommended_news_widget.dart';
import 'package:news_app/features/home/views/widgets/title_headline_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
  final orientation = MediaQuery.of(context).orientation;
    return BlocProvider(
      create: (context) {
        final cubit = HomeCubit();
        cubit.getTopHeadlines();
        cubit.getRecommendationNews();
        return cubit;
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const AppDrawer(),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            // splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: DecoratedBox(
              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.grey),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(CupertinoIcons.line_horizontal_3),
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.searchRoute);
              },
              highlightColor: Colors.transparent,
              icon: DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.grey),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(CupertinoIcons.search),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              highlightColor: Colors.transparent,
              icon: DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.grey),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(CupertinoIcons.bell),
                ),
              ),
            ),
          ],
        ),
        body: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () async {
                await BlocProvider.of<HomeCubit>(context).getTopHeadlines();
                await BlocProvider.of<HomeCubit>(context).getRecommendationNews();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TitleHeadlineWidget(title: "Breaking News", onTap: () {}),
                      BlocBuilder<HomeCubit, HomeState>(
                        buildWhen: (previous, current) =>
                            current is TopHeadLinesLoading ||
                            current is TopHeadLinesLoaded ||
                            current is TopHeadLinesError,
                        builder: (context, state) {
                          if (state is TopHeadLinesLoaded) {
                            return CustomCarouselSlider(articles: state.articles ?? []);
                          } else if (state is TopHeadLinesError) {
                            return Center(child: Text(state.message));
                          } else if (state is TopHeadLinesLoading) {
                            return const CircularProgressIndicator.adaptive();
                          } else {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                              ),
                            );
                          }
                        },
                      ),
                    TitleHeadlineWidget(title: "Recommendation", onTap: () {}),
                    BlocBuilder<HomeCubit, HomeState>(
                      buildWhen: (previous, current) =>
                          current is RecommendedNewsError ||
                          current is RecommendedNewsLoaded ||
                          current is RecommendedNewsLoading,
                      builder: (context, state) {
                        if (state is RecommendedNewsLoaded) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: RecommendedNewsWidget(articles: state.articles ?? []),
                          );
                        } else if (state is RecommendedNewsError) {
                          return Center(child: Text(state.message));
                        } else if (state is RecommendedNewsLoading) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(
                              valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(
                              valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
