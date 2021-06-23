import 'package:flutter/cupertino.dart';

Widget roundedBox({width, height, child, backgroundColor}){

  return Container(

    width: width,
    height: height,
    
    child: child,

    decoration: BoxDecoration(
      color: backgroundColor,
borderRadius: BorderRadius.all(

    		Radius.circular(6)
    	)

      
     ),
  );
}