import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/services/local_database_service.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/bookmark/services/bookmark_services.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkInitial());

  final _bookmarkServices = BookmarkServices();
  final _localDatabaseServices = LocalDatabaseService();

  Future<void> getBookmarked() async {
    emit(BookmarkLoading());
    try {
      final result = await _bookmarkServices.getBookmarked();
      final articles = result;
      // * get book mark list from the local database
      final bookmarks = await _localDatabaseServices.getStringList(AppConstants.bookmarkKey);
      // final bookmarks = await _localDatabaseHive.getData<List<Article>>(AppConstants.localDatabaseBox);
      final List<Article> bookmarkArticles = [];
      if (bookmarks != null) {
        for (var bookmarkString in bookmarks) {
          final Article bookmarkArticle = Article.fromJson(bookmarkString);
          bookmarkArticles.add(bookmarkArticle);
        }
      }

      // * loop on the articles list to see if we found it in the bookmarkArticles
      for (int i = 0; i < articles.length; i++) {
        var article = articles[i];
        final bool isFound = bookmarkArticles.any((element) => element.title == article.title);
        if (isFound) {
          article = article.copyWith(isBookmarked: true);
          articles[i] = article;
        }
      }
      emit(BookmarkLoaded(articles));
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }
}
