import 'package:http/http.dart' as http;
import 'package:mocktest/constants/config.dart';
import 'package:mocktest/constants/url.dart';

import 'dart:convert';


import 'package:mocktest/models/book_models/audio_book_model.dart';

class ApiAudioBookDetailProvider {
  getAudioBookDetail( {required String idBook}) async {
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

    AudioBookModel audioBookModel = AudioBookModel.fromJson(jsonData);
   
    return audioBookModel;
  }
}
