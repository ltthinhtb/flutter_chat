import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:vn_dental/generated/l10n.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/themes/my_flutter_app_icons.dart';
import 'package:vn_dental/themes/sizes.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String tag;
  final String title;

  const FullScreenImage({Key key, this.imageUrl, this.tag, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: tag,
              child: PhotoView(
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 2,
                imageProvider: CachedNetworkImageProvider(imageUrl),
              ),
            ),
          ),
          Positioned(
            top: height(100),
            left: height(40),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: size(50),
                      color: white,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          Positioned(
            bottom: height(100),
            left: height(50),
            child: Column(
              children: [
                IconButton(
                  icon: Icon(MyFlutterApp.download),
                  onPressed: () async {
                    try {
                      // Saved with this method.
                      var dir = await getApplicationDocumentsDirectory();
                      String fullPath = "${dir.path}/$imageUrl";
                      await Dio().download(imageUrl, fullPath);
                    } on PlatformException catch (error) {
                      print(error);
                    }
                  },
                ),
                Text(
                  "Tải xuống",
                  style: TextStyle(
                      fontSize: size(50),
                      color: white,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          Positioned(
            bottom: height(100),
            right: height(50),
            child: Column(
              children: [
                IconButton(
                  icon: Icon(MdiIcons.pencil),
                  onPressed: () {},
                ),
                Text(
                  S.of(context).edit,
                  style: TextStyle(
                      fontSize: size(50),
                      color: white,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
