part of 'bookmark_cubit.dart';

sealed class BookmarkState {}

final class BookmarkInitial extends BookmarkState {}

final class BookmarkLoading extends BookmarkState {}

final class BookmarkLoaded extends BookmarkState {
  final List<Article> articles;

  BookmarkLoaded(this.articles);
}

final class BookmarkError extends BookmarkState {
  final String error;

  BookmarkError(this.error);

}
