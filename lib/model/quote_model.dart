class QuoteModel{
  final String quote;
  final String author;
  final String category;

  QuoteModel({required this.quote,required this.author,required this.category});

  factory QuoteModel.fromJson(json){
    return QuoteModel(quote: json['quote'], author: json['author'],category: json['category']);
  }
}