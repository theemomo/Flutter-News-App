

class TopHeadlinesRequestBody {
  final String? q;
  final String country;
  final String? category;
  final String? sources;
  final int? page;
  final int? pageSize;

  TopHeadlinesRequestBody({
    this.q,
    this.country = 'us',
    this.category,
    this.sources,
    this.page,
    this.pageSize,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'q': q,
      'country': country,
      'category': category,
      'sources': sources,
      'page': page,
      'pageSize': pageSize,
    };
  }

  factory TopHeadlinesRequestBody.fromMap(Map<String, dynamic> map) {
    return TopHeadlinesRequestBody(
      q: map['q'] != null ? map['q'] as String : null,
      country: map['country'] as String,
      category: map['category'] != null ? map['category'] as String : null,
      sources: map['sources'] != null ? map['sources'] as String : null,
      page: map['page'] != null ? map['page'] as int : null,
      pageSize: map['pageSize'] != null ? map['pageSize'] as int : null,
    );
  }
}
