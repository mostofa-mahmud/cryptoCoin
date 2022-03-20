// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on AppStoreBase, Store {
  Computed<bool>? _$isNetworkConnectedComputed;

  @override
  bool get isNetworkConnected => (_$isNetworkConnectedComputed ??=
          Computed<bool>(() => super.isNetworkConnected,
              name: 'AppStoreBase.isNetworkConnected'))
      .value;

  final _$selectedLanguageAtom = Atom(name: 'AppStoreBase.selectedLanguage');

  @override
  LanguageDataModel? get selectedLanguage {
    _$selectedLanguageAtom.reportRead();
    return super.selectedLanguage;
  }

  @override
  set selectedLanguage(LanguageDataModel? value) {
    _$selectedLanguageAtom.reportWrite(value, super.selectedLanguage, () {
      super.selectedLanguage = value;
    });
  }

  final _$mSelectedGraphColorAtom =
      Atom(name: 'AppStoreBase.mSelectedGraphColor');

  @override
  Color get mSelectedGraphColor {
    _$mSelectedGraphColorAtom.reportRead();
    return super.mSelectedGraphColor;
  }

  @override
  set mSelectedGraphColor(Color value) {
    _$mSelectedGraphColorAtom.reportWrite(value, super.mSelectedGraphColor, () {
      super.mSelectedGraphColor = value;
    });
  }

  final _$mSelectedMarketTypeAtom =
      Atom(name: 'AppStoreBase.mSelectedMarketType');

  @override
  ChartMarketType get mSelectedMarketType {
    _$mSelectedMarketTypeAtom.reportRead();
    return super.mSelectedMarketType;
  }

  @override
  set mSelectedMarketType(ChartMarketType value) {
    _$mSelectedMarketTypeAtom.reportWrite(value, super.mSelectedMarketType, () {
      super.mSelectedMarketType = value;
    });
  }

  final _$mDashboardTypeAtom = Atom(name: 'AppStoreBase.mDashboardType');

  @override
  DefaultSetting? get mDashboardType {
    _$mDashboardTypeAtom.reportRead();
    return super.mDashboardType;
  }

  @override
  set mDashboardType(DefaultSetting? value) {
    _$mDashboardTypeAtom.reportWrite(value, super.mDashboardType, () {
      super.mDashboardType = value;
    });
  }

  final _$mDefaultChartAtom = Atom(name: 'AppStoreBase.mDefaultChart');

  @override
  DefaultSetting? get mDefaultChart {
    _$mDefaultChartAtom.reportRead();
    return super.mDefaultChart;
  }

  @override
  set mDefaultChart(DefaultSetting? value) {
    _$mDefaultChartAtom.reportWrite(value, super.mDefaultChart, () {
      super.mDefaultChart = value;
    });
  }

  final _$mDefaultTrendingCardAtom =
      Atom(name: 'AppStoreBase.mDefaultTrendingCard');

  @override
  DefaultSetting? get mDefaultTrendingCard {
    _$mDefaultTrendingCardAtom.reportRead();
    return super.mDefaultTrendingCard;
  }

  @override
  set mDefaultTrendingCard(DefaultSetting? value) {
    _$mDefaultTrendingCardAtom.reportWrite(value, super.mDefaultTrendingCard,
        () {
      super.mDefaultTrendingCard = value;
    });
  }

  final _$mSelectedCurrencyAtom = Atom(name: 'AppStoreBase.mSelectedCurrency');

  @override
  CurrencyModel? get mSelectedCurrency {
    _$mSelectedCurrencyAtom.reportRead();
    return super.mSelectedCurrency;
  }

  @override
  set mSelectedCurrency(CurrencyModel? value) {
    _$mSelectedCurrencyAtom.reportWrite(value, super.mSelectedCurrency, () {
      super.mSelectedCurrency = value;
    });
  }

  final _$mIsLoadingAtom = Atom(name: 'AppStoreBase.mIsLoading');

  @override
  bool? get mIsLoading {
    _$mIsLoadingAtom.reportRead();
    return super.mIsLoading;
  }

  @override
  set mIsLoading(bool? value) {
    _$mIsLoadingAtom.reportWrite(value, super.mIsLoading, () {
      super.mIsLoading = value;
    });
  }

  final _$isLoggedInAtom = Atom(name: 'AppStoreBase.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  final _$uidAtom = Atom(name: 'AppStoreBase.uid');

  @override
  String get uid {
    _$uidAtom.reportRead();
    return super.uid;
  }

  @override
  set uid(String value) {
    _$uidAtom.reportWrite(value, super.uid, () {
      super.uid = value;
    });
  }

  final _$firstNameAtom = Atom(name: 'AppStoreBase.firstName');

  @override
  String get firstName {
    _$firstNameAtom.reportRead();
    return super.firstName;
  }

  @override
  set firstName(String value) {
    _$firstNameAtom.reportWrite(value, super.firstName, () {
      super.firstName = value;
    });
  }

  final _$emailAtom = Atom(name: 'AppStoreBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$photoUrlAtom = Atom(name: 'AppStoreBase.photoUrl');

  @override
  String get photoUrl {
    _$photoUrlAtom.reportRead();
    return super.photoUrl;
  }

  @override
  set photoUrl(String value) {
    _$photoUrlAtom.reportWrite(value, super.photoUrl, () {
      super.photoUrl = value;
    });
  }

  final _$isEmailLoginAtom = Atom(name: 'AppStoreBase.isEmailLogin');

  @override
  bool get isEmailLogin {
    _$isEmailLoginAtom.reportRead();
    return super.isEmailLogin;
  }

  @override
  set isEmailLogin(bool value) {
    _$isEmailLoginAtom.reportWrite(value, super.isEmailLogin, () {
      super.isEmailLogin = value;
    });
  }

  final _$isTesterAtom = Atom(name: 'AppStoreBase.isTester');

  @override
  bool get isTester {
    _$isTesterAtom.reportRead();
    return super.isTester;
  }

  @override
  set isTester(bool value) {
    _$isTesterAtom.reportWrite(value, super.isTester, () {
      super.isTester = value;
    });
  }

  final _$isLoadingAtom = Atom(name: 'AppStoreBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$isDarkModeAtom = Atom(name: 'AppStoreBase.isDarkMode');

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  final _$favCoinListAtom = Atom(name: 'AppStoreBase.favCoinList');

  @override
  List<String> get favCoinList {
    _$favCoinListAtom.reportRead();
    return super.favCoinList;
  }

  @override
  set favCoinList(List<String> value) {
    _$favCoinListAtom.reportWrite(value, super.favCoinList, () {
      super.favCoinList = value;
    });
  }

  final _$connectivityResultAtom =
      Atom(name: 'AppStoreBase.connectivityResult');

  @override
  ConnectivityResult get connectivityResult {
    _$connectivityResultAtom.reportRead();
    return super.connectivityResult;
  }

  @override
  set connectivityResult(ConnectivityResult value) {
    _$connectivityResultAtom.reportWrite(value, super.connectivityResult, () {
      super.connectivityResult = value;
    });
  }

  final _$setSelectedGraphColorAsyncAction =
      AsyncAction('AppStoreBase.setSelectedGraphColor');

  @override
  Future<dynamic> setSelectedGraphColor(Color aColor) {
    return _$setSelectedGraphColorAsyncAction
        .run(() => super.setSelectedGraphColor(aColor));
  }

  final _$setSelectedMarketTypeAsyncAction =
      AsyncAction('AppStoreBase.setSelectedMarketType');

  @override
  Future<dynamic> setSelectedMarketType(ChartMarketType aType) {
    return _$setSelectedMarketTypeAsyncAction
        .run(() => super.setSelectedMarketType(aType));
  }

  final _$setSelectedDashboardAsyncAction =
      AsyncAction('AppStoreBase.setSelectedDashboard');

  @override
  Future<dynamic> setSelectedDashboard(DefaultSetting aType) {
    return _$setSelectedDashboardAsyncAction
        .run(() => super.setSelectedDashboard(aType));
  }

  final _$setSelectedDefaultChartAsyncAction =
      AsyncAction('AppStoreBase.setSelectedDefaultChart');

  @override
  Future<dynamic> setSelectedDefaultChart(DefaultSetting aType) {
    return _$setSelectedDefaultChartAsyncAction
        .run(() => super.setSelectedDefaultChart(aType));
  }

  final _$setSelectedDefaultTrendingCardAsyncAction =
      AsyncAction('AppStoreBase.setSelectedDefaultTrendingCard');

  @override
  Future<dynamic> setSelectedDefaultTrendingCard(DefaultSetting aType) {
    return _$setSelectedDefaultTrendingCardAsyncAction
        .run(() => super.setSelectedDefaultTrendingCard(aType));
  }

  final _$setLoadingAsyncAction = AsyncAction('AppStoreBase.setLoading');

  @override
  Future<dynamic> setLoading(bool aIsLoading) {
    return _$setLoadingAsyncAction.run(() => super.setLoading(aIsLoading));
  }

  final _$setSelectedCurrencyAsyncAction =
      AsyncAction('AppStoreBase.setSelectedCurrency');

  @override
  Future<CurrencyModel> setSelectedCurrency(CurrencyModel aSelectedCurrency) {
    return _$setSelectedCurrencyAsyncAction
        .run(() => super.setSelectedCurrency(aSelectedCurrency));
  }

  final _$setLanguageAsyncAction = AsyncAction('AppStoreBase.setLanguage');

  @override
  Future<void> setLanguage(String aCode) {
    return _$setLanguageAsyncAction.run(() => super.setLanguage(aCode));
  }

  final _$setUidAsyncAction = AsyncAction('AppStoreBase.setUid');

  @override
  Future<void> setUid(String value, {bool isInitializing = false}) {
    return _$setUidAsyncAction
        .run(() => super.setUid(value, isInitializing: isInitializing));
  }

  final _$setLoggedInAsyncAction = AsyncAction('AppStoreBase.setLoggedIn');

  @override
  Future<void> setLoggedIn(bool val, {bool isInitializing = false}) {
    return _$setLoggedInAsyncAction
        .run(() => super.setLoggedIn(val, isInitializing: isInitializing));
  }

  final _$setFirstNameAsyncAction = AsyncAction('AppStoreBase.setFirstName');

  @override
  Future<void> setFirstName(String value, {bool isInitializing = false}) {
    return _$setFirstNameAsyncAction
        .run(() => super.setFirstName(value, isInitializing: isInitializing));
  }

  final _$setEmailAsyncAction = AsyncAction('AppStoreBase.setEmail');

  @override
  Future<void> setEmail(String value, {bool isInitializing = false}) {
    return _$setEmailAsyncAction
        .run(() => super.setEmail(value, isInitializing: isInitializing));
  }

  final _$setPhotoUrlAsyncAction = AsyncAction('AppStoreBase.setPhotoUrl');

  @override
  Future<void> setPhotoUrl(String value, {bool isInitializing = false}) {
    return _$setPhotoUrlAsyncAction
        .run(() => super.setPhotoUrl(value, isInitializing: isInitializing));
  }

  final _$setEmailLoginAsyncAction = AsyncAction('AppStoreBase.setEmailLogin');

  @override
  Future<void> setEmailLogin(bool value, {bool isInitializing = false}) {
    return _$setEmailLoginAsyncAction
        .run(() => super.setEmailLogin(value, isInitializing: isInitializing));
  }

  final _$setTesterAsyncAction = AsyncAction('AppStoreBase.setTester');

  @override
  Future<void> setTester(bool value, {bool isInitializing = false}) {
    return _$setTesterAsyncAction
        .run(() => super.setTester(value, isInitializing: isInitializing));
  }

  final _$setIsLoadingAsyncAction = AsyncAction('AppStoreBase.setIsLoading');

  @override
  Future<void> setIsLoading(bool val) {
    return _$setIsLoadingAsyncAction.run(() => super.setIsLoading(val));
  }

  final _$addToFavAsyncAction = AsyncAction('AppStoreBase.addToFav');

  @override
  Future<void> addToFav({required String id}) {
    return _$addToFavAsyncAction.run(() => super.addToFav(id: id));
  }

  final _$removeFromFavAsyncAction = AsyncAction('AppStoreBase.removeFromFav');

  @override
  Future<void> removeFromFav({required String id}) {
    return _$removeFromFavAsyncAction.run(() => super.removeFromFav(id: id));
  }

  final _$AppStoreBaseActionController = ActionController(name: 'AppStoreBase');

  @override
  void setConnectionState(ConnectivityResult val) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setConnectionState');
    try {
      return super.setConnectionState(val);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedLanguage: ${selectedLanguage},
mSelectedGraphColor: ${mSelectedGraphColor},
mSelectedMarketType: ${mSelectedMarketType},
mDashboardType: ${mDashboardType},
mDefaultChart: ${mDefaultChart},
mDefaultTrendingCard: ${mDefaultTrendingCard},
mSelectedCurrency: ${mSelectedCurrency},
mIsLoading: ${mIsLoading},
isLoggedIn: ${isLoggedIn},
uid: ${uid},
firstName: ${firstName},
email: ${email},
photoUrl: ${photoUrl},
isEmailLogin: ${isEmailLogin},
isTester: ${isTester},
isLoading: ${isLoading},
isDarkMode: ${isDarkMode},
favCoinList: ${favCoinList},
connectivityResult: ${connectivityResult},
isNetworkConnected: ${isNetworkConnected}
    ''';
  }
}
