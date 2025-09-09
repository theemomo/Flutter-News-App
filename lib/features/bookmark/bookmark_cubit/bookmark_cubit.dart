import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkInitial());
}
