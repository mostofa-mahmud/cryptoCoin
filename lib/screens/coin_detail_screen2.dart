import 'package:cryptocurrency_flutter/component/coin_description_component.dart';
import 'package:cryptocurrency_flutter/component/coin_detail_component.dart';
import 'package:cryptocurrency_flutter/component/key_metrics_component.dart';
import 'package:cryptocurrency_flutter/component/market_chart_component.dart';
import 'package:cryptocurrency_flutter/model/coin_detail_model.dart';
import 'package:cryptocurrency_flutter/network/local_db/sqflite_methods.dart';
import 'package:cryptocurrency_flutter/network/rest_api.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:cryptocurrency_flutter/widgets/app_scaffold.dart';
import 'package:cryptocurrency_flutter/widgets/cached_network_image.dart';
import 'package:cryptocurrency_flutter/widgets/loader_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import 'companies_screen.dart';

class CoinDetailScreen2 extends StatefulWidget {
  final String id;
  final String name;
  final String image;

  CoinDetailScreen2({required this.id, required this.name, required this.image});

  @override
  _CoinDetailScreen2State createState() => _CoinDetailScreen2State();
}

class _CoinDetailScreen2State extends State<CoinDetailScreen2> {
  CoinDetailModel? coinData;
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    fetchCoinData();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  InterstitialAd? buildInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Admob.mAdMobInterstitialId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdFailedToLoad: (LoadAdError error) {
          throw error.message;
        }, onAdLoaded: (InterstitialAd ad) {
          AppConstant.isAdsLoading ? ad.show() : SizedBox();
        }));
  }

  Future fetchCoinData() async {
    appStore.setLoading(true);

    SqliteMethods.getFavoriteCoins().then((element) {
      appStore.favCoinList.clear();
      element.forEach((element) {
        appStore.favCoinList.add(element.id!);
      });
    }).catchError((e) {
      toast(e.toString());
    }).whenComplete(() {
      appStore.setLoading(false);
    });
  }

  @override
  void dispose() {
    if (kReleaseMode) {
      buildInterstitialAd();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppScaffold(
        appBar: AppBar(
          centerTitle: false,
          title: cachedImage(widget.image, width: 35, height: 35),
          actions: [
            IconButton(
              onPressed: () {
                CompaniesScreen(coinId: widget.id).launch(context, pageRouteAnimation: PageRouteAnimation.Scale);
              },
              icon: Image.asset('images/social_images/company.png', height: 24, width: 24, fit: BoxFit.fitWidth, color: context.iconColor),
            ),
          ],
        ),
        body: SnapHelperWidget<CoinDetailModel>(
          future: getCoinDetail(name: widget.id),
          loadingWidget: LoaderWidget(),
          onSuccess: (snap) {
            if (coinData == null) {
              coinData = snap;
              if (appStore.favCoinList.contains(coinData!.id!)) {
                isFav = true;
              } else {
                isFav = false;
              }
            }
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*Align(
                      alignment: Alignment.topRight,
                      child: Icon(isFav ? Icons.favorite_outlined : Icons.favorite_outline, size: 28, color: Colors.red).onTap(() {
                        SqliteMethods.updateFavoriteStatus(isFav ? 0 : 1, coinData!.id.toString()).then((value) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          snackBar(
                            context,
                            title:
                                isFav ? '${'lbl_removed'.translate} ${coinData!.name} ${'lbl_from_favorite'.translate}' : '${'lbl_added'.translate} ${coinData!.name} ${'lbl_to_favorite'.translate}',
                          );
                          setState(() {
                            isFav = !isFav;
                          });
                        }).catchError((e) {
                          log(e.toString());
                        });
                      }),
                    ).paddingOnly(right: 8),
                    16.height,*/
                    CoinDetailComponent(
                      data: snap,
                      dashboardType: getSelectedDashboard,
                      onUpdate: () async {
                        await SqliteMethods.updateFavoriteStatus(appStore.isItemInFav(id: coinData!.id.validate()) ? 0 : 1, coinData!.id.toString()).then((value) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          snackBar(
                            context,
                            title: appStore.isItemInFav(id: coinData!.id.validate())
                                ? '${'lbl_removed'.translate} ${coinData!.name} ${'lbl_from_favorite'.translate}'
                                : '${'lbl_added'.translate} ${coinData!.name} ${'lbl_to_favorite'.translate}',
                          );
                          if (appStore.isItemInFav(id: coinData!.id.validate())) {
                            appStore.removeFromFav(id: coinData!.id.validate());
                          } else {
                            appStore.addToFav(id: coinData!.id.validate());
                          }
                        }).catchError((e) {
                          log(e.toString());
                        });
                        setState(() {});
                      },
                    ).paddingSymmetric(horizontal: 16),
                    16.height,
                    MarketChartComponent(coinId: snap.id!, dashboardType: getSelectedDashboard),
                    16.height,
                    KeyMetricsComponent(marketData: snap.market_data!, dashboardType: getSelectedDashboard),
                    16.height,
                    CoinDescriptionWidget(snap: snap)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
