import 'package:flutter/material.dart';
import 'package:garage/constant/constant.dart';
import 'package:garage/constant/TextStyle/CustomText.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  WebViewPage({required this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Kcolor.bg)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Kcolor.bg),
        surfaceTintColor: Kcolor.primary,
        backgroundColor: Kcolor.secondary,
        title: Text('Garage Location',
            style: TextStyle(
              fontFamily: fontstyles.Head,
              fontSize: 30,
              color: Kcolor.bg,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(
              Uri.parse(widget.url),
            )),
    );
  }
}
// 'https://www.google.com/maps/search/?api=1&query=${_currentLocation.latitude},${_currentLocation.longitude}'
