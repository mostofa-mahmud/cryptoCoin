import 'package:cryptocurrency_flutter/component/Market_type_based_on_date_component.dart';
import 'package:cryptocurrency_flutter/component/coin_detail_component.dart';
import 'package:cryptocurrency_flutter/component/detail_component.dart';
import 'package:cryptocurrency_flutter/component/key_metrics_component.dart';
import 'package:cryptocurrency_flutter/component/market_chart_component.dart';
import 'package:cryptocurrency_flutter/main.dart';
import 'package:cryptocurrency_flutter/model/coin_detail_model.dart';
import 'package:cryptocurrency_flutter/network/local_db/sqflite_methods.dart';
import 'package:cryptocurrency_flutter/network/rest_api.dart';
import 'package:cryptocurrency_flutter/screens/exchange_screen.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:cryptocurrency_flutter/widgets/app_scaffold.dart';
import 'package:cryptocurrency_flutter/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';

import 'companies_screen.dart';

// ignore: must_be_immutable
class CoinDetailScreen extends StatefulWidget {
  String id;
  String name;

  CoinDetailScreen({required this.id, required this.name});

  @override
  _CoinDetailScreenState createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> with TickerProviderStateMixin {
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
    buildInterstitialAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppScaffold(
        appBar: AppBar(
          title: Text('${widget.name.validate()}', style: boldTextStyle(size: 22)),
          actions: [
            IconButton(
              onPressed: () {
                ExchangeScreen(ticker: coinData!.tickers!).launch(context, pageRouteAnimation: PageRouteAnimation.Scale);
              },
              icon: Icon(Icons.import_export_outlined, size: 24),
            ),
            IconButton(
              onPressed: () {
                DetailComponent(data: coinData!).launch(context, pageRouteAnimation: PageRouteAnimation.Scale);
              },
              icon: Icon(Icons.info_outline, size: 24),
            ),
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
          onSuccess: (data) {
            if (coinData == null) {
              coinData = data;
              /* if (appStore.isItemInFav(id: coinData!.id.validate())) {
                appStore.favCoinList.remove(coinData!.id.validate());
              } else {
                appStore.favCoinList.add(coinData!.id.validate());
              }*/
            }
            return Container(
              child: RefreshIndicator(
                color: secondaryColor,
                backgroundColor: context.cardColor,
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                onRefresh: () async {
                  setState(() {});
                  await 2.seconds.delay;
                },
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,
                      CoinDetailComponent(data: data).paddingSymmetric(horizontal: 16),
                      16.height,
                      /*Align(
                        alignment: Alignment.topRight,
                        child: Icon(isFav ? Icons.favorite_outlined : Icons.favorite_outline, size: 28, color: secondaryColor).paddingAll(8).onTap(() {
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
                      ),*/
                      Observer(builder: (context) {
                        return MarketTypeBasedOnDateComponent(
                          data: coinData,
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
                                //appStore.favCoinList.remove(coinData!.id.validate());
                              } else {
                                //appStore.favCoinList.add(coinData!.id.validate());
                                appStore.addToFav(id: coinData!.id.validate());
                              }
                            }).catchError((e) {
                              log(e.toString());
                            });
                            setState(() {});
                          },
                        );
                      }),
                      MarketChartComponent(coinId: data.id!),
                      KeyMetricsComponent(marketData: data.market_data!),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
