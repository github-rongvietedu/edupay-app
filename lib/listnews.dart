import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';

import 'dart:async';
import 'dart:convert';
import 'Homepage/homepage.dart';
import 'constants.dart';
import 'models/news.dart';
import 'models/student.dart';
import 'package:intl/intl.dart';
import 'main.dart';

// import 'package:fluttertoast/fluttertoast.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'widget/drawer.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NewsPage(),
    routes: <String, WidgetBuilder>{
      "/NewsPage": (BuildContext context) => new NewsPage()
    },
  ));
}

class NewsPage extends StatefulWidget {
  // Declare a field that holds the Todo.

  // In the constructor, require a Todo.

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Map data;
  late List userData;
  //
  final String api_key = 't9ap14wuhFIPorM3oiwowVSwPCc=';
  late String username = "DragonAppManager";
  late String password = "AppMNGR0ngViet@2020";
  late String basicAuth =
      "Basic " + utf8.fuse(base64).encode('$username:$password');

  Future<List<News>> getData() async {
    List<News> lstNews;
    http.Response response = await http.get(
        Uri.parse('http://apiserver.rveapp.com/api/dragonapp/News/getAll_News'),
        headers: <String, String>{
          "Accept": "application/json",
          "authorization": basicAuth,
          "api_key": api_key
        });

    lstNews = [];
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.

      var jsonData = json.decode(response.body);
      // setState(() {

      for (var u in jsonData) {
        News news = News.fromJson(u);
        // lstNews.add(news);
      }
      return lstNews;
      // });
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      Fluttertoast.showToast(
          msg: "Connect to server faild!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return lstNews;
  }

  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future<bool> _onBackPressed() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePageScreen(
            warningLog: false,
          ),
        ),
      );
      return Future.value(false);
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: FutureBuilder<List<News>>(
          future: getData(),
          builder: (context, AsyncSnapshot<List<News>> snapshot) {
            List<News> lstNews = snapshot.data ?? [];
            if (snapshot.hasData) {
              return Scaffold(
                appBar: new AppBar(
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.home),
                      tooltip: "Trang chủ",
                      onPressed: () => {
                        //Navigator.pop(context)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePageScreen(
                              warningLog: false,
                            ),
                          ),
                        )
                      },
                    )
                  ],
                  backgroundColor: kPrimaryColor,
                  title: new Text(
                    "THÔNG BÁO CHUNG",
                    style: TextStyle(fontSize: 14),
                  ),
                  elevation: debugDefaultTargetPlatformOverride ==
                          TargetPlatform.android
                      ? 5.0
                      : 0.0,
                ), //Appbar
                drawer: MyDrawer('News'),
                body: lstNews.isNotEmpty
                    ? makeBody(lstNews, context)
                    : Container(
                        width: size.width,
                        height: 120.0,
                        margin: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 24.0,
                        ),
                        child: Card(
                          child: Center(
                              child:
                                  Text("Chưa có thông báo đến từ nhà trường.")),
                        )),
                // floatingActionButton: FloatingActionButton.extended(
                //   label: Text('Quay lại'),
                //   icon: Icon(Icons.rotate_left),
                //   backgroundColor: Color.fromRGBO(33, 150, 243, .9),
                //   foregroundColor: Colors.white,
                //   tooltip: 'Quay lại',
                //   onPressed: () => {
                //     //Navigator.pop(context)
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => HomePageScreen(),
                //       ),
                //     )
                //   },
                // )
              );
            }
            return Scaffold(
              appBar: new AppBar(
                backgroundColor: kPrimaryColor,
                title: new Text(
                  "THÔNG BÁO CHUNG",
                  style: TextStyle(fontSize: 14),
                ),
                elevation:
                    debugDefaultTargetPlatformOverride == TargetPlatform.android
                        ? 5.0
                        : 0.0,
              ), //Appbar
              body: Center(
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator())),
            );
          }),
    );
  }
}

makeBody(List<News> lstNews, BuildContext context) {
  return Container(
      child: ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: lstNews == null ? 0 : lstNews.length,
    itemBuilder: (BuildContext context, int index) {
      return makeCard(lstNews, index, context); //planetCard;
      //makeCard(lstStudent,index,context);
    },
  ));
}

final planetCard = new Container(
  height: 154.0,
  margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
  decoration: new BoxDecoration(
    color: Color.fromRGBO(33, 150, 243, .9),
    shape: BoxShape.rectangle,
    borderRadius: new BorderRadius.circular(8.0),
    boxShadow: <BoxShadow>[
      new BoxShadow(
        color: Colors.black12,
        blurRadius: 40.0,
        offset: new Offset(0.0, 10.0),
      ),
    ],
  ),
);

class PlanetRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120.0,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            planetCard,
            planetThumbnail,
          ],
        ));
  }
}

final planetThumbnail = new Container(
  margin: new EdgeInsets.symmetric(vertical: 16.0),
  alignment: FractionalOffset.centerLeft,
  child: CircleAvatar(
    radius: 40.0,
    backgroundColor: Colors.red,
  ),
);

Padding _appoinmentCard(News news, int index) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.5),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              news.title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Html(
                        data: news.content,
                        onLinkTap: (String? url, RenderContext context,
                            Map<String, String> attributes, element) async {
                          Uri _url = Uri.parse('https://flutter.dev');
                          await launchUrl(
                            _url,
                          );
                          //open URL in webview, or launch URL in browser, or any other logic here
                        }),

                    // Text(
                    //   news.content,
                    //   style: TextStyle(
                    //       color: Colors.black54,
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 16.0),
                    // )

                    flex: 10,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Text(article.author, style: TextStyle(fontSize: 18.0),),
                    Text(
                      DateFormat('dd/MM/yyyy').format(news.dateOfPosting),
                      style: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                //Icon(Icons.bookmark_border),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

makeCard(List<News> lstNews, int index, BuildContext context) {
  return new GestureDetector(
      child: _appoinmentCard(lstNews[index], index),
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => NotificationDetail(
        //               title: lstNews[index].title,
        //               content: lstNews[index].content,
        //             )));
      });
}
