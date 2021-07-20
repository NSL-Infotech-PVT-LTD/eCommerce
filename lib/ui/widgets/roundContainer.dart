import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget roundedBox({width, height, child, backgroundColor}) {
  return Container(
    width: width,
    height: height,
    child: child,
    decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(6))),
  );
}

Widget roundedBoxBorder(
    {context,
    width,
    height,
    child,
    backgroundColor,
    borderColor,
    borderSize,
    radius}) {
  var size = MediaQuery.of(context).size;
  return Container(
    width: width,
    height: height,
    child: child,
    decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor, //                   <--- border color
          width: borderSize,
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(radius != null ? radius : size.width * 0.01))),
  );
}

Widget roundedBoxR({width, height, child, backgroundColor, radius}) {
  return Container(
    width: width,
    height: height,
    child: child,
    decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(radius))),
  );
}
