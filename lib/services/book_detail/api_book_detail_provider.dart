import 'package:http/http.dart' as http;
import 'package:mocktest/constants/url.dart';

import 'dart:convert';

import 'package:mocktest/models/book_detail_model/book_detail_model.dart';

class ApiBookDetailProvider {
  
  getBookDetail({required String idBook}) async {
    try{
    
    final response = await http.get(
        Uri.parse(''),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer ${URL.token}'
        });

    String responseBody = response.body;

    Map<String, dynamic> jsonData =
        json.decode(utf8.decode(responseBody.codeUnits));

    BookDetail bookDetail = BookDetail.fromJson(jsonData);

  print(bookDetail.id);
    return bookDetail;
  } catch (e){
    print(e);
  }
  }
}
