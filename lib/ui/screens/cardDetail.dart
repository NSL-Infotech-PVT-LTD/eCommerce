import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy/ui/screens/stripe/input_formatters.dart';
import 'package:funfy/ui/screens/stripe/payment_card.dart';
import 'package:funfy/ui/widgets/roundContainer.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/fontsname.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:funfy/utils/strings.dart';
import 'package:hexcolor/hexcolor.dart';

class CartDetail extends StatefulWidget {
  const CartDetail({Key? key}) : super(key: key);

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

      print(
          "Card value  name : ${cardHolderNameController.text}, number : ${cardNumberController.text} expire date : ${expireDateController.text} ccv : ${securityController.text}");
      // Encrypt and send send payment details to payment gateway
      // _showInSnackBar('Payment card is valid');
    }
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(cardNumberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      this._paymentCard.type = cardType;
    });
  }

  @override
  void initState() {
    super.initState();
    _paymentCard.type = CardType.Others;
    cardNumberController.addListener(_getCardTypeFrmNumber);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: HexColor("#3d322a"),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Pay"),
            centerTitle: true,
            backgroundColor: AppColors.blackBackground,
          ),
          body: Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: size.height * 0.02),
            decoration: BoxDecoration(
              color: AppColors.homeBackgroundLite,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[HexColor("#3d322a"), HexColor("#1a1613")],
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("${getTranslated(context, "Ticket")}",
                                      style: TextStyle(
                                          fontSize: size.width * 0.05,
                                          fontFamily: Fonts.dmSansMedium,
                                          color: AppColors.white)),
                                  SizedBox(
                                    height: size.height * 0.004,
                                  ),
                                  Text("${getTranslated(context, "Qty")} : 2",
                                      style: TextStyle(
                                          fontSize: size.width * 0.035,
                                          fontFamily: Fonts.dmSansMedium,
                                          color: AppColors.white)),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${Strings.euro} 25.99",
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
                      backgroundColor: HexColor("#191512"),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.02,
                            horizontal: size.width * 0.04),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: _autoValidateMode,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    child: CardUtils.getCardIcon(
                                        _paymentCard.type),
                                  ),
                                  // SvgPicture.asset(
                                  //   "assets/images/ticket.svg",
                                  //   width: size.width * 0.05,
                                  // ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Text(
                                    // "Agregar tarjeta de crédito / débito",
                                    "${getTranslated(context, "addCreditDebitCard")}",
                                    style: TextStyle(
                                        fontSize: size.width * 0.045,
                                        fontFamily: Fonts.dmSansMedium,
                                        color: AppColors.white),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: size.height * 0.03,
                              ),

                              // input

                              cardHolderField(
                                  hint: "Card Holder's Name",
                                  controller: cardHolderNameController),

                              SizedBox(
                                height: size.height * 0.015,
                              ),

                              cardNumerField(
                                  hint: "Card Number",
                                  controller: cardNumberController),

                              SizedBox(
                                height: size.height * 0.03,
                              ),

                              //

                              Text(
                                "Expire Date",
                                // "${getTranslated(context, "Payment")}",
                                style: TextStyle(
                                    fontSize: size.width * 0.045,
                                    fontFamily: Fonts.dmSansMedium,
                                    color: AppColors.white),
                              ),

                              SizedBox(
                                height: size.height * 0.015,
                              ),

                              // Row(
                              //   children: [
                              //     Expanded(
                              //         child: monthField(
                              //             hint: "Month",
                              //             controller: monthController)),
                              //     SizedBox(width: size.width * 0.03),
                              //     Expanded(
                              //         child: yearField(
                              //             hint: "Year",
                              //             controller: yearController)),
                              //   ],
                              // ),

                              yearField(
                                  hint: "MM/YY",
                                  controller: expireDateController),

                              SizedBox(
                                height: size.height * 0.015,
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: securityField(
                                        hint: "Security Code",
                                        controller: securityController),
                                  ),
                                  SizedBox(width: size.width * 0.03),
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
                      backgroundColor: AppColors.siginbackgrond,
                      child: Center(
                        child: Text(
                          "Swipe to pay",
                          // "${getTranslated(context, "Payment")}",
                          style: TextStyle(
                              fontSize: size.width * 0.045,
                              fontFamily: Fonts.dmSansMedium,
                              color: AppColors.white),
                        ),
                      ),
                    ),
                  )
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
      validator: (String? value) => value!.isEmpty ? Strings.fieldReq : null,
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
        new LengthLimitingTextInputFormatter(19),
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
}
