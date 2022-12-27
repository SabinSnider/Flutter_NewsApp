import 'package:flutter/material.dart';
import 'package:news_app/services/api_service.dart';

import 'components/customListTile.dart';
import 'model/article_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("News App", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        //Call API services with futurebuilder widget
        body: FutureBuilder(
          future: client.getArticle(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            //check response
            if (snapshot.hasData) {
              //create a list of articles
              List<Article>? articles = snapshot.data;
              // print(articles);
              return ListView.builder(
                  itemCount: articles?.length,
                  itemBuilder: (BuildContext context, int index) =>
                      // ListTile(title: Text(articles![index].title)));
                      customListTile(articles![index]));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
