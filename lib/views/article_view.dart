import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'dart:core';

class ArticleView extends StatefulWidget {

  final String blogUrl;
  ArticleView({required this.blogUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  final Completer<WebViewController> _completer = Completer<WebViewController>();

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
         )
       ],
     ),
      body: Container(
        child: WebView(
          initialUrl: widget.blogUrl,
          onWebViewCreated: ((WebViewController webViewController){
              _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}
