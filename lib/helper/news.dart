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

    var header ={
      'x-api-key' : 'EkkYTcdYjr7BAlU-JD9SGR7fUpxxeBQpcwALhlFeEog'
    };

    final url1 = Uri.parse("https://api.newscatcherapi.com/v2/latest_headlines?countries=IN&topic=news&lang=en");
    var response = await http.get(url1,headers: header);
    var jsonData = jsonDecode(response.body);

      if(jsonData['status'] == "ok")
      {
        print(jsonData);
        jsonData["articles"].forEach((element){

        if(element['media']!=null && element['excerpt']!=null && element['link']!=null && element['summary']!=null && element['title']!=null){

            ArticleModel articleModel = ArticleModel(
                title: element['title'],
                author: element['author'],
                description: element['excerpt'],
                url: element["link"],
                urlToImage: element['media'],
                content: element["summary"],
            );
            news.add(articleModel);
          }
        });
      }

    final url2 = Uri.parse("https://newsapi.org/v2/top-headlines?country=in&apiKey=f84c23faa8964d279a14ab55d5f48061");
    response = await http.get(url2);
    jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null &&
            element['url'] != null && element['content'] != null &&
            element['title'] != null) {
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

  var header ={
    'x-api-key' : 'EkkYTcdYjr7BAlU-JD9SGR7fUpxxeBQpcwALhlFeEog'
  };

  Future<void> getNews(String category) async{

    if(category == "finance")
      {
        final url = Uri.parse("https://api.newscatcherapi.com/v2/latest_headlines?countries=IN&topic=finance&lang=en");
        var response = await http.get(url,headers: header);
        var jsonData = jsonDecode(response.body);

        if(jsonData['status'] == "ok")
        {
          jsonData["articles"].forEach((element){

            if(element['media']!=null && element['excerpt']!=null && element['link']!=null && element['summary']!=null && element['title']!=null){

              ArticleModel articleModel = ArticleModel(
                title: element['title'],
                author: element['author'],
                description: element['excerpt'],
                url: element["link"],
                urlToImage: element['media'],
                content: element["summary"],
              );
              news.add(articleModel);
            }
          });
        }
        return ;
      }

    if(category=="politics")
      {
        final url = Uri.parse("https://api.newscatcherapi.com/v2/latest_headlines?countries=IN&topic=politics&lang=en");
        var response = await http.get(url,headers: header);
        var jsonData = jsonDecode(response.body);

        if(jsonData['status'] == "ok")
        {
          jsonData["articles"].forEach((element){

            if(element['media']!=null && element['excerpt']!=null && element['link']!=null && element['summary']!=null && element['title']!=null){

              ArticleModel articleModel = ArticleModel(
                title: element['title'],
                author: element['author'],
                description: element['excerpt'],
                url: element["link"],
                urlToImage: element['media'],
                content: element["summary"],
              );
              news.add(articleModel);
            }
          });
        }
        return ;
      }

    if(category=='world affairs')
    {
      unique.clear();
      var countries = ['US','GB','IN'];

      for(int i=0 ; i<countries.length;i++)
        {
          var country = countries[i];
          final url = Uri.parse("https://api.newscatcherapi.com/v2/latest_headlines?countries=$country&topic=world&lang=en");
          var response = await http.get(url,headers: header);
          var jsonData = jsonDecode(response.body);

          if(jsonData['status'] == "ok")
          {
            jsonData["articles"].forEach((element){

              if(element['media']!=null && element['excerpt']!=null && element['link']!=null && element['summary']!=null && element['title']!=null){

                ArticleModel articleModel = ArticleModel(
                  title: element['title'],
                  author: element['author'],
                  description: element['excerpt'],
                  url: element["link"],
                  urlToImage: element['media'],
                  content: element["summary"],
                );
                news.add(articleModel);
              }
            });
          }
        }
      news.shuffle();
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

    if(category=="technology")
      {
        final url2 = Uri.parse("https://api.newscatcherapi.com/v2/latest_headlines?countries=IN&topic=tech&lang=en");

        var response2 = await http.get(url2,headers: header);
        var jsonData2 = jsonDecode(response2.body);


        if(jsonData2['status'] == "ok")
        {
          jsonData2["articles"].forEach((element){

                if(element['media']!=null && element['excerpt']!=null && element['link']!=null && element['summary']!=null && element['title']!=null){

                    ArticleModel articleModel = ArticleModel(
                        title: element['title'],
                        author: element['author'],
                        description: element['excerpt'],
                        url: element["link"],
                        urlToImage: element['media'],
                        content: element["summary"],
                    );
                    news.add(articleModel);
                  }
                });
        }
        news.shuffle();
      }
  }
}