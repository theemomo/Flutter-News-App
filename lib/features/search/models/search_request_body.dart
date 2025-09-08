class SearchRequestBody {
  final String apiKey;
  final String? q;
  final String? searchIn;
  final String? sources;
  final String? domains;
  final String? excludeDomains;
  final String? from;
  final String? to;
  final String? language;
  final String? sortBy;
  final int? pageSize;
  final int? page;
  SearchRequestBody({
    required this.apiKey,
    this.q,
    this.searchIn = 'title',
    this.sources,
    this.domains,
    this.excludeDomains,
    this.from,
    this.to,
    this.language,
    this.sortBy,
    this.pageSize = 15,
    this.page = 1,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'apiKey': apiKey,
      'q': q,
      'searchIn': searchIn,
      'sources': sources,
      'domains': domains,
      'excludeDomains': excludeDomains,
      'from': from,
      'to': to,
      'language': language,
      'sortBy': sortBy,
      'pageSize': pageSize,
      'page': page,
    };
  }

  factory SearchRequestBody.fromMap(Map<String, dynamic> map) {
    return SearchRequestBody(
      apiKey: map['apiKey'] as String,
      q: map['q'] != null ? map['q'] as String : null,
      searchIn: map['searchIn'] != null ? map['searchIn'] as String : null,
      sources: map['sources'] != null ? map['sources'] as String : null,
      domains: map['domains'] != null ? map['domains'] as String : null,
      excludeDomains: map['excludeDomains'] != null ? map['excludeDomains'] as String : null,
      from: map['from'] != null ? map['from'] as String : null,
      to: map['to'] != null ? map['to'] as String : null,
      language: map['language'] != null ? map['language'] as String : null,
      sortBy: map['sortBy'] != null ? map['sortBy'] as String : null,
      pageSize: map['pageSize'] != null ? map['pageSize'] as int : null,
      page: map['page'] != null ? map['page'] as int : null,
    );
  }
}
