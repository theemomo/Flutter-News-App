import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';
import 'package:news_app/core/models/news_api_response.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<Article> articles;
  const CustomCarouselSlider({super.key, required this.articles});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 210,
          child: CarouselSlider(
            items: widget.articles.map((article) {
              final parsedDate = DateTime.parse(article.publishedAt ?? DateTime.now().toString());
              final publishedAtDate = DateFormat.yMMMd().format(parsedDate);
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.articleRoute, arguments: article);
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  child: Stack(
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl:
                            article.urlToImage ??
                            'https://imgs.search.brave.com/4QxmcZ7tq_opuG5R8dwTzb3gYaIKYkDQC2iZRJ4a2Wk/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9kZXZl/bG9wZXJzLmVsZW1l/bnRvci5jb20vZG9j/cy9hc3NldHMvaW1n/L2VsZW1lbnRvci1w/bGFjZWhvbGRlci1p/bWFnZS5wbmc',
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 210,
                        placeholder: (context, url) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.38,
                            height: MediaQuery.of(context).size.height * 0.16,
                            color: Colors.grey.shade300,
                            child: const Center(child: CircularProgressIndicator.adaptive(
                              valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                              strokeWidth: 2,
                            )),
                          );
                        },
                        errorWidget: (context, url, error) => CachedNetworkImage(
                          imageUrl:
                              "https://imgs.search.brave.com/4QxmcZ7tq_opuG5R8dwTzb3gYaIKYkDQC2iZRJ4a2Wk/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9kZXZl/bG9wZXJzLmVsZW1l/bnRvci5jb20vZG9j/cy9hc3NldHMvaW1n/L2VsZW1lbnRvci1w/bGFjZWhvbGRlci1p/bWFnZS5wbmc",
                          width: double.infinity,
                          height: 210,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${article.source!.name ?? ''} • $publishedAtDate",
                                style: Theme.of(
                                  context,
                                ).textTheme.titleSmall!.copyWith(color: Colors.white),
                              ),
                              Text(
                                article.title ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            carouselController: _controller,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.articles.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: _currentIndex == entry.key ? 25.0 : 10.0,
                height: 10.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: _currentIndex == entry.key ? BorderRadius.circular(20) : null,
                  shape: _currentIndex == entry.key ? BoxShape.rectangle : BoxShape.circle,
                  color: _currentIndex == entry.key ? AppColors.primaryColor : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
