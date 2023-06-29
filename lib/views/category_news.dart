import 'package:flutter/material.dart';
import 'package:newsthread/helper/news.dart';
import 'package:newsthread/models/article_model.dart';
import 'package:newsthread/helper/data.dart';
import 'package:newsthread/models/category_model.dart';
import '../helper/news.dart';
import 'package:flutter/widgets.dart';
import 'package:newsthread/views/article_view.dart';

class CategoryNews extends StatefulWidget {
  // const CategoryNews({super.key});

  final String category;
  CategoryNews({required this.category});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  var articles = <ArticleModel>[];
  bool _loading = true;

  void initState(){
    //TODO : implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async{
    CategoryNewsClass newsClass = new CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/title.png',
                width: 200,
                height: 200),
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ):
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 16),
                    child: ListView.builder(
                        itemCount:articles.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context,index){
                          return BlogTile(
                            imageUrl: articles[index].urlToImage,
                            title: articles[index].title,
                            desc: articles[index].description,
                            url: articles[index].url,
                          );
                        }),
                  ),
                ],
              ),
            ),
          )
        );
  }
}

class BlogTile extends StatelessWidget {

  final String imageUrl,title,desc,url;
  BlogTile({required this.imageUrl,required this.title,required this.desc,required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => ArticleView(
                blogUrl: url,
              )
          ));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(imageUrl)),
              SizedBox(height: 8,),
              Text(title,style:
              TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500
              ),
              ),

              Text(desc,style: TextStyle(
                  color: Colors.black54
              ),
              )
            ],
          ),
        )
    );
  }
}
