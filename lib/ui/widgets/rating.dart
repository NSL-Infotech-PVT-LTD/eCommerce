import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget ratingstars({size, ittempading, color, double rating = 1.0}) {
  return RatingBar.builder(
    itemSize: size,
    initialRating: rating,
    ignoreGestures: true,
    minRating: 1,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    itemPadding: EdgeInsets.symmetric(horizontal: ittempading),
    itemBuilder: (context, _) => Icon(
      Icons.star,
      color: color,
    ),
    onRatingUpdate: (rating) {
      print(rating);
    },
  );
}
