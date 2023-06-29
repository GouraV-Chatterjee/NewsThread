import 'dart:convert';
import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class News
{
  var news = <ArticleModel>[];

  Future<void> getNews() async{
    final url = Uri.parse("https://newsapi.org/v2/top-headlines?country=in&apiKey=f84c23faa8964d279a14ab55d5f48061");

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);


      if(jsonData['status'] == "ok")
      {
        jsonData["articles"].forEach((element){

        if(element['urlToImage']!=null && element['description']!=null && element['url']!=null && element['content']!=null && element['title']!=null){
            ArticleModel articleModel = ArticleModel(
                title: element['title'],
                author: element['author'],
                description: element['description'],
                url: element["url"],
                urlToImage: element['urlToImage'],
                content: element["content"]
            );
            news.add(articleModel);
          }
        });
      }
  }
}

class CategoryNewsClass
{
  var news = <ArticleModel>[];

  Future<void> getNews(String category) async{
    final url = Uri.parse("https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=f84c23faa8964d279a14ab55d5f48061");

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);


    if(jsonData['status'] == "ok")
    {
      jsonData["articles"].forEach((element){

        if(element['urlToImage']!=null && element['description']!=null && element['url']!=null && element['content']!=null && element['title']!=null){
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element["url"],
              urlToImage: element['urlToImage'],
              content: element["content"]
          );
          news.add(articleModel);
        }
      });
    }
  }
}