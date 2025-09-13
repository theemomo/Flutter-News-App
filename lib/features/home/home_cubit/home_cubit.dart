import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/services/local_database_hive.dart';
// import 'package:news_app/core/services/local_database_service.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/home/models/top_headlines_request_body.dart';
import 'package:news_app/features/home/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final _homeServices = HomeServices();
  // final _localDatabaseServices = LocalDatabaseService();
  final _localDatabaseHive = LocalDatabaseHive();

  Future<void> getTopHeadlines() async {
    emit(TopHeadLinesLoading());
    try {
      final requestBody = TopHeadlinesRequestBody(page: 1, pageSize: 10, category: "business");
      final response = await _homeServices.getTopHeadlines(requestBody);
      final articles = response.articles ?? [];

      // * get book mark list from the local database
      // final bookmarks = await _localDatabaseServices.getStringList(AppConstants.bookmarkKey);
      final bookmarks =
          (await _localDatabaseHive.getData(AppConstants.localDatabaseBox) as List?)
              ?.cast<Article>() ??
          [];

      // final List<Article> bookmarkArticles = [];
      // if (bookmarks != null) {
      //   for (var bookmarkString in bookmarks) {
      //     final Article bookmarkArticle = Article.fromJson(bookmarkString);
      //     bookmarkArticles.add(bookmarkArticle);
      //   }
      // }

      // * loop on the articles list to see if we found it in the bookmarkArticles
      for (int i = 0; i < articles.length; i++) {
        var article = articles[i];
        final bool isFound = bookmarks.any((element) => element.title == article.title);
        if (isFound) {
          article = article.copyWith(isBookmarked: true);
          articles[i] = article;
        }
      }

      emit(TopHeadLinesLoaded(articles));
    } catch (e) {
      emit(TopHeadLinesError(e.toString()));
    }
  }

  Future<void> getRecommendationNews() async {
    emit(RecommendedNewsLoading());
    try {
      final requestBody = TopHeadlinesRequestBody(page: 1, pageSize: 20);
      final response = await _homeServices.getTopHeadlines(requestBody);
      final articles = response.articles ?? [];

      // * get book mark list from the local database
      // final bookmarks = await _localDatabaseServices.getStringList(AppConstants.bookmarkKey);
      final bookmarks =
          (await _localDatabaseHive.getData(AppConstants.localDatabaseBox) as List?)
              ?.cast<Article>() ??
          [];

      // final List<Article> bookmarkArticles = [];
      // if (bookmarks != null) {
      //   for (var bookmarkString in bookmarks) {
      //     final Article bookmarkArticle = Article.fromJson(bookmarkString);
      //     bookmarkArticles.add(bookmarkArticle);
      //   }
      // }

      // * loop on the articles list to see if we found it in the bookmarkArticles
      for (int i = 0; i < articles.length; i++) {
        var article = articles[i];
        final bool isFound = bookmarks.any((element) => element.title == article.title);
        if (isFound) {
          article = article.copyWith(isBookmarked: true);
          articles[i] = article;
        }
      }

      emit(RecommendedNewsLoaded(articles));
    } catch (e) {
      emit(RecommendedNewsError(e.toString()));
    }
  }
}
