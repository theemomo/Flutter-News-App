import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/home_cubit/home_cubit.dart';
import 'package:news_app/features/home/views/widgets/custom_carousel_slider.dart';
import 'package:news_app/features/home/views/widgets/title_headline_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = HomeCubit();
        cubit.getTopHeadlines();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.list)),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.bell)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TitleHeadlineWidget(title: "Breaking News", onTap: () {}),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is TopHeadLinesLoaded) {
                    return CustomCarouselSlider(articles: state.articles ?? []);
                  } else if (state is TopHeadLinesError) {
                    return Center(child: Text(state.message));
                  } else if (state is TopHeadLinesLoading) {
                    return const CircularProgressIndicator.adaptive();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              TitleHeadlineWidget(title: "Recommendation", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
