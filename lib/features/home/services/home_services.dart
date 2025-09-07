import 'package:dio/dio.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/home/models/top_headlines_api_response.dart';
import 'package:news_app/features/home/models/top_headlines_request_body.dart';

class HomeServices {
  final aDio = Dio();
  Future<TopHeadlinesApiResponse> getTopHeadlines(TopHeadlinesRequestBody body) async {
    aDio.options.baseUrl = AppConstants.baseUrl;
    try {
      final headers = {
        "X-Api-Key": AppConstants.apiKey,
        // "Authorization " : "Bearer ${AppConstants.apiKey}"
      };
      final Response response = await aDio.get(
        AppConstants.topHeadlines,
        queryParameters: body.toMap(),
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return TopHeadlinesApiResponse.fromMap(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      rethrow;
    }
  }
}
