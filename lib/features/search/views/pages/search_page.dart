import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';
import 'package:news_app/core/views/widgets/article_item_widget.dart';
import 'package:news_app/features/search/search_cubit/search_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        context.read<SearchCubit>().loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Discover",
              style: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "News for all around the world",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.gry),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(CupertinoIcons.search),
                suffixIcon: BlocBuilder<SearchCubit, SearchState>(
                  buildWhen: (previous, current) =>
                      current is SearchResultsLoading ||
                      current is SearchResultsLoaded ||
                      current is SearchResultsError,
                  builder: (context, state) {
                    if (state is SearchResultsError) {
                      return IconButton(
                        onPressed: null,
                        icon: Container(
                          height: MediaQuery.of(context).size.height * 0.035,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Center(child: Icon(Icons.error, color: AppColors.white)),
                        ),
                      );
                    } else if (state is SearchResultsLoaded) {
                      return TextButton(
                        onPressed: () async {
                          if (_searchController.text.isNotEmpty) {
                            await BlocProvider.of<SearchCubit>(
                              context,
                            ).search(_searchController.text);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Please enter a keyword to search for")),
                            );
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.shortestSide > 600
                              ? orientation == Orientation.portrait
                                    ? MediaQuery.of(context).size.height * 0.035
                                    : MediaQuery.of(context).size.height * 0.05
                              : orientation == Orientation.portrait
                              ? MediaQuery.of(context).size.height * 0.035
                              : MediaQuery.of(context).size.height * 0.09,

                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              "Search",
                              style: MediaQuery.of(context).size.shortestSide > 600
                                  ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    )
                                  : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                            ),
                          ),
                        ),
                      );
                    } else if (state is SearchResultsLoading) {
                      return TextButton(
                        onPressed: null,
                        child: Container(
                          height: MediaQuery.of(context).size.shortestSide > 600
                              ? orientation == Orientation.portrait
                                    ? MediaQuery.of(context).size.height * 0.035
                                    : MediaQuery.of(context).size.height * 0.05
                              : orientation == Orientation.portrait
                              ? MediaQuery.of(context).size.height * 0.035
                              : MediaQuery.of(context).size.height * 0.09,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              "Search",
                              style: MediaQuery.of(context).size.shortestSide > 600
                                  ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    )
                                  : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                            ),
                          ),
                        ),
                      );
                    }
                    return TextButton(
                      onPressed: () async {
                        if (_searchController.text.isNotEmpty) {
                          await BlocProvider.of<SearchCubit>(
                            context,
                          ).search(_searchController.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please enter a keyword to search for")),
                          );
                        }
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.shortestSide > 600
                            ? orientation == Orientation.portrait
                                  ? MediaQuery.of(context).size.height * 0.035
                                  : MediaQuery.of(context).size.height * 0.05
                            : orientation == Orientation.portrait
                            ? MediaQuery.of(context).size.height * 0.035
                            : MediaQuery.of(context).size.height * 0.09,

                        width: MediaQuery.of(context).size.width * 0.15,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            "Search",
                            style: MediaQuery.of(context).size.shortestSide > 600
                                ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  )
                                : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                hintText: 'Search',
                filled: true,
                fillColor: AppColors.grey,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                buildWhen: (previous, current) =>
                    current is SearchResultsLoading ||
                    current is SearchResultsLoaded ||
                    current is SearchResultsError,
                builder: (context, state) {
                  if (state is SearchResultsError) {
                    return Center(child: Text(state.message));
                  } else if (state is SearchResultsLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                      ),
                    );
                  } else if (state is SearchResultsLoaded) {
                    if (state.articles.isEmpty) {
                      return const Center(child: Text("No Articles Found!"));
                    }
                    final articles = state.articles;
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: articles.length + (state.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < articles.length) {
                          return ArticleItemWidget(article: articles[index]);
                        } else {
                          // loader at bottom
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  } else {
                    return const Center(child: Text("Search for articles"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
