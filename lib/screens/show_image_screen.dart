import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ShowImageScreen extends StatefulWidget {
  static final String routeName = "route name";

  @override
  _ShowImageScreenState createState() => _ShowImageScreenState();
}

class _ShowImageScreenState extends State<ShowImageScreen> {
  String image;
  didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    print(routeArgs["image"]);
    image = routeArgs['image'];
    
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: PhotoView(
          imageProvider: NetworkImage(image),
        ),
      ),
    );
  }
}
