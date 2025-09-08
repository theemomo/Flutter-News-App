import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/search/models/search_request_body.dart';
import 'package:news_app/features/search/services/search_services.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  final _searchServices = SearchServices();

  Future<void> search(String keyword) async {
    emit(SearchResultsLoading());
    try {
      final requestBody = SearchRequestBody(apiKey: AppConstants.apiKey, q: keyword);
      final articles = await _searchServices.search(requestBody);
      emit(SearchResultsLoaded(articles.articles ?? []));
    } catch (e) {
      emit(SearchResultsError(e.toString()));
    }
  }
}
