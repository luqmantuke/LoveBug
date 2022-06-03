class LoveQuoteModel {
  final String? quote;
  final String? author;

  LoveQuoteModel({
    this.quote,
    this.author,
  });

  LoveQuoteModel.fromJson(Map<String, dynamic> json)
      : quote = json['quote'] as String?,
        author = json['author'] as String?;

  Map<String, dynamic> toJson() => {'quote': quote, 'author': author};
}
