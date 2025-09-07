part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}


// Top Headlines
final class TopHeadLinesLoading extends HomeState {}

final class TopHeadLinesLoaded extends HomeState {
  final List<Article>? articles;
  TopHeadLinesLoaded(this.articles);
}

final class TopHeadLinesError extends HomeState {
  final String message;
  TopHeadLinesError(this.message);
}

// Recommended News
final class RecommendedNewsLoading extends HomeState {}

final class RecommendedNewsLoaded extends HomeState {
  final List<Article> articles;
  RecommendedNewsLoaded(this.articles);
}

final class RecommendedNewsError extends HomeState {
  final String message;
  RecommendedNewsError(this.message);
}

