//HTTP request service, get http resqust form API and return list of Articels

import 'dart:convert';

import 'package:http/http.dart';

import '../model/article_model.dart';

class ApiService {
  final endPointUrl =
      "https://newsapi.org/v2/everything?q=Apple&from=2022-12-27&sortBy=popularity&apiKey=892977179ae544fe918b6964670357c1";

//http request function

  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(endPointUrl));
    //check 200 status
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      List<dynamic> body = json['articles'];
      //To get different articles from json file and put the into a list
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
