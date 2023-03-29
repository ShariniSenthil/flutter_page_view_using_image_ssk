import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_page_view_using_image_ssk/AppData.dart';
import 'package:flutter_page_view_using_image_ssk/display_images.dart';
import 'package:flutter_page_view_using_image_ssk/indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('James William'),
        backgroundColor: Colors.green.shade900,
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) =>
            [
              PopupMenuItem(value: 1, child: Text("Share")),
            ],
            elevation: 2,
            onSelected: (value) {
              if (value == 1) {
                _shareInfo();
              }
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 500.0,
            child: PageView.builder(
              // Selection - click listener
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                controller: PageController(viewportFraction: 20),
                itemCount: appDataList.length,
                itemBuilder: (context, index) {
                  var images = appDataList[index];
                  var _scale = _selectedIndex == index ? 1.0 : 0.8;
                  return TweenAnimationBuilder(
                      tween: Tween(begin: _scale, end: _scale),
                      duration: Duration(milliseconds: 350),
                      child: DisplayImage(
                        appData: images,
                      ),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                  appDataList.length,
                      (index) =>
                      Indicator(isActive: _selectedIndex == index ? true : false))
            ],

          )

        ],
      ),
    );
  }

  _shareInfo() async{
    print('------------> _shareInfo');

    print(appDataList[_selectedIndex].images);

    ByteData imagebyte = await rootBundle.load(appDataList[_selectedIndex].images);
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/jw_image_1.png';
    File(path).writeAsBytesSync(imagebyte.buffer.asUint8List());
    await Share.shareFiles([path], text: 'Image Shared');
  }
}


