import 'package:http/http.dart' as http;

import 'package:mocktest/constants/url.dart';

import 'dart:convert';

import 'package:mocktest/models/book_models/ebook_model.dart';

class ApiEBookDetailProvider {
  getEBookDetail({required String idBook}) async {
    final response = await http.get(
        Uri.parse(
            ''),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${URL.token}'
        });
    String responseBody = response.body;

    Map<String, dynamic> jsonData =
        json.decode(utf8.decode(responseBody.codeUnits))['data'];

    EbookModel ebookModel = EbookModel.fromJson(jsonData);

    return ebookModel;
  }
}
