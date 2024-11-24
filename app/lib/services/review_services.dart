import 'package:dio/dio.dart';
import 'package:ecommerce_shop/models/post_review_request.dart';
import 'package:ecommerce_shop/services/api_services.dart';

Future<bool> PostReview(PostReviewRequest request) async {
  Dio _dio = Dio();
  return ExecuteWithRetry<bool>(
    () async {
      await _dio.post(
        "$baseUrl/Review/PostReview",
        options: Options(
          headers: await BuildHeaders(withAuthorization: true),
        ),
        data: request.toMap(),
      );
      return true;
    },
  );
}
