import 'dart:convert';
import '../models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:collection';

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
                content: element["content"],
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
  HashSet<String> unique = HashSet<String>();

  Future<void> getNews(String category) async{

    if(category=='world affairs')
    {
      unique.clear();
      // final url2 = Uri.parse("https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=f84c23faa8964d279a14ab55d5f48061");
      //
      // var response2 = await http.get(url2);
      // var jsonData2 = jsonDecode(response2.body);
      //
      // if(jsonData2['status'] == "ok")
      // {
      //   jsonData2["articles"].forEach((element){
      //
      //     if(element['urlToImage']!=null && element['description']!=null && element['url']!=null && element['content']!=null && element['title']!=null && !unique.contains(element["title"])){
      //
      //       ArticleModel articleModel = ArticleModel(
      //         title: element['title'],
      //         author: element['author'],
      //         description: element['description'],
      //         url: element["url"],
      //         urlToImage: element['urlToImage'],
      //         content: element["content"],
      //       );
      //       news.add(articleModel);
      //       unique.add(element["title"]);
      //     }
      //   });
      // }

      var countries = ['us','gb'];

      for(int i=0 ; i<countries.length;i++)
        {
          var country = countries[i];
          var url = Uri.parse("https://newsapi.org/v2/top-headlines?country=$country&apiKey=f84c23faa8964d279a14ab55d5f48061");
          var response = await http.get(url);
          var jsonData = jsonDecode(response.body);

          if(jsonData['status'] == "ok")
          {
            jsonData["articles"].forEach((element){

              if(element['urlToImage']!=null && element['description']!=null && element['url']!=null && element['content']!=null && element['title']!=null && !unique.contains(element["title"])){

                ArticleModel articleModel = ArticleModel(
                  title: element['title'],
                  author: element['author'],
                  description: element['description'],
                  url: element["url"],
                  urlToImage: element['urlToImage'],
                  content: element["content"],
                );
                news.add(articleModel);
                unique.add(element["title"]);
              }
            });
          }
        }
      return ;
    }


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
              content: element["content"],
          );
          news.add(articleModel);
        }
      });
    }

    if(category.compareTo('technology') == 0)
      {
        final url2 = Uri.parse("https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=f84c23faa8964d279a14ab55d5f48061");

        var response2 = await http.get(url2);
        var jsonData2 = jsonDecode(response2.body);


        if(jsonData2['status'] == "ok")
        {
          jsonData2["articles"].forEach((element){

            if(element['urlToImage']!=null && element['description']!=null && element['url']!=null && element['content']!=null && element['title']!=null){

              ArticleModel articleModel = ArticleModel(
                  title: element['title'],
                  author: element['author'],
                  description: element['description'],
                  url: element["url"],
                  urlToImage: element['urlToImage'],
                  content: element["content"],
              );
              news.add(articleModel);
            }
          });
        }

        news.shuffle();
      }
  }
}