import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/search/models/search_request_body.dart';
import 'package:news_app/features/search/services/search_services.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final _searchServices = SearchServices();
  int _currentPage = 1;
  bool _isFetching = false;
  String _currentKeyword = "";
  List<Article> _articles = [];

  Future<void> search(String keyword) async {
    emit(SearchResultsLoading());
    try {
      _currentKeyword = keyword;
      _currentPage = 1;
      _articles.clear();

      final requestBody = SearchRequestBody(
        apiKey: AppConstants.apiKey,
        q: keyword,
        page: _currentPage,
      );

      final response = await _searchServices.search(requestBody);
      _articles = response.articles ?? [];

      emit(SearchResultsLoaded(articles: List.from(_articles), hasMore: _articles.isNotEmpty));
    } catch (e) {
      emit(SearchResultsError(e.toString()));
    }
  }

  Future<void> loadMore() async {
    if (_isFetching || _currentKeyword.isEmpty) return;
    _isFetching = true;

    try {
      _currentPage++;
      final requestBody = SearchRequestBody(
        apiKey: AppConstants.apiKey,
        q: _currentKeyword,
        page: _currentPage,
      );

      final response = await _searchServices.search(requestBody);
      final newArticles = response.articles ?? [];

      if (newArticles.isEmpty) {
        emit(SearchResultsLoaded(articles: List.from(_articles), hasMore: false));
      } else {
        _articles.addAll(newArticles);
        emit(SearchResultsLoaded(articles: List.from(_articles), hasMore: true));
      }
    } catch (e) {
      emit(SearchResultsError(e.toString()));
    } finally {
      _isFetching = false;
    }
  }
}
