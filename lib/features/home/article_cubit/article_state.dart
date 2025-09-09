part of 'article_cubit.dart';

sealed class ArticleState {}

final class ArticleInitial extends ArticleState {}

final class BookmarkLoading extends ArticleState {}

final class BookmarkAdded extends ArticleState {
  final String title;
  BookmarkAdded(this.title);
}

final class BookmarkRemoved extends ArticleState {
  final String title;
  BookmarkRemoved(this.title);
}

final class BookmarkError extends ArticleState {
  final String error;
  BookmarkError(this.error);
}
