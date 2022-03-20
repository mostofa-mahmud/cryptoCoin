import 'package:cryptocurrency_flutter/main.dart';
import 'package:cryptocurrency_flutter/model/currency_model.dart';
import 'package:cryptocurrency_flutter/network/rest_api.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:cryptocurrency_flutter/utils/app_functions.dart';
import 'package:cryptocurrency_flutter/widgets/selected_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';

class CurrencySelectionScreen extends StatefulWidget {
  @override
  _CurrencySelectionScreenState createState() => _CurrencySelectionScreenState();
}

class _CurrencySelectionScreenState extends State<CurrencySelectionScreen> {
  int selectedIndex = -1;
  BannerAd? myBanner;
  String searchString = "";

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    selectedIndex = getIntAsync(SharedPreferenceKeys.SELECTED_CURRENCY_INDEX, defaultValue: 0);
    myBanner = buildBannerAd()..load();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('lbl_currencies'.translate, style: boldTextStyle()),
        ),
        body: SnapHelperWidget<List<CurrencyModel>>(
          future: getCurrencies,
          onSuccess: (snap) {
            return Stack(
              children: [
                AppTextField(
                  textFieldType: TextFieldType.OTHER,
                  decoration: AppCommon.inputDecoration('lbl_search'.translate).copyWith(
                    suffixIcon: Icon(Icons.search, color: Colors.white),
                  ),
                  onChanged: (s) {
                    searchString = s;
                    setState(() {});
                  },
                ).paddingSymmetric(horizontal: 16),
                ListView.builder(
                  itemCount: snap.length,
                  itemBuilder: (context, index) {
                    CurrencyModel data = snap[index];

                    bool isSelected = index == selectedIndex;

                    return snap[index].name!.contains(searchString)
                        ? SettingItemWidget(
                            decoration: BoxDecoration(color: isSelected ? secondaryColor.withOpacity(0.2) : null),
                            onTap: () {
                              setValue(SharedPreferenceKeys.SELECTED_CURRENCY_INDEX, index);

                              selectedIndex = index;

                              appStore.setSelectedCurrency(data);

                              setState(() {});
                            },
                            subTitle: data.cc.validate().toUpperCase(),
                            leading: Container(
                              padding: EdgeInsets.all(8),
                              decoration: boxDecorationWithShadow(backgroundColor: appStore.isDarkMode ? cardColor : secondaryColor, borderRadius: radius()),
                              width: 60,
                              child: Text("${data.symbol.validate()}", style: primaryTextStyle(size: 16)).center(),
                            ),
                            trailing: isSelected ? SelectedItemWidget() : Offstage(),
                            title: data.name.validate(),
                          )
                        : Container();
                  },
                ).paddingTop(60),
                Positioned(
                  child: AdWidget(ad: myBanner!),
                  bottom: 0,
                  left: 0,
                  height: AdSize.banner.height.toDouble(),
                  width: context.width(),
                ).visible(myBanner != null && AppConstant.isAdsLoading),
              ],
            );
          },
        ),
      ),
    );
  }
}
