import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:mocktest/models/book_models/more_book_model.dart';

class ApiMoreBookProvider {
  getMoreBook(String idSeller) async {
    // String? idSeller;
    //  MoreBookModel moreBookModel;
    final response = await http.post(
        Uri.parse(""),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "topicBookId": null,
          "seller": null,
          "isdnSeller": idSeller,
          "type": [],
          "rate": [],
          "priceFrom": null,
          "priceTo": null,
          "page": 0,
          "pageSize": 8,
          "order": 1
        }));

    List<dynamic> jsonData =
        json.decode(utf8.decode(response.bodyBytes))['data']["content"];

    List<BookRelateModel> bookRelateModel =
        jsonData.map((json) => BookRelateModel.fromJson(json)).toList();

    return bookRelateModel;
  }
}
