import 'package:cryptocurrency_flutter/component/favorite_coin_component.dart';
import 'package:cryptocurrency_flutter/main.dart';
import 'package:cryptocurrency_flutter/screens/about_us_screen.dart';
import 'package:cryptocurrency_flutter/screens/currency_selection_screen.dart';
import 'package:cryptocurrency_flutter/screens/default_setting_screen.dart';
import 'package:cryptocurrency_flutter/screens/language_selection_screen.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:cryptocurrency_flutter/utils/app_localizations.dart';
import 'package:cryptocurrency_flutter/widgets/app_scaffold.dart';
import 'package:cryptocurrency_flutter/widgets/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'categories_screen.dart';
import 'change_password_screen.dart';
import 'edit_profile_screen.dart';
import 'login_screen.dart';
import 'dart:io';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  InterstitialAd? buildInterstitialAd() {
    InterstitialAd.load(
      adUnitId: Admob.mAdMobInterstitialId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(onAdFailedToLoad: (LoadAdError error) {
        throw error.message;
      }, onAdLoaded: (InterstitialAd ad) {
        AppConstant.isAdsLoading ? ad.show() : SizedBox();
      }),
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);

    return AppScaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('lbl_setting'.translate, style: boldTextStyle(size: 22)),
      ),
      body: Observer(
        builder: (_) => Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Observer(
                  builder: (_) => Row(
                    children: [
                      cachedImage(appStore.photoUrl, fit: BoxFit.cover, height: 50, width: 50).cornerRadiusWithClipRRect(100),
                      16.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(appStore.firstName.validate(), style: boldTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text(appStore.email.validate(), style: secondaryTextStyle())
                        ],
                      ).expand(),
                      Icon(Icons.arrow_forward_ios_outlined, size: 12)
                    ],
                  ),
                ).paddingOnly(left: 8, right: context.width() * 0.06, top: 8, bottom: 8).onTap(() {
                  push(EditProfileScreen(), pageRouteAnimation: PageRouteAnimation.Scale);
                }).visible(appStore.isLoggedIn),
                SettingItemWidget(
                  leading: Icon(Icons.login),
                  title: 'lbl_sign_in_and_sign_up'.translate,
                  padding: EdgeInsets.all(16),
                  trailing: TextIcon(text: '', suffix: Icon(Icons.arrow_forward_ios_outlined, size: 12), textStyle: secondaryTextStyle()),
                  onTap: () {
                    LoginScreen(isSetting: true).launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                  },
                ).visible(!appStore.isLoggedIn),
                Row(
                  children: [
                    appStore.isDarkMode ? Icon(Icons.brightness_2) : Icon(Icons.wb_sunny_rounded),
                    16.width,
                    Text('choose_app_theme'.translate, style: boldTextStyle()).expand(),
                    Switch(
                      value: appStore.isDarkMode,
                      activeTrackColor: secondaryColor,
                      inactiveThumbColor: secondaryColor,
                      inactiveTrackColor: Colors.grey,
                      onChanged: (val) async {
                        appStore.setDarkMode(val);
                        await setValue(SharedPreferenceKeys.IS_DARK_MODE, val);
                      },
                    ),
                  ],
                ).paddingOnly(left: 16, top: 8, right: 16, bottom: 8).onTap(() async {
                  if (getBoolAsync(SharedPreferenceKeys.IS_DARK_MODE)) {
                    appStore.setDarkMode(false);
                    await setValue(SharedPreferenceKeys.IS_DARK_MODE, false);
                  } else {
                    appStore.setDarkMode(true);
                    await setValue(SharedPreferenceKeys.IS_DARK_MODE, true);
                  }
                }),
                SettingItemWidget(
                  leading: Icon(Icons.category_outlined),
                  title: "lbl_categories".translate,
                  padding: EdgeInsets.all(16),
                  trailing: TextIcon(text: '', suffix: Icon(Icons.arrow_forward_ios_outlined, size: 12), textStyle: secondaryTextStyle()),
                  onTap: () {
                    CategoriesScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                  },
                ),
                SettingItemWidget(
                  title: "lbl_favorite_coins".translate,
                  leading: Icon(Icons.favorite_outline),
                  padding: EdgeInsets.all(16),
                  onTap: () {
                    FavoriteCoinComponent().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                  },
                  trailing: TextIcon(text: '', suffix: Icon(Icons.arrow_forward_ios_outlined, size: 12), textStyle: secondaryTextStyle()),
                ),
                SettingItemWidget(
                  onTap: () {
                    DefaultSettingScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                  },
                  leading: Icon(Icons.settings),
                  title: "lbl_default_settings".translate,
                  padding: EdgeInsets.all(16),
                  trailing: TextIcon(text: '', suffix: Icon(Icons.arrow_forward_ios_outlined, size: 12), textStyle: secondaryTextStyle()),
                ),
                SettingItemWidget(
                  leading: Icon(Icons.password),
                  title: "lbl_change_password".translate,
                  padding: EdgeInsets.all(16),
                  trailing: TextIcon(text: '', suffix: Icon(Icons.arrow_forward_ios_outlined, size: 12), textStyle: secondaryTextStyle()),
                  onTap: () {
                    if (appStore.isEmailLogin) {
                      ChangePasswordScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                    } else {
                      toast("lbl_you_can_not_change_password".translate);
                    }
                  },
                ).visible(appStore.isLoggedIn),
                SettingItemWidget(
                  onTap: () {
                    CurrencySelectionScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                  },
                  leading: Icon(Icons.money),
                  padding: EdgeInsets.all(16),
                  title: "lbl_Currency".translate,
                  trailing: Observer(
                    builder: (_) => TextIcon(
                        text: "${appStore.mSelectedCurrency!.name.validate()} (${appStore.mSelectedCurrency!.symbol.validate()})",
                        suffix: Icon(Icons.arrow_forward_ios_outlined, size: 12),
                        textStyle: secondaryTextStyle()),
                  ),
                ),
                SettingItemWidget(
                  leading: Icon(Icons.language_outlined),
                  title: "lbl_App_Language".translate,
                  onTap: () {
                    appLocalizations = AppLocalizations.of(context);
                    LanguageSelectionScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide).then((value) {
                      setState(() {});
                    });
                  },
                  padding: EdgeInsets.all(16),
                  trailing: TextIcon(text: selectedLanguageDataModel!.name.validate(), suffix: Icon(Icons.arrow_forward_ios_outlined, size: 12), textStyle: secondaryTextStyle()),
                ),
                SettingItemWidget(
                  leading: Icon(Icons.star_border),
                  padding: EdgeInsets.all(16),
                  title: "lbl_Rate_us".translate,
                  onTap: () {
                    if (Platform.isAndroid) {
                      AppCommon.launchUrl(Urls.appShareURL);
                    } else {
                      AppCommon.launchUrl(appStoreBaseURL);
                    }
                  },
                ),
                SettingItemWidget(
                  leading: Icon(Icons.share),
                  title: "lbl_Share".translate,
                  padding: EdgeInsets.all(16),
                  onTap: () {
                    Share.share('Share ${AppConstant.appName} app\n\n${Urls.appShareURL}');
                  },
                ),
                SettingItemWidget(
                  leading: Icon(Icons.insert_drive_file),
                  title: "lbl_Terms_and_condition".translate,
                  padding: EdgeInsets.all(16),
                  onTap: () {
                    AppCommon.launchUrl(Urls.termsAndConditionURL, forceWebView: true);
                  },
                ),
                SettingItemWidget(
                  leading: Icon(Icons.person_outline),
                  title: "lbl_About_us".translate,
                  padding: EdgeInsets.all(16),
                  trailing: TextIcon(text: '', suffix: Icon(Icons.arrow_forward_ios_outlined, size: 12), textStyle: secondaryTextStyle()),
                  onTap: () {
                    AboutUsScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                  },
                ),
                SettingItemWidget(
                  leading: Icon(Icons.logout),
                  title: "lbl_logout".translate,
                  padding: EdgeInsets.all(16),
                  trailing: TextIcon(text: '', suffix: Icon(Icons.arrow_forward_ios_outlined, size: 12), textStyle: secondaryTextStyle()),
                  onTap: () {
                    showConfirmDialogCustom(
                      context,
                      dialogType: DialogType.CONFIRMATION,
                      primaryColor: secondaryColor,
                      title: "lbl_are_you_sure_logout".translate,
                      onAccept: (c) {
                        setState(() {
                          authService.logout(context);
                        });
                      },
                    );
                  },
                ).visible(appStore.isLoggedIn),
              ],
            ).paddingBottom(30),
          ),
        ),
      ),
    );
  }
}
