import 'package:http/http.dart' as http;

import 'package:mocktest/constants/url.dart';
import 'package:mocktest/models/book_models/book_all_rating.dart';

import 'dart:convert';

import 'package:mocktest/models/book_models/book_total_review.dart';

class ApiAllRatingProvider {
  getAllRating(String productCode) async {
    // String? idSeller;
    //  MoreBookModel moreBookModel;
    final response = await http.post(
        Uri.parse(
            ""),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${URL.token}'
        },
        body: jsonEncode(
            {"productCode": productCode, "productType": "3", "rate": null}));

    //  List<dynamic> responseBody;
    List<dynamic> jsonData =
        json.decode(utf8.decode(response.bodyBytes))['data']["listReview"];

    List<BookAllRating> bookAllRating =
        jsonData.map((jsonData) => BookAllRating.fromJson(jsonData)).toList();
       
    return (bookAllRating);
  }

  getTotalRating(String productCode) async {
    final response = await http.post(
        Uri.parse(
            "https://seller-13.laosedu.la/api/reviews/search-all?page=0&pageSize=10"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${URL.token}'
        },
        body: jsonEncode(
            {"productCode": productCode, "productType": "3", "rate": null}));

    String responseBody = response.body;

    Map<String, dynamic> jsonDataaaaa =
        json.decode(utf8.decode(responseBody.codeUnits))['data'];

    BookTotalReview bookTotalReview = BookTotalReview.fromJson(jsonDataaaaa);
    
    return bookTotalReview;
  }
}
