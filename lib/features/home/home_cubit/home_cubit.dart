
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/models/top_headlines_api_response.dart';
import 'package:news_app/features/home/models/top_headlines_request_body.dart';
import 'package:news_app/features/home/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final _homeServices = HomeServices();

  Future<void> getTopHeadlines() async {
    emit(TopHeadLinesLoading());
    try {
      final requestBody = TopHeadlinesRequestBody(page: 1, pageSize: 7, category: "business");
      final response = await _homeServices.getTopHeadlines(requestBody);
      emit(TopHeadLinesLoaded(response.articles));
    } catch (e) {
      emit(TopHeadLinesError(e.toString()));
    }
  }
}
