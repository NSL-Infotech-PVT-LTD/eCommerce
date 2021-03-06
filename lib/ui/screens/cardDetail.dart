import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:funfy/apis/bookingApi.dart';
import 'package:funfy/apis/userdataM.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/components/swipeButtons.dart';
import 'package:funfy/models/cardListmodel.dart';
import 'package:funfy/ui/screens/bookingSuccess.dart';
import 'package:funfy/ui/screens/stripe/input_formatters.dart';
import 'package:funfy/ui/screens/stripe/payment_card.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/imagesIcons.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:stripe_payment/stripe_payment.dart';

class CartDetail extends StatefulWidget {
  final fiestasId;

  const CartDetail({Key? key, this.fiestasId}) : super(key: key);

  @override
  _CartDetailState createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> {
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController expireDateController = TextEditingController();
  TextEditingController securityController = TextEditingController();
  var _paymentCard = PaymentCard();
  var _card = new PaymentCard();
  var _formKey = new GlobalKey<FormState>();
  var _autoValidateMode = AutovalidateMode.disabled;
  CardListModel? cardList;

  bool _loading = false;
  bool _swipeTrue = false;

  int? groupValue = -1;
  int? initvalue = 0;

  int tottalAmount = 0;

  String cardId = "";

  bool cardFormShow = true;

  bool payLoading = false;

  bool addCardLoading = false;

  bool swipebuttonShowBool = false;

  // card detail
  CreditCard? testCard;

  _handleRadioValueChange(int? value) {
    setState(() {
      groupValue = value;
    });
  }

  clearCardDetail() {
    setState(() {
      cardHolderNameController.clear();
      cardNumberController.clear();
      expireDateController.clear();
      securityController.clear();
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    cardNumberController.removeListener(_getCardTypeFrmNumber);
    cardNumberController.dispose();
    super.dispose();
  }

  void _validateInputs() {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      setState(() {
        _autoValidateMode =
            AutovalidateMode.always; // Start validating on every change.
      });
      // _showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();

      FocusScope.of(context).unfocus();
      print("Payment card is valid");

      String cardNumber = cardNumberController.text.split(" ").join();

      var expiredate = expireDateController.text.split("/");

      int month = int.parse("${expiredate[0]}");

      int year = int.parse("${expiredate[1]}");

      CreditCard cardDetail = CreditCard(
          name: cardHolderNameController.text,
          number: cardNumber,
          expMonth: month,
          expYear: year,
          cvc: securityController.text);
      setState(() {
        addCardLoading = true;
      });
      paymentWithcardDetail(cardDetail);
    }
  }

  // payment func

  paymentWithcardDetail(CreditCard cardDetail) {
    print("Start payment Cart Detail : $cardDetail");
    StripePayment.createTokenWithCard(
      cardDetail,
    ).then((token) {
      print("payment token ");

      print(token.tokenId);
      // _scaffoldKey.currentState
      //     ?.showSnackBar(SnackBar(content: Text('Received ${token.tokenId}')));
      // setState(() {
      //   _paymentToken = token;
      // });

      addCard(cardToken: token.tokenId);
    }).catchError((setError) {
      print("Here is Error $setError");
    });
  }

  // total amount

  totalAmount() {
    print("running........... ");
    int tot = 0;

    for (var i in UserData.ticketcartMap.values) {
      int price = int.parse("${i['ticketPrice']}");
      // int.parse("${i['ticketCount']}") * int.parse("${i['ticketPrice']}");

      print(i);

      tot = tot + price;
    }

    setState(() {
      tottalAmount = tot;
    });
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(cardNumberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      this._paymentCard.type = cardType;
    });
  }

  // addCard api

  addCard({String? cardToken}) {
    try {
      storePaymentCard(cardToken: cardToken ?? "").then((value) {
        setState(() {
          addCardLoading = false;
          cardHolderNameController.clear();
          cardNumberController.clear();
          monthController.clear();
          expireDateController.clear();
          securityController.clear();
          getCardListApi();
        });

        print("here is value");

        print(value);
      });
    } catch (e) {
      setState(() {
        addCardLoading = false;
      });

      print("error in add card api $e");
    }
  }

  // delete api

  deleteCardApi({String? cardIdd}) {
    setState(() {
      _loading = true;
    });
    try {
      deleteCard(cardIds: cardIdd).then((value) {
        setState(() {
          _loading = false;
          clearCardDetail();

          getCardListApi();

          // cardId = value["data"]["data"]["id"];

          // cardFormShow = false;

          // fiestasBookingApi(cardid: cardId);
        });

        print("here is value");

        print(value);
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });

      print("error in add card api $e");
    }
  }

  // get card list api

  getCardListApi() {
    setState(() {
      _loading = true;
    });
    try {
      getCardList().then((value) {
        setState(() {
          _loading = false;

          cardList = value;

          if (value != null && value.data?.data?.length != 0) {
            cardFormShow = false;
          }
        });
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });

      print("error in add card api $e");
    }
  }

  @override
  void initState() {
    // get card list

    getCardListApi();
    totalAmount();
    StripePayment.setOptions(StripeOptions(
        publishableKey: Strings.publishKey,
        androidPayMode: Strings.androidPayMode));
    super.initState();
    _paymentCard.type = CardType.Others;
    cardNumberController.addListener(_getCardTypeFrmNumber);
  }

  // booking api call

  fiestasBookingApi({String? cardid}) async {
    setState(() {
      payLoading = true;
      swipebuttonShowBool = false;
    });
    var net = await Internetcheck.check();
    try {
      if (net != true) {
        Internetcheck.showdialog(context: context);
      } else {
        // filter cart value
        String ticket = "";
        String standard = "";
        String vip = "";

        UserData.ticketcartMap.forEach((key, value) {
          if (value["ticketname"] == "Ticket") {
            ticket = value["ticketCount"].toString();
          }
          if (value["ticketname"] == "Standard") {
            standard = value["ticketCount"].toString();
          }

          if (value["ticketname"] == "VIP Table") {
            vip = value["ticketCount"].toString();
          }
        });

        await fiestasBooking(
            id: widget.fiestasId.toString(),
            ticketcount: ticket,
            standardticketcount: standard,
            vipticketcount: vip,
            cardId: cardid,
            context: context)
            .then((res) {
          setState(() {
            payLoading = false;
          });

          if (res["status"] == true && res["code"] == 201) {
            setState(() {
              UserData.ticketcartMap.clear();
              UserData.totalTicketNum = 0;
            });
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => BookingSuccess(
                      orderidFiestas: [res["data"]["booking"]["id"], 0],
                    )),
                    (route) => false);
          } else {
            setState(() {
              payLoading = false;
              swipebuttonShowBool = true;
            });
            Dialogs.simpleOkAlertDialog(
                context: context,
                title: "${getTranslated(context, "alert!")}",
                content: "${getTranslated(context, 'paymentisFailed')}",
                // content: "${res['error']}",
                func: () {
                  navigatePopFun(context);
                });
          }
        });
      }
    } catch (e) {
      setState(() {
        payLoading = false;
      });

      print("Error in book fiestas-------------$e");
    }
  }

  Future<bool> backPress() async {
    if (_loading == true || payLoading == true) {
      Dialogs.showBasicsFlash(
          context: context,
          content:
          "${getTranslated(context, "Pleasewaittransactionisinprogress")}",
          color: AppColors.siginbackgrond,
          duration: Duration(seconds: 2));
    } else {
      Navigator.of(context).pop();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: HexColor("#3d322a"),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: backPress,
          child: Scaffold(
            floatingActionButton: cardFormShow == false
                ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  cardFormShow = true;
                });
              },
              child: Icon(Icons.add),
            )
                : SizedBox(),
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    backPress();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              automaticallyImplyLeading: false,
              title: Text("Pay"),
              centerTitle: true,
              backgroundColor: AppColors.blackBackground,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: size.height,
                    width: size.width,
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                        vertical: size.height * 0.02),
                    decoration: BoxDecoration(
                      color: AppColors.homeBackgroundLite,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          HexColor("#3d322a"),
                          HexColor("#1a1613")
                        ],
                        tileMode: TileMode.repeated,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // top content
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svgicons/cartsvg.svg",
                                width: size.width * 0.07,
                              ),
                              SizedBox(
                                // width: SizeConfig.screenWidth * 0.03,
                                width: size.width * 0.03,
                              ),
                              Text(
                                "${getTranslated(context, "yourCart")}",
                                style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    fontFamily: Fonts.dmSansMedium,
                                    color: AppColors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          roundedBoxR(
                            radius: size.width * 0.02,
                            // height: size.height * 0.08,
                            backgroundColor: HexColor("#6b604d"),
                            child: Container(
                              // alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02,
                                  vertical: size.height * 0.01),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                //  mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/ticket.svg",
                                      ),
                                      SizedBox(
                                        // width: SizeConfig.screenWidth * 0.03,
                                        width: size.width * 0.03,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${getTranslated(context, "Ticket")}",
                                              style: TextStyle(
                                                  fontSize: size.width * 0.05,
                                                  fontFamily:
                                                  Fonts.dmSansMedium,
                                                  color: AppColors.white)),
                                          SizedBox(
                                            height: size.height * 0.004,
                                          ),
                                          Text(
                                              "${getTranslated(context, "Qty")} : ${UserData.totalTicketNum}",
                                              style: TextStyle(
                                                  fontSize: size.width * 0.035,
                                                  fontFamily:
                                                  Fonts.dmSansMedium,
                                                  color: AppColors.white)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${Strings.euro} $tottalAmount",
                                          style: TextStyle(
                                              fontSize: size.width * 0.07,
                                              fontFamily: Fonts.dmSansMedium,
                                              color: AppColors.white)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: size.height * 0.05,
                          ),

                          //center content

                          // Card lsit

                          _loading
                              ? Container(
                            margin:
                            EdgeInsets.only(top: size.height * 0.24),
                            child: Center(
                                child: CircularProgressIndicator()),
                          )
                              : cardList != null && cardFormShow == false
                              ? Column(
                            children: [
                              Column(
                                children: [
                                  for (int i = 0;
                                  i <
                                      int.parse(
                                          "${cardList?.data?.data?.length}");
                                  i++)
                                    ticket(
                                        context: context,
                                        model:
                                        cardList?.data?.data![i],
                                        index: i)
                                ],
                              ),
                              groupValue != -1 &&
                                  swipebuttonShowBool &&
                                  int.parse(
                                      "${cardList?.data?.data?.length}") >
                                      0
                                  ?

                              // swipe to pay

                              ConfirmationSlider(
                                  width: size.width * 0.9,
                                  backgroundColor:
                                  AppColors.siginbackgrond,
                                  height: size.height * 0.07,
                                  backgroundColorEnd:
                                  Colors.red.shade700,
                                  text:
                                  "${getTranslated(context, "swipetopay")}",
                                  backgroundShape:
                                  BorderRadius.circular(8),
                                  foregroundShape:
                                  BorderRadius.circular(8),
                                  foregroundColor:
                                  HexColor('#9f150d'),
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.bold),
                                  onConfirmation: () {
                                    print("Swiped.......");
                                    fiestasBookingApi(
                                        cardid: cardId);
                                  })

                              //  SwipeButton(
                              //     thumb: SvgPicture.asset(
                              //       Images.swipeButtonSvg,
                              //       fit: BoxFit.cover,
                              //     ),
                              //     borderRadius:
                              //         BorderRadius.circular(8),
                              //     activeTrackColor:
                              //         AppColors.siginbackgrond,
                              //     height: size.height * 0.07,
                              //     elevation: 10,
                              //     child: Text(
                              //         "${getTranslated(context, "swipetopay")}",
                              //         style: TextStyle(
                              //             color: AppColors.white,
                              //             fontFamily:
                              //                 Fonts.dmSansBold,
                              //             fontSize:
                              //                 size.width * 0.05)),
                              //     onSwipeEnd: () {
                              //       print("Swipe.........");
                              //       fiestasBookingApi(
                              //           cardid: cardId);
                              //     },
                              //   )
                                  : payLoading &&
                                  swipebuttonShowBool == false
                                  ? roundedBoxR(
                                radius: size.width * 0.02,
                                width: size.width,
                                height: size.height * 0.07,
                                backgroundColor: AppColors
                                    .siginbackgrond,
                                child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: [
                                        SizedBox(
                                          // height:
                                          //     size.height * 0.03,
                                          // width:
                                          //     size.width * 0.06,
                                          height: 20,
                                          width: 20,
                                          child:
                                          CircularProgressIndicator(
                                              color: AppColors
                                                  .white),
                                        ),
                                        SizedBox(
                                            width: size.width *
                                                0.02),
                                        Text(
                                          "${getTranslated(context, "pleaseWait")}",
                                          style: TextStyle(
                                              fontSize:
                                              size.width *
                                                  0.045,
                                              fontFamily: Fonts
                                                  .dmSansMedium,
                                              color: AppColors
                                                  .white),
                                        ),
                                      ],
                                    )),
                              )
                                  : SizedBox()
                            ],
                          )

                          // card form
                              : Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${getTranslated(context, "Payment")}",
                                style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    fontFamily: Fonts.dmSansMedium,
                                    color: AppColors.white),
                              ),

                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              roundedBoxR(
                                  radius: size.width * 0.02,
                                  // height: size.height * 0.4,
                                  width: size.width,
                                  backgroundColor:
                                  HexColor("#191512"),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.height * 0.02,
                                        horizontal:
                                        size.width * 0.04),
                                    child: Form(
                                      key: _formKey,
                                      autovalidateMode:
                                      _autoValidateMode,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                child: CardUtils
                                                    .getCardIcon(
                                                    _paymentCard
                                                        .type),
                                              ),
                                              // SvgPicture.asset(
                                              //   "assets/images/ticket.svg",
                                              //   width: size.width * 0.05,
                                              // ),
                                              SizedBox(
                                                width:
                                                size.width * 0.02,
                                              ),
                                              Text(
                                                "${getTranslated(context, "addCreditDebitCard")}",
                                                style: TextStyle(
                                                    fontSize:
                                                    size.width *
                                                        0.045,
                                                    fontFamily: Fonts
                                                        .dmSansMedium,
                                                    color: AppColors
                                                        .white),
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                            height:
                                            size.height * 0.03,
                                          ),

                                          // input

                                          cardHolderField(
                                              hint:
                                              "${getTranslated(context, 'cardHoldername')}",
                                              controller:
                                              cardHolderNameController),

                                          SizedBox(
                                            height:
                                            size.height * 0.015,
                                          ),

                                          cardNumerField(
                                              hint:
                                              "${getTranslated(context, 'cardNumber')}",
                                              controller:
                                              cardNumberController),

                                          SizedBox(
                                            height:
                                            size.height * 0.03,
                                          ),

                                          //

                                          Text(
                                            "${getTranslated(context, "expireDate")}",
                                            style: TextStyle(
                                                fontSize: size.width *
                                                    0.045,
                                                fontFamily: Fonts
                                                    .dmSansMedium,
                                                color:
                                                AppColors.white),
                                          ),

                                          SizedBox(
                                            height:
                                            size.height * 0.015,
                                          ),

                                          yearField(
                                              hint: "MM/YY",
                                              controller:
                                              expireDateController),

                                          SizedBox(
                                            height:
                                            size.height * 0.015,
                                          ),

                                          Row(
                                            children: [
                                              Expanded(
                                                child: securityField(
                                                    hint:
                                                    "Security Code",
                                                    controller:
                                                    securityController),
                                              ),
                                              SizedBox(
                                                  width: size.width *
                                                      0.03),
                                              Expanded(
                                                child: Container(),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),

                              SizedBox(
                                height: size.height * 0.03,
                              ),

                              // pay button

                              InkWell(
                                onTap: () {
                                  _validateInputs();
                                },
                                child: roundedBoxR(
                                  radius: size.width * 0.02,
                                  width: size.width,
                                  height: size.height * 0.07,
                                  backgroundColor:
                                  AppColors.siginbackgrond,
                                  child: Center(
                                    child: addCardLoading
                                        ? Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: [
                                        SizedBox(
                                          height: size.height *
                                              0.03,
                                          width:
                                          size.width * 0.06,
                                          child:
                                          CircularProgressIndicator(
                                              color: AppColors
                                                  .white),
                                        ),
                                        SizedBox(
                                            width: size.width *
                                                0.02),
                                        Text(
                                          "${getTranslated(context, "pleaseWait")}",
                                          style: TextStyle(
                                              fontSize:
                                              size.width *
                                                  0.045,
                                              fontFamily: Fonts
                                                  .dmSansMedium,
                                              color: AppColors
                                                  .white),
                                        ),
                                      ],
                                    )
                                        : Text(
                                      "${getTranslated(context, "continue")}",
                                      style: TextStyle(
                                          fontSize: size.width *
                                              0.045,
                                          fontFamily: Fonts
                                              .dmSansMedium,
                                          color:
                                          AppColors.white),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: size.height * 0.015,
                              ),

                              // view card button

                              cardList != null &&
                                  cardList?.data?.data?.length !=
                                      0
                                  ? InkWell(
                                onTap: () {
                                  setState(() {
                                    cardFormShow = false;
                                  });
                                },
                                child: roundedBoxR(
                                  radius: size.width * 0.02,
                                  width: size.width,
                                  height: size.height * 0.07,
                                  backgroundColor:
                                  HexColor("#6b604d"),
                                  child: Center(
                                    child: _loading
                                        ? CircularProgressIndicator()
                                        : Text(
                                      "${getTranslated(context, "viewYourCard")}",
                                      style: TextStyle(
                                          fontSize:
                                          size.width *
                                              0.045,
                                          fontFamily: Fonts
                                              .dmSansMedium,
                                          color: AppColors
                                              .white),
                                    ),
                                  ),
                                ),
                              )
                                  : SizedBox()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // card holder name

  Widget cardHolderField({String? hint, String? error, controller}) {
    return TextFormField(
      style: TextStyle(color: AppColors.white),
      cursorColor: AppColors.white,
      controller: controller,
      onSaved: (String? value) {
        _card.name = value;
      },
      keyboardType: TextInputType.text,
      validator: (String? value) => value!.isEmpty
          ? Strings.fieldReq
          : !RegExp('[a-zA-Z]').hasMatch(value)
              ? '${getTranslated(context, 'pleaseEnterValidName')}'
              : null,
      decoration: InputDecoration(
          fillColor: HexColor("#3e332b"),
          filled: true,
          errorText: error,
          border: InputBorder.none,
          hintStyle: TextStyle(color: HexColor("#6c604e")),
          hintText: "$hint"),
    );
  }

  // card number

  Widget cardNumerField({String? hint, String? error, controller}) {
    return TextFormField(
      style: TextStyle(color: AppColors.white),
      cursorColor: AppColors.white,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        new LengthLimitingTextInputFormatter(16),
        new CardNumberInputFormatter()
      ],
      onSaved: (String? value) {
        _paymentCard.number = CardUtils.getCleanedNumber(value!);
      },
      validator: CardUtils.validateCardNum,
      decoration: InputDecoration(
          fillColor: HexColor("#3e332b"),
          filled: true,
          errorText: error,
          border: InputBorder.none,
          hintStyle: TextStyle(color: HexColor("#6c604e")),
          hintText: "$hint"),
    );
  }

  // month

  Widget monthField({String? hint, String? error, controller}) {
    return TextFormField(
      style: TextStyle(color: AppColors.white),
      cursorColor: AppColors.white,
      controller: controller,
      keyboardType: TextInputType.number,
      // inputFormatters: [
      //   FilteringTextInputFormatter.digitsOnly,
      //   new LengthLimitingTextInputFormatter(19),
      //   new CardNumberInputFormatter()
      // ],
      // onSaved: (String? value) {
      //   _paymentCard.number = CardUtils.getCleanedNumber(value!);
      // },
      // validator: CardUtils.validateCardNum,
      decoration: InputDecoration(
          fillColor: HexColor("#3e332b"),
          filled: true,
          errorText: error,
          border: InputBorder.none,
          hintStyle: TextStyle(color: HexColor("#6c604e")),
          hintText: "$hint"),
    );
  }

  // year number

  Widget yearField({String? hint, String? error, controller}) {
    return TextFormField(
      style: TextStyle(color: AppColors.white),
      cursorColor: AppColors.white,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        new LengthLimitingTextInputFormatter(4),
        new CardMonthInputFormatter()
      ],
      validator: CardUtils.validateDate,
      onSaved: (value) {
        List<int> expiryDate = CardUtils.getExpiryDate(value!);
        _paymentCard.month = expiryDate[0];
        _paymentCard.year = expiryDate[1];
      },
      decoration: InputDecoration(
          fillColor: HexColor("#3e332b"),
          filled: true,
          errorText: error,
          border: InputBorder.none,
          hintStyle: TextStyle(color: HexColor("#6c604e")),
          hintText: "$hint"),
    );
  }

  // security number

  Widget securityField({String? hint, String? error, controller}) {
    return TextFormField(
      style: TextStyle(color: AppColors.white),
      cursorColor: AppColors.white,
      obscureText: true,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        new LengthLimitingTextInputFormatter(4),
      ],
      validator: CardUtils.validateCVV,
      onSaved: (value) {
        _paymentCard.cvv = int.parse(value!);
      },
      decoration: InputDecoration(
          fillColor: HexColor("#3e332b"),
          filled: true,
          errorText: error,
          border: InputBorder.none,
          hintStyle: TextStyle(color: HexColor("#6c604e")),
          hintText: "$hint"),
    );
  }

  // card list item

  Widget ticket({context, int? index, Datum? model}) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.only(top: size.height * 0.01),
      child: Column(
        children: [
          //  SizedBox(height: SizeConfig.screenHeight * 0.02,),
          Stack(
            children: [
              SizedBox(
                  width: SizeConfig.screenWidth,
                  child: SvgPicture.asset(
                    "assets/images/Rectangle84.svg",
                    fit: BoxFit.fill,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: SizeConfig.screenHeight * 0.13,
                  child: Padding(
                    // padding: const EdgeInsets.all(8.0),
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                        vertical: size.height * 0.001),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: CardUtils.getCardIcon(
                              CardUtils.getCardTypeUSingString(
                                  "${model?.brand ?? ""}")),
                        ),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: SizeConfig.screenWidth * 0.40,
                              child: Text(
                                "${model?.name ?? 'No name found'}",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 14,
                                  fontFamily: "DM Sans Bold",
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.40,
                              child: Text(
                                "**** **** **** ${model?.last4}",
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: AppColors.brownlite, fontSize: 14),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.40,
                              child: Text(
                                "Expire on : ${model?.expMonth ?? '--'}/${model?.expYear ?? '--'}",
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: AppColors.brownlite, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: AppColors.white,
                              ),
                              child: Radio<int?>(
                                  value: index,
                                  groupValue: groupValue,
                                  //count == 1 && groupValue != -1 ? count : groupValue,
                                  onChanged: (_v) {
                                    _handleRadioValueChange(index);

                                    setState(() {
                                      cardId = model?.id ?? "";

                                      swipebuttonShowBool = true;

                                      print(" here is card id : $cardId");

                                      // fiestasBookingApi(cardid: model?.id ?? "");
                                    });
                                  }),
                            ),
                            IconButton(
                              onPressed: () {
                                Dialogs.simpleAlertDialog(
                                    context: context,
                                    title:
                                    "${getTranslated(context, "delete")}",
                                    content:
                                    "${getTranslated(context, "Doyouwanttodeletethecard")}",
                                    func: () {
                                      navigatePopFun(context);
                                      deleteCardApi(cardIdd: model?.id ?? "");
                                    });
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
