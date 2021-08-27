import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funfy/apis/addressApi.dart';
import 'package:funfy/components/dialogs.dart';
import 'package:funfy/components/navigation.dart';
import 'package:funfy/components/sizeclass/SizeConfig.dart';
import 'package:funfy/models/addressLsitModel.dart';
import 'package:funfy/ui/screens/address/addressAdd.dart';
import 'package:funfy/ui/screens/address/addressEdit.dart';
import 'package:funfy/utils/InternetCheck.dart';
import 'package:funfy/utils/colors.dart';
import 'package:funfy/utils/langauge_constant.dart';
import 'package:hexcolor/hexcolor.dart';

class AddressList extends StatefulWidget {
  const AddressList({Key? key}) : super(key: key);

  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  int? groupValue = -1;
  int? initvalue = 0;

  bool _loading = false;

  AddressListModel? addressListModel;

  _handleRadioValueChange(int? value) {
    setState(() {
      groupValue = value;
    });
  }

  getAddresApiCall() async {
    var net = await Internetcheck.check();
    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loading = true;
      });
      try {
        await getAddressList().then((value) {
          setState(() {
            _loading = false;
          });

          if (value != null) {
            addressListModel = value;
          } else {
            Dialogs.showBasicsFlash(
                context: context,
                color: AppColors.siginbackgrond,
                duration: Duration(seconds: 1),
                content: "${getTranslated(context, 'errortoloading')}");
          }
        });
      } catch (e) {
        print("Here Creating error > $e");
        setState(() {
          _loading = false;
        });
        Dialogs.showBasicsFlash(
            context: context,
            color: AppColors.siginbackgrond,
            duration: Duration(seconds: 1),
            content: "${getTranslated(context, 'errortoloading')}");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getAddresApiCall();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.black,
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#3d322a"),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.siginbackgrond,
          onPressed: () {
            navigatorPushFun(context, AddressAdd());
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          elevation: 1,
          shadowColor: AppColors.white,
          backgroundColor: AppColors.blackBackground,
          centerTitle: true,
          title: Text("${getTranslated(context, 'address')}"),
        ),
        body: Column(
          children: [
            _loading
                ? Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                    color: AppColors.white,
                  )))
                : _loading == false &&
                        (addressListModel == null ||
                            addressListModel?.data?.length == 0)
                    ? Expanded(
                        child: Center(
                            child: Text(
                        "${getTranslated(context, 'listisEmpty')}",
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: size.width * 0.045),
                      )))
                    : Expanded(
                        child: ListView.builder(
                            itemCount: addressListModel?.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return ticket(
                                  context: context,
                                  index: index,
                                  addressModel: addressListModel);
                            }))
          ],
        ),
      ),
    );
  }

  Widget ticket({context, int? index, AddressListModel? addressModel}) {
    var size = MediaQuery.of(context).size;

    var data = addressModel?.data![index!];

    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => AddressEdit(addressmodel: data)))
            .then((value) {
          getAddresApiCall();
        });
      },
      child: Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.symmetric(
            vertical: size.height * 0.01, horizontal: size.width * 0.02),
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
                          horizontal: size.width * 0.02,
                          vertical: size.height * 0.001),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: SizeConfig.screenWidth * 0.40,
                                child: Text(
                                  "${data?.name}",
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
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Container(
                                width: SizeConfig.screenWidth * 0.60,
                                child: Text(
                                  "${data?.streetAddress}, ${data?.city}, ${data?.state}, ${data?.country}, ${data?.zip}",
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
                                    }),
                              ),
                              IconButton(
                                onPressed: () {
                                  Dialogs.simpleAlertDialog(
                                      context: context,
                                      title:
                                          "${getTranslated(context, "delete")}",
                                      content:
                                          "${getTranslated(context, "Doyouwanttodeletetheaddress")}",
                                      func: () {
                                        navigatePopFun(context);
                                        print("${data?.id.toString()}");
                                        deleteAddressFun(
                                            id: data?.id.toString());
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
      ),
    );
  }

  Future deleteAddressFun({String? id}) async {
    var net = await Internetcheck.check();
    if (net != true) {
      Internetcheck.showdialog(context: context);
    } else {
      setState(() {
        _loading = true;
      });
      try {
        print("Run --------------");
        await deleteAddress(id: id).then((value) {
          setState(() {
            _loading = false;
          });

          if (value!) {
            Dialogs.showBasicsFlash(
                context: context,
                color: Colors.green,
                duration: Duration(seconds: 1),
                content:
                    "${getTranslated(context, 'addresssuccessfullyDeleted')}");
            getAddresApiCall();
          } else {
            Dialogs.showBasicsFlash(
                context: context,
                color: AppColors.siginbackgrond,
                duration: Duration(seconds: 1),
                content: "${getTranslated(context, 'errortoloading')}");
          }
        });
      } catch (e) {
        print("Here Creating error > $e");
        setState(() {
          _loading = false;
        });
        Dialogs.showBasicsFlash(
            context: context,
            color: AppColors.siginbackgrond,
            duration: Duration(seconds: 1),
            content: "${getTranslated(context, 'errortoloading')}");
      }
    }
  }
}
