import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vn_dental/themes/colors.dart';
import 'package:vn_dental/utils/utils.dart';


class CustomCircleImage extends StatelessWidget {
  final String urlImage;
  final placeHolder;
  final VoidCallback onTapImage;

  const CustomCircleImage(
      {Key key,
      @required this.urlImage,
      this.placeHolder = Icons.error,
      this.onTapImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapImage == null ? null : () => onTapImage(),
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: Utils.isEmpty(urlImage) ? "" : urlImage,

//        fit: BoxFit.cover,
//        imageUrl: Utils.isEmpty(urlImage) ? "" : (Const.HOST_URL + urlImage),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) =>
            LayoutBuilder(builder: (context, constraint) {
          if (placeHolder is IconData) {
            return Container(
//              margin: EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: grey, width: 0.5),
                borderRadius: BorderRadius.all(
                    Radius.circular(MediaQuery.of(context).size.width / 2)),
              ),
              child: CircleAvatar(
                  child: Icon(
                placeHolder,
                size: constraint.biggest.height,
                color: grey,
              )),
            );
          } else
            return Container(
//              margin: EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    placeHolder,
                  ),
//                  colorFilter: ColorFilter.mode(blueGrey, BlendMode.color),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: grey, width: 0.5),
                borderRadius: BorderRadius.all(
                    Radius.circular(MediaQuery.of(context).size.width / 2)),
              ),
            );
        }),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            border: Border.all(color: grey, width: 0.5),
            borderRadius: BorderRadius.all(
                Radius.circular(MediaQuery.of(context).size.width / 2)),
//            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
