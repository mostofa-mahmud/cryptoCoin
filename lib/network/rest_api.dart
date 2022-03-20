import 'dart:convert';

import 'package:cryptocurrency_flutter/model/candel_chart_model.dart';
import 'package:cryptocurrency_flutter/model/categories_model.dart';
import 'package:cryptocurrency_flutter/model/coin_chart_model.dart';
import 'package:cryptocurrency_flutter/model/coin_detail_model.dart';
import 'package:cryptocurrency_flutter/model/coin_list_model.dart';
import 'package:cryptocurrency_flutter/model/companies_model.dart';
import 'package:cryptocurrency_flutter/model/currency_model.dart';
import 'package:cryptocurrency_flutter/model/dashboard_model.dart';
import 'package:cryptocurrency_flutter/model/derivatives_detail_model.dart';
import 'package:cryptocurrency_flutter/model/derivatives_response.dart';
import 'package:cryptocurrency_flutter/model/exchange_detail_model.dart';
import 'package:cryptocurrency_flutter/model/exchange_ticker_response.dart';
import 'package:cryptocurrency_flutter/model/exchnages_response.dart';
import 'package:cryptocurrency_flutter/model/news_response.dart';
import 'package:cryptocurrency_flutter/model/price_model.dart';
import 'package:cryptocurrency_flutter/model/search_model.dart';
import 'package:cryptocurrency_flutter/model/trending_model.dart';
import 'package:cryptocurrency_flutter/network/network_utils.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

Future<List<CoinListModel>> getCoinList({
  String currency = 'usd',
  int page = 1,
  String sortingOrder = 'market_cap_desc',
  String interval = '1h',
  String? categoryId,
}) async {
  Iterable iterable;
  if (categoryId != null) {
    iterable = await handleResponse(await buildHttpResponse(
        'coins/markets?vs_currency=$currency&order=$sortingOrder&per_page=${AppConstant.perPage}&page=$page&sparkline=true&price_change_percentage=$interval&category=$categoryId'));
  } else {
    iterable = await handleResponse(
        await buildHttpResponse('coins/markets?vs_currency=$currency&order=$sortingOrder&per_page=${AppConstant.perPage}&page=$page&sparkline=true&price_change_percentage=$interval'));
  }

  List<CoinListModel> list = [];

  iterable.forEach((element) {
    list.add(CoinListModel.fromJson(element));
  });

  await setValue(SharedPreferenceKeys.COIN_LIST, jsonEncode(list));

  return list;
}

Future<TrendingModel> get getTrendingList async {
  TrendingModel td = TrendingModel.fromJson(await handleResponse(await buildHttpResponse('/search/trending/')));
  await setValue(SharedPreferenceKeys.TRENDING_DATA, jsonEncode(td.toJson()));

  return td;
}

Future<CoinDetailModel> getCoinDetail({String? name}) async {
  CoinDetailModel cd =
      CoinDetailModel.fromJson(await handleResponse(await buildHttpResponse('coins/$name?localization=false&tickers=true&market_data=true&community_data=true&developer_data=true&sparkline=true')));

  return cd;
}

Future<CoinChartModel> getCoinMarket({String? name, int timeLimit = 1, String currency = ' usd'}) async {
  CoinChartModel cd = CoinChartModel.fromJson(await handleResponse(await buildHttpResponse('https://api.coingecko.com/api/v3/coins/$name/market_chart?vs_currency=$currency&days=$timeLimit')));

  return cd;
}

Future<List<CurrencyModel>> get getCurrencies async {
  Iterable iterable = jsonDecode(await rootBundle.loadString('assets/currency.json'));
  List<CurrencyModel> list = [];
  iterable.forEach((element) {
    list.add(CurrencyModel.fromJson(element));
  });
  return list;
}

Future<DashboardResponse> dashboardStream({bool value = true, String currency = 'usd'}) async {
  DashboardResponse dashboardResponse = DashboardResponse();

  dashboardResponse.coinModel = await getCoinList(page: 1, currency: '$currency', interval: '1h');
  dashboardResponse.trendingCoins = await getTrendingList;

  return dashboardResponse;
}

Future<SearchModel> get getCoinListForSearch async {
  return SearchModel.fromJson(await handleResponse(await buildHttpResponse('https://api.coingecko.com/api/v3/search/')));
}

/*Future<NewsResponse> getCryptoNews({int page = 1}) async {
  return NewsResponse.fromJson(await handleResponse(await buildHttpResponse('https://api.coingecko.com/api/v3/news?page=$page')));
}*/

Future<NewsResponse> getCryptoNews({int page = 1}) async {
  return NewsResponse.fromJson(await handleResponse(await buildHttpResponse('https://api.coingecko.com/api/v3/news?page=$page')));
}

//region CachedData
DashboardResponse? getCachedUserDashboardData() {
  DashboardResponse dashboardResponse = DashboardResponse();

  String coinList = getStringAsync(SharedPreferenceKeys.COIN_LIST);
  String trendingData = getStringAsync(SharedPreferenceKeys.TRENDING_DATA);

  List<CoinListModel> list = [];
  jsonDecode(coinList).forEach((element) {
    list.add(CoinListModel.fromJson(element));
  });

  dashboardResponse.coinModel = list;
  dashboardResponse.trendingCoins = TrendingModel.fromJson(jsonDecode(trendingData));
  return dashboardResponse;
}

//endregion

Future<List<ExchangesResponse>> getExchanges({int page = 1}) async {
  Iterable iterable = await handleResponse(await buildHttpResponse('https://api.coingecko.com/api/v3/exchanges?per_page=${AppConstant.perPage}&page=$page'));
  List<ExchangesResponse> list = [];

  iterable.forEach((element) {
    list.add(ExchangesResponse.fromJson(element));
  });

  return list;
}

Future<ExchangeDetailResponse> getExchangesDetail(String exchangeId) async {
  return ExchangeDetailResponse.fromJson(await handleResponse(await buildHttpResponse('https://api.coingecko.com/api/v3/exchanges/$exchangeId')));
}

Future<List> getExchangesChart({String? exchangeId = "binance", int interval = 1}) async {
  Iterable it = await handleResponse(await buildHttpResponse('https://api.coingecko.com/api/v3/exchanges/$exchangeId/volume_chart?days=$interval'));

  return it.toList();
}

Future<ExchangeTickerModel> getExchangesTickerList({String? exchangeId = "binance", int page = 1}) async {
  return ExchangeTickerModel.fromJson(await handleResponse(await buildHttpResponse('https://api.coingecko.com/api/v3/exchanges/$exchangeId/tickers?page=$page&order=trust_score_desc')));
}

class DerivativesApi {
  static Future<List<DerivativesResponse>> getDerivativesList({int page = 1}) async {
    Iterable iterable = await handleResponse(await buildHttpResponse('https://api.coingecko.com/api/v3/derivatives/exchanges?order=&per_page=${AppConstant.perPage}&page=$page'));
    List<DerivativesResponse> list = [];

    iterable.forEach((element) {
      list.add(DerivativesResponse.fromJson(element));
    });

    return list;
  }

  static Future<DerivativesDetailResponse> getDerivativesDetail({String? id}) async {
    return DerivativesDetailResponse.fromJson(await handleResponse(await buildHttpResponse('https://api.coingecko.com/api/v3/derivatives/exchanges/$id?include_tickers=all')));
  }
}

class ChartApi {
  static Future<List<CandleChartResponse>> getOLHCChart({String? coinId, String currency = 'inr', int days = 1}) async {
    Iterable it = await handleResponse(await buildHttpResponse('https://api.coingecko.com/api/v3/coins/$coinId/ohlc?vs_currency=$currency&days=$days'));

    List<CandleChartResponse> data = [];

    it.forEach((element) {
      data.add(CandleChartResponse(time: element[0], open: element[1], high: element[2], low: element[3], close: element[4]));
    });

    return data;
  }
}

///categories list api
Future<List<CategoriesModel>> getCategoriesList({
  String sortingOrder = 'market_cap_desc',
}) async {
  Iterable iterable = await handleResponse(await buildHttpResponse('https://api.coingecko.com/api/v3/coins/categories?order=$sortingOrder'));
  List<CategoriesModel> list = [];

  iterable.forEach((element) {
    list.add(CategoriesModel.fromJson(element));
  });

  await setValue(SharedPreferenceKeys.CATEGORIES_LIST, jsonEncode(list));

  return list;
}

///price api call
Future<Map<String, dynamic>> getPriceInfo({String? currency, String? favouriteId}) async {
  return await handleResponse(await buildHttpResponse(
      'https://api.coingecko.com/api/v3/simple/price?ids=$favouriteId&vs_currencies=$currency&include_market_cap=true&include_24hr_vol=true&include_24hr_change=true&include_last_updated_at=true'));
}

///companies api call
Future<CompaniesModel> getCompaniesList({String? coinId}) async {
  return CompaniesModel.fromJson(await handleResponse(await buildHttpResponse('https://api.coingecko.com/api/v3/companies/public_treasury/$coinId')));
}

///portfolio api call
class PortfolioApi {
  static Future<Map<String, dynamic>> getPortfolioData({String? coinIds, String currency = 'inr'}) async {
    return await handleResponse(await buildHttpResponse(
        "https://api.coingecko.com/api/v3/simple/price?ids=$coinIds&vs_currencies=$currency&include_market_cap=true&include_24hr_vol=true&include_24hr_change=true&include_last_updated_at=true"));
  }
}
