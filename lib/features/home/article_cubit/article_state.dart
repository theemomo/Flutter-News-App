part of 'article_cubit.dart';

sealed class ArticleState {}

final class ArticleInitial extends ArticleState {}

final class BookmarkLoading extends ArticleState {}

final class BookmarkAdded extends ArticleState {
  final Article article;
  BookmarkAdded(this.article);
}

final class BookmarkRemoved extends ArticleState {
  final Article article;
  BookmarkRemoved(this.article);
}

final class BookmarkError extends ArticleState {
  final String error;
  BookmarkError(this.error);
}
