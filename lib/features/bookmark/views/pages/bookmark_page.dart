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
                      ArticleItemWidget(article: state.articles[index], inBookmark: true,),
                      const Divider()
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: Text("No Bookmark Items Found"),);
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
