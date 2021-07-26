// import 'package:flutter/material.dart';
// import 'package:funfy/components/navigation.dart';
// import 'package:funfy/components/shortPrices.dart';
// import 'package:funfy/ui/screens/bookNowBeta.dart';
// import 'package:funfy/ui/widgets/rating.dart';
// import 'package:funfy/ui/widgets/roundContainer.dart';
// import 'package:funfy/utils/colors.dart';
// import 'package:funfy/utils/fontsname.dart';
// import 'package:funfy/utils/strings.dart';
// import 'package:intl/intl.dart';

// Widget fiestasItem({context, Datum? postModeldata}) {
//   var size = MediaQuery.of(context).size;

//   DateTime? date = DateTime.parse("${postModeldata?.timestamp}");

//   String month = DateFormat('MMM').format(date);

//   String price = k_m_b_generator(int.parse("${postModeldata?.ticketPrice}"));

//   return Container(
//     margin: EdgeInsets.only(top: size.width * 0.04),
//     width: size.width,
//     height: size.height * 0.28,
//     decoration: BoxDecoration(
//         image: DecorationImage(
//             image: NetworkImage("${postModeldata?.image}"), fit: BoxFit.cover)),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//             padding: EdgeInsets.symmetric(vertical: size.height * 0.0035),
//             color: AppColors.homeBackground.withOpacity(0.4),
//             width: size.width * 0.1,
//             height: size.height * 0.055,
//             child: Container(
//               height: size.height * 0.047,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       "${date.day}",
//                       style: TextStyle(
//                           fontSize: size.width * 0.043,
//                           fontFamily: Fonts.dmSansBold,
//                           color: AppColors.white),
//                     ),
//                   ),
//                   Text(
//                     "${month.toUpperCase()}",
//                     style: TextStyle(
//                         fontSize: size.width * 0.027,
//                         fontFamily: Fonts.dmSansMedium,
//                         color: AppColors.white),
//                   ),
//                 ],
//               ),
//             )),
//         Container(
//           padding: EdgeInsets.symmetric(
//               horizontal: size.width * 0.03, vertical: size.height * 0.01),
//           height: size.height * 0.15,
//           decoration: BoxDecoration(
//               color: AppColors.homeBackground,
//               border: Border(
//                 left: BorderSide(
//                     width: size.height * 0.001, color: AppColors.tagBorder),
//                 right: BorderSide(
//                     width: size.height * 0.001, color: AppColors.tagBorder),
//                 bottom: BorderSide(
//                     width: size.height * 0.001, color: AppColors.tagBorder),
//               )),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "${postModeldata?.name}",
//                     style: TextStyle(
//                         fontSize: size.width * 0.045,
//                         fontFamily: Fonts.dmSansBold,
//                         color: AppColors.white),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.004,
//                   ),
//                   Text(
//                     "${postModeldata?.distanceMiles}",
//                     style: TextStyle(
//                         fontSize: size.width * 0.03,
//                         fontFamily: Fonts.dmSansMedium,
//                         color: AppColors.white),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.005,
//                   ),
//                   Container(
//                       // width: size.width * 0.3,
//                       child: ratingstars(
//                           size: size.width * 0.05,
//                           ittempading: size.width * 0.0001,
//                           color: AppColors.tagBorder,
//                           rating: 4))
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     Strings.startingfrom,
//                     style: TextStyle(
//                         fontSize: size.width * 0.025,
//                         fontFamily: Fonts.dmSansMedium,
//                         color: AppColors.white),
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         Strings.euro,
//                         style: TextStyle(
//                             fontSize: size.width * 0.04,
//                             fontFamily: Fonts.dmSansBold,
//                             color: AppColors.white),
//                       ),
//                       Text(
//                         // postModeldata!.ticketPrice!.length > 9
//                         //     ? "${postModeldata.ticketPrice?.substring(0, 9)}"
//                         //     : "${postModeldata.ticketPrice}",
//                         "$price",
//                         maxLines: 1,
//                         overflow: TextOverflow.clip,
//                         style: TextStyle(
//                             fontSize: size.width * 0.068,
//                             fontFamily: Fonts.dmSansBold,
//                             color: AppColors.white),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: size.height * 0.01,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       navigatorPushFun(
//                           context, BookNowBeta(fiestasModel: postModeldata));
//                     },
//                     child: roundedBoxR(
//                         width: size.width * 0.23,
//                         height: size.height * 0.033,
//                         radius: 3.0,
//                         backgroundColor: AppColors.siginbackgrond,
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: Text(
//                             Strings.booknow,
//                             style: TextStyle(
//                                 fontSize: size.width * 0.03,
//                                 fontFamily: Fonts.dmSansBold,
//                                 color: AppColors.white),
//                           ),
//                         )),
//                   )
//                 ],
//               )
//             ],
//           ),
//         )
//       ],
//     ),
//   );
// }