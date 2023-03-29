import 'package:flutter/cupertino.dart';
import 'package:flutter_page_view_using_image_ssk/AppData.dart';

class DisplayImage extends StatelessWidget {
  final AppData appData;

  const DisplayImage({Key? key, required this.appData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          image: AssetImage(appData.images),
          //fit: BoxFit.cover
        ),
      ),
    );
  }
}
