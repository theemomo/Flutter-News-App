import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/features/bookmark/services/bookmark_services.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkInitial());

  final _bookmarkServices = BookmarkServices();

  Future<void> getBookmarked() async {
    emit(BookmarkLoading());
    try {
      final result = await _bookmarkServices.getBookmarked();
      emit(BookmarkLoaded(result));
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }
}
