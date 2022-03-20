// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CoinStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CoinStore on CoinStoreBase, Store {
  final _$selectedSortTypeAtom = Atom(name: 'CoinStoreBase.selectedSortType');

  @override
  SortingTypeModel? get selectedSortType {
    _$selectedSortTypeAtom.reportRead();
    return super.selectedSortType;
  }

  @override
  set selectedSortType(SortingTypeModel? value) {
    _$selectedSortTypeAtom.reportWrite(value, super.selectedSortType, () {
      super.selectedSortType = value;
    });
  }

  final _$selectedIntervalTypeAtom =
      Atom(name: 'CoinStoreBase.selectedIntervalType');

  @override
  SortingTypeModel? get selectedIntervalType {
    _$selectedIntervalTypeAtom.reportRead();
    return super.selectedIntervalType;
  }

  @override
  set selectedIntervalType(SortingTypeModel? value) {
    _$selectedIntervalTypeAtom.reportWrite(value, super.selectedIntervalType,
        () {
      super.selectedIntervalType = value;
    });
  }

  final _$setSelectedSortTypeAsyncAction =
      AsyncAction('CoinStoreBase.setSelectedSortType');

  @override
  Future<dynamic> setSelectedSortType(int value) {
    return _$setSelectedSortTypeAsyncAction
        .run(() => super.setSelectedSortType(value));
  }

  final _$setSelectedIntervalTypeAsyncAction =
      AsyncAction('CoinStoreBase.setSelectedIntervalType');

  @override
  Future<dynamic> setSelectedIntervalType(int value) {
    return _$setSelectedIntervalTypeAsyncAction
        .run(() => super.setSelectedIntervalType(value));
  }

  @override
  String toString() {
    return '''
selectedSortType: ${selectedSortType},
selectedIntervalType: ${selectedIntervalType}
    ''';
  }
}
