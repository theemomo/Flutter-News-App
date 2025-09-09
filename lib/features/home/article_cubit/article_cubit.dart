import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/services/local_database_service.dart';
import 'package:news_app/core/utils/app_constants.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit() : super(ArticleInitial());
  final _localDatabaseServices = LocalDatabaseService();

  Future<void> setBookmark(Article article) async {
    emit(BookmarkLoading());
    try {
      final bookmarks = await _localDatabaseServices.getStringList(AppConstants.bookmarkKey);
      final List<Article> bookmarkArticles = [];
      if (bookmarks != null) {
        for (var bookmarkString in bookmarks) {
          final Article bookmarkArticle = Article.fromJson(bookmarkString);
          bookmarkArticles.add(bookmarkArticle);
        }
      }

      final bool isFound = bookmarkArticles.any((element) => element.title == article.title);

      if (isFound) {
        final index = bookmarkArticles.indexWhere((element) => element.title == article.title);

        bookmarkArticles.removeAt(index);

        await _localDatabaseServices.setStringList(
          AppConstants.bookmarkKey,
          bookmarkArticles.map((article) => article.toJson()).toList(),
        );
        emit(BookmarkRemoved(article.title ?? ''));
      } else {
        bookmarkArticles.add(article);
        await _localDatabaseServices.setStringList(
          AppConstants.bookmarkKey,
          bookmarkArticles.map((article) => article.toJson()).toList(),
        );
        emit(BookmarkAdded(article.title ?? ''));
      }
      debugPrint('Bookmark Items Count: ${bookmarkArticles.length}');
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }


  
}
