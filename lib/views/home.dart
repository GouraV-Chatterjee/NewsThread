import 'package:flutter/material.dart';
import 'package:newsthread/helper/data.dart';
import 'package:newsthread/models/article_model.dart';
import 'package:newsthread/models/category_model.dart';
import 'article_view.dart';
import '../helper/news.dart';
import 'category_news.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var categories = <CategoryModel>[];
  var articles = <ArticleModel>[];

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories=getCategories();
    getNews();
  }

  getNews() async{
    News newsClass = new News();
    await newsClass.getNews();
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
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      )
          : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[

              ///Categories
              Container(
                height: 70 ,
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  },
                ),
              ),

              ///Blogs
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
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {

  final imageUrl,categoryName;
  CategoryTile({this.imageUrl,this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategoryNews(category: categoryName.toString().toLowerCase()
        )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 60,
                  width: 120,
                fit: BoxFit.cover,
                ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),

              child: Text(categoryName,style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500
              ),
              ),
            ),
          ],
        ),
      ),
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


