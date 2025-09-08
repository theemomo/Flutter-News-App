part of 'search_cubit.dart';

sealed class SearchState {
  const SearchState();
}

final class SearchInitial extends SearchState {}

final class SearchResultsLoading extends SearchState {}

final class SearchResultsLoaded extends SearchState {
  final List<Article> articles;
  final bool hasMore;

  const SearchResultsLoaded({required this.articles,required this.hasMore});
}

final class SearchResultsError extends SearchState {
  final String message;

  const SearchResultsError(this.message);
}
