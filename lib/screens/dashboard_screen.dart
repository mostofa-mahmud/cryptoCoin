import 'package:async/async.dart';
import 'package:cryptocurrency_flutter/component/market_component.dart';
import 'package:cryptocurrency_flutter/component/trending_component.dart';
import 'package:cryptocurrency_flutter/main.dart';
import 'package:cryptocurrency_flutter/model/coin_list_model.dart';
import 'package:cryptocurrency_flutter/model/dashboard_model.dart';
import 'package:cryptocurrency_flutter/network/rest_api.dart';
import 'package:cryptocurrency_flutter/screens/derivatives_screen.dart';
import 'package:cryptocurrency_flutter/screens/exchanges_screen.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:cryptocurrency_flutter/widgets/app_scaffold.dart';
import 'package:cryptocurrency_flutter/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  AsyncMemoizer<DashboardResponse> asyncMemoizer = AsyncMemoizer();

  int page = 1;

  bool isLastPage = false;
  bool isReady = false;

  List<CoinListModel> mainList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
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
      child: AppScaffold(
        appBar: AppBar(
          title: Text('lbl_dashboard'.translate, style: boldTextStyle(size: 22)),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                ExchangesScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Scale);
              },
              icon: Icon(Icons.import_export_outlined),
            ).withTooltip(msg: "lbl_exchanges".translate),
            IconButton(
              onPressed: () {
                DerivativesScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Scale);
              },
              icon: Icon(Icons.stacked_line_chart_outlined),
            ).withTooltip(msg: "lbl_derivatives".translate),
          ],
        ),
        body: TimerWidget(
          initialDelay: 0,
          duration: 10.seconds,
          function: () {
            setState(() {});
          },
          child: FutureBuilder<DashboardResponse>(
            future: dashboardStream(currency: appStore.mSelectedCurrency!.cc.validate()),
            initialData: getStringAsync(SharedPreferenceKeys.TRENDING_DATA).isEmpty ? null : getCachedUserDashboardData(),
            builder: (context, snap) {
              if (snap.hasData) {
                return RefreshIndicator(
                  color: secondaryColor,
                  backgroundColor: context.cardColor,
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  onRefresh: () async {
                    setState(() {});
                    await Future.delayed(Duration(seconds: 2));
                  },
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 36),
                    physics: BouncingScrollPhysics(),
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TrendingComponent(data: snap.data!.trendingCoins!),
                        8.height,
                        MarketComponent(mainList: snap.data!.coinModel.validate()),
                      ],
                    ),
                  ),
                );
              }
              return snapWidgetHelper(snap, loadingWidget: LoaderWidget());
            },
          ),
        ),
      ),
    );
  }
}
