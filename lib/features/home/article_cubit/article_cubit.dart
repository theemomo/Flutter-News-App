import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/services/local_database_hive.dart';
// import 'package:news_app/core/services/local_database_service.dart';
import 'package:news_app/core/utils/app_constants.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit() : super(ArticleInitial());
  // final _localDatabaseServices = LocalDatabaseService();
  final _localDatabaseHive = LocalDatabaseHive();

  Future<void> setBookmark(Article article) async {
    emit(BookmarkLoading());
    try {
      // final bookmarksString = await _localDatabaseServices.getStringList(AppConstants.bookmarkKey);
      final bookmarks =
          (await _localDatabaseHive.getData(AppConstants.localDatabaseBox) as List?)
              ?.cast<Article>() ??
          [];

      // * convert the bookmark (List<String>?) to (List<Article>?)
      // final List<Article> bookmarkArticles = [];
      // if (bookmarksString != null) {
      //   for (var bookmarkString in bookmarksString) {
      //     final Article bookmarkArticle = Article.fromJson(bookmarkString);
      //     bookmarkArticles.add(bookmarkArticle);
      //   }
      // }
      final bool isFound = bookmarks.any((element) => element.title == article.title);

      if (isFound) {
        final index = bookmarks.indexWhere((element) => element.title == article.title);

        bookmarks.removeAt(index);

        // await _localDatabaseServices.setStringList(
        //   AppConstants.bookmarkKey,
        //   bookmarks.map((article) => article.toJson()).toList(),
        // );
        article = article.copyWith(isBookmarked: false);
        await _localDatabaseHive.saveData<List<Article>>(AppConstants.localDatabaseBox, bookmarks);
        emit(BookmarkRemoved(article));
      } else {
        bookmarks.add(article);
        // await _localDatabaseServices.setStringList(
        //   AppConstants.bookmarkKey,
        //   bookmarks.map((article) => article.toJson()).toList(),
        // );
        article = article.copyWith(isBookmarked: true);
        await _localDatabaseHive.saveData<List<Article>>(AppConstants.localDatabaseBox, bookmarks);
        emit(BookmarkAdded(article));
      }
      debugPrint('Bookmark Items Count: ${bookmarks.length}');
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }
}
