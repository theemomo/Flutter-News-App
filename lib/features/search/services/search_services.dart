import 'package:dio/dio.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/features/search/models/search_request_body.dart';

class SearchServices {
  final aDio = Dio();
  Future<NewsApiResponse> search(SearchRequestBody body) async {
    aDio.options.baseUrl = AppConstants.baseUrl;

    try {
      final headers = {
        "X-Api-Key": AppConstants.apiKey,
        // "Authorization " : "Bearer ${AppConstants.apiKey}"
      };
      final Response response = await aDio.get(
        AppConstants.everything,
        queryParameters: body.toMap(),
        options: Options(headers: headers) 
      );

      if (response.statusCode == 200) {
        return NewsApiResponse.fromMap(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      rethrow;
    }
  }
}
