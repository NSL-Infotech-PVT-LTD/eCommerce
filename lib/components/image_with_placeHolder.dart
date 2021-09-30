import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageShow {
  static network(
      {String url = "",
      double width = 100,
      double height = 100,
      String? placeHolderAssetImage,
      String? onErrorImagesAsset,
      Widget? child,
      BoxBorder? border,
      BorderRadiusGeometry? borderRadius,
      bool loaderEnable = true,
      Color loaderColor = Colors.grey}) {
    return Container(
      width: width,
      height: height,
      child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  border: border,
                  borderRadius: borderRadius,
                  image: DecorationImage(
                    image: imageProvider,

                    fit: BoxFit.cover,

                    // colorFilter:
                    //     ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                  ),
                ),
                child: child,
              ),
          placeholder: (context, url) => loaderEnable
              ? Center(
                  child: CircularProgressIndicator(
                  color: loaderColor,
                ))
              : Container(
                  decoration: BoxDecoration(
                    border: border,
                    borderRadius: borderRadius,
                    image: DecorationImage(
                      image: AssetImage("$placeHolderAssetImage"),

                      fit: BoxFit.cover,

                      // colorFilter:
                      //     ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                    ),
                  ),
                  child: child,
                ),
          errorWidget: (context, url, error) => onErrorImagesAsset != null
              ? Container(
                  decoration: BoxDecoration(
                    border: border,
                    borderRadius: borderRadius,
                    image: DecorationImage(
                      image: AssetImage("$placeHolderAssetImage"),

                      fit: BoxFit.cover,

                      // colorFilter:
                      //     ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                    ),
                  ),
                  child: child,
                )
              : Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.grey,
                  ),
                )),
    );
  }
}
