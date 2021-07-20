import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/strings.dart';

class SizeConfig {
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;
  static MediaQueryData? _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static var size;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical =
        _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    size = MediaQuery.of(context).size;
  }
}

var imageCircule = "";

Widget circleImageSha() {
  if (imageCircule == null || imageCircule == "") {
    return SvgPicture.asset(Images.assetsSvgIcons + 'place_holder.svg');
  } else {
    //    setString(userImage, pickedFile);
    // print(forImage + pickedFile);
    return CircleAvatar(
      radius: 52.0,
      backgroundImage: NetworkImage(imageCircule),
      backgroundColor: Colors.transparent,
    );
  }
  //  else {
  //   return ClipOval(child:  NetworkImage(image));
  // }
}
