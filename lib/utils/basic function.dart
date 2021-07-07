import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/utils/colors.dart';

class SlidingBannerProviderDetails extends StatelessWidget {
  final image;
  const SlidingBannerProviderDetails({this.image});

  @override
  Widget build(BuildContext context) {
    // print("fjd $image");
    return  Container(
      child: FadeInImage(
        width: SizeConfig.screenWidth,
        placeholder: AssetImage("assets/images/user.png"),
        image: NetworkImage(image.toString()),
      ),
    );
  }
}

class TicketFun extends StatefulWidget {

  @override
  _TicketFunState createState() => _TicketFunState();
}

class _TicketFunState extends State<TicketFun> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:   Container(
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            //  SizedBox(height: SizeConfig.screenHeight * 0.02,),
            Stack(children: [
              SizedBox(
                  width: SizeConfig.screenWidth,
                  child: SvgPicture.asset("assets/images/Rectangle84.svg",fit: BoxFit.fill,)),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Container(
                  height: SizeConfig.screenHeight * 0.10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:

                    Row(
                      children: [
                        SvgPicture.asset("assets/images/ticket.svg"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: SizeConfig.screenWidth * 0.50,
                                child: Flexible(
                                  child: Text(
                                    "Tickdfgsdfgsdfgdfget",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: "DM Sans Bold",
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth * 0.50,
                                child: Flexible(
                                  child: Text(
                                    "You will enjoy an entranceentranceentranceentranceentranceentranceentranceentranceentranceentrance",
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: AppColors.brownlite,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Text(
                              "€ 12.29",
                              style: TextStyle(
                                  color: AppColors.white, fontSize: 20,fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.01,),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.homeBackground,
                                    border: Border.all(color: AppColors.white),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                  ),
                                  height: SizeConfig.screenHeight * 0.03,
                                  width: SizeConfig.screenWidth * 0.08,
                                  child: Center(
                                      child: Text(
                                        "-",
                                        style: TextStyle(
                                          fontFamily: "DM Sans Medium",
                                          fontSize: 12,
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  width: SizeConfig.screenWidth * 0.03,
                                ),
                                Text("0"),
                                SizedBox(
                                  width: SizeConfig.screenWidth * 0.03,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.skin,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                  ),
                                  height: SizeConfig.screenHeight * 0.03,
                                  width: SizeConfig.screenWidth * 0.08,
                                  child: Center(
                                      child: Text(
                                        "+",
                                        style: TextStyle(
                                            fontFamily: "DM Sans Medium",
                                            fontSize: 12,
                                            color: AppColors.homeBackground
                                        ),
                                      )),
                                ),
                              ],
                            )

                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

            ],),
            SizedBox(height: SizeConfig.screenHeight * 0.02,),
          ],

        ),
      ),
    );
  }
}

