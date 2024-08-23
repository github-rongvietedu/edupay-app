import 'package:bts_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:minhduc_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import 'listnews.dart';
import 'models/resetPassword/otp_page.dart';

class NotificationDetail extends StatelessWidget {
  final String title;
  final String content;
  static const routeName = '/detailNotification';
  const NotificationDetail({Key? key, this.title = "", this.content = ""})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String titleDisplay = this.title;
    String contentDisplay = this.content;
    // final args = ModalRoute.of(context)?.settings.arguments as ScreenArguments;
    // if (args != null) {
    //   titleDisplay = args.title;
    //   contentDisplay = args.message;
    // }
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => NewsPage()),
            (Route<dynamic> route) => false);

        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(titleDisplay),
            backgroundColor: kPrimaryColor,
          ),
          body: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
                border: Border.all(color: kPrimaryColor),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: kPrimaryColor.withAlpha(80),
                    blurRadius: 6.0,
                    spreadRadius: 0.0,
                    offset: Offset(
                      0.0,
                      3.0,
                    ),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Html(
                data: '<p style="font-size:18px">' + contentDisplay + "</p>",
                onLinkTap: (String? url, RenderContext context,
                    Map<String, String> attributes, element) async {
                  final Uri _url = Uri.parse(url ?? "");
                  await launchUrl(_url);
                  //open URL in webview, or launch URL in browser, or any other logic here
                }),
          )),
    );
  }
}
