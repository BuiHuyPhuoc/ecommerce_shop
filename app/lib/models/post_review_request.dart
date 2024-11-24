import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostReviewRequest {
  int idProduct;
  int rating;
  String content;
  PostReviewRequest({
    required this.idProduct,
    required this.rating,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idProduct': idProduct,
      'rating': rating,
      'content': content,
    };
  }

  factory PostReviewRequest.fromMap(Map<String, dynamic> map) {
    return PostReviewRequest(
      idProduct: map['idProduct'] as int,
      rating: map['rating'] as int,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostReviewRequest.fromJson(String source) =>
      PostReviewRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
