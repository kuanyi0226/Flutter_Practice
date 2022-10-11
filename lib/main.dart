import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

import 'Article.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.blue),
        textTheme: const TextTheme(
          bodyText2: TextStyle(fontSize: 24),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> articles = [];
  int _pageIndex = 1;

  void _nextPage() {
    setState(() {
      _pageIndex++;
      //一直在Page1~4巡迴
      if (_pageIndex > 4) {
        _pageIndex = 1;
      }
      print("$_pageIndex");
      getWebsiteData();
    });
  }

  @override
  void initState() {
    super.initState();
    getWebsiteData();
  }

  Future getWebsiteData() async {
    final url =
        Uri.parse('https://www.amazon.com/s?k=中島みゆきcd&page=${_pageIndex}');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll('h2 > a > span')
        .map((e) => e.innerHtml.trim())
        .toList();

    final urls = html
        .querySelectorAll('h2 > a')
        .map((e) => 'https://www.amazon.com/${e.attributes['href']}')
        .toList();

    final urlImages = html
        .querySelectorAll('span > a > div > img')
        .map((e) => e.attributes['src']!)
        .toList();

    print('Count: ${titles.length}');

    setState(() {
      articles = List.generate(
        titles.length,
        (index) => Article(
          url: urls[index],
          title: titles[index],
          urlImage: urlImages[index],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('中島みゆき in Amazon'),
        centerTitle: true,
      ),
      body: articles.isEmpty
          ? Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Center(
                    child: Image(
                        image: NetworkImage(
                            'http://img-cdn.jg.jugem.jp/e36/2411548/20140812_280861.jpg')),
                  ),
                ),
                Text('Waiting for crawler~')
              ],
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];

                return ListTile(
                  leading: Image.network(
                    article.urlImage,
                    width: 50,
                    fit: BoxFit.fitHeight,
                  ),
                  title: Text(article.title),
                  subtitle: Text(
                    article.url,
                    style: TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _nextPage,
        child: Icon(Icons.arrow_right),
      ),
    );
  }
}
