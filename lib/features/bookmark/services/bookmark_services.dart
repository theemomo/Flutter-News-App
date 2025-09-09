import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/services/local_database_service.dart';
import 'package:news_app/core/utils/app_constants.dart';

class BookmarkServices {
  Future<List<Article>> getBookmarked() async {
    final _localDatabaseServices = LocalDatabaseService();
    final bookmarkList = await _localDatabaseServices.getStringList(AppConstants.bookmarkKey);
    if (bookmarkList == null) return [];
    return bookmarkList.map((e) => Article.fromJson(e)).toList();
  }
}
