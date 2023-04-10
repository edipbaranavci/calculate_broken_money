// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive_flutter/hive_flutter.dart';

part 'paper_money_model.g.dart';

@HiveType(typeId: 1)
class PaperMoneyModel {
  @HiveField(0)
  final int papaperMoney5;
  @HiveField(1)
  final int papaperMoney10;
  @HiveField(2)
  final int papaperMoney20;
  @HiveField(3)
  final int papaperMoney50;
  @HiveField(4)
  final int papaperMoney100;
  @HiveField(5)
  final int papaperMoney200;
  @HiveField(6)
  final int totalMoney;
  @HiveField(7)
  final String date;
  PaperMoneyModel({
    required this.papaperMoney5,
    required this.papaperMoney10,
    required this.papaperMoney20,
    required this.papaperMoney50,
    required this.papaperMoney100,
    required this.papaperMoney200,
    required this.totalMoney,
    required this.date,
  });

  PaperMoneyModel copyWith({
    int? papaperMoney5,
    int? papaperMoney10,
    int? papaperMoney20,
    int? papaperMoney50,
    int? papaperMoney100,
    int? papaperMoney200,
    int? totalMoney,
    String? date,
  }) {
    return PaperMoneyModel(
      papaperMoney5: papaperMoney5 ?? this.papaperMoney5,
      papaperMoney10: papaperMoney10 ?? this.papaperMoney10,
      papaperMoney20: papaperMoney20 ?? this.papaperMoney20,
      papaperMoney50: papaperMoney50 ?? this.papaperMoney50,
      papaperMoney100: papaperMoney100 ?? this.papaperMoney100,
      papaperMoney200: papaperMoney200 ?? this.papaperMoney200,
      totalMoney: totalMoney ?? this.totalMoney,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'papaperMoney5': papaperMoney5,
      'papaperMoney10': papaperMoney10,
      'papaperMoney20': papaperMoney20,
      'papaperMoney50': papaperMoney50,
      'papaperMoney100': papaperMoney100,
      'papaperMoney200': papaperMoney200,
      'totalMoney': totalMoney,
      'date': date,
    };
  }

  factory PaperMoneyModel.fromMap(Map<String, dynamic> map) {
    return PaperMoneyModel(
      papaperMoney5: map['papaperMoney5'] as int,
      papaperMoney10: map['papaperMoney10'] as int,
      papaperMoney20: map['papaperMoney20'] as int,
      papaperMoney50: map['papaperMoney50'] as int,
      papaperMoney100: map['papaperMoney100'] as int,
      papaperMoney200: map['papaperMoney200'] as int,
      totalMoney: map['totalMoney'] as int,
      date: map['date'] as String,
    );
  }
  @override
  String toString() {
    return 'PaperMoneyModel(papaperMoney5: $papaperMoney5, papaperMoney10: $papaperMoney10, papaperMoney20: $papaperMoney20, papaperMoney50: $papaperMoney50, papaperMoney100: $papaperMoney100, papaperMoney200: $papaperMoney200, totalMoney: $totalMoney, date: $date)';
  }

  @override
  bool operator ==(covariant PaperMoneyModel other) {
    if (identical(this, other)) return true;

    return other.papaperMoney5 == papaperMoney5 &&
        other.papaperMoney10 == papaperMoney10 &&
        other.papaperMoney20 == papaperMoney20 &&
        other.papaperMoney50 == papaperMoney50 &&
        other.papaperMoney100 == papaperMoney100 &&
        other.papaperMoney200 == papaperMoney200 &&
        other.totalMoney == totalMoney &&
        other.date == date;
  }

  @override
  int get hashCode {
    return papaperMoney5.hashCode ^
        papaperMoney10.hashCode ^
        papaperMoney20.hashCode ^
        papaperMoney50.hashCode ^
        papaperMoney100.hashCode ^
        papaperMoney200.hashCode ^
        totalMoney.hashCode ^
        date.hashCode;
  }
}
