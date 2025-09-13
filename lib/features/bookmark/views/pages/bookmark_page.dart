import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';
import 'package:news_app/core/views/widgets/article_item_widget.dart';
import 'package:news_app/features/bookmark/bookmark_cubit/bookmark_cubit.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<BookmarkCubit, BookmarkState>(
        buildWhen: (previous, current) =>
            current is BookmarkLoading || current is BookmarkLoaded || current is BookmarkError,
        builder: (context, state) {
          if (state is BookmarkLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
              ),
            );
          } else if (state is BookmarkLoaded) {
            if (state.articles.isNotEmpty) {
              return ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      ArticleItemWidget(article: state.articles[index], inBookmark: true),
                      const Divider(),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: "https://cdn-icons-png.flaticon.com/512/13982/13982771.png",
                        height: MediaQuery.of(context).size.height * 0.18,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(height:  MediaQuery.of(context).size.height * 0.02,),
                      Center(
                        child: Text(
                          "No Bookmark Items Found",
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          } else if (state is BookmarkError) {
            return Center(child: Text(state.error));
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
              ),
            );
          }
        },
      ),
    );
  }
}
