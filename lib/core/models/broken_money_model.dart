// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive_flutter/hive_flutter.dart';

part 'broken_money_model.g.dart';

@HiveType(typeId: 0)
class BrokenMoneyModel {
  @HiveField(0)
  final double? brokenMoney_1;
  @HiveField(1)
  final double? brokenMoney_050;
  @HiveField(2)
  final double? brokenMoney_025;
  @HiveField(3)
  final double? brokenMoney_010;
  @HiveField(4)
  final double? brokenMoney_005;
  @HiveField(5)
  final String? date;
  @HiveField(6)
  final double? totalMoney;
  BrokenMoneyModel({
    required this.brokenMoney_1,
    required this.brokenMoney_050,
    required this.brokenMoney_025,
    required this.brokenMoney_010,
    required this.brokenMoney_005,
    required this.date,
    required this.totalMoney,
  });

  BrokenMoneyModel copyWith({
    double? brokenMoney_1,
    double? brokenMoney_050,
    double? brokenMoney_025,
    double? brokenMoney_010,
    double? brokenMoney_005,
    String? date,
    double? totalMoney,
  }) {
    return BrokenMoneyModel(
      brokenMoney_1: brokenMoney_1 ?? this.brokenMoney_1,
      brokenMoney_050: brokenMoney_050 ?? this.brokenMoney_050,
      brokenMoney_025: brokenMoney_025 ?? this.brokenMoney_025,
      brokenMoney_010: brokenMoney_010 ?? this.brokenMoney_010,
      brokenMoney_005: brokenMoney_005 ?? this.brokenMoney_005,
      date: date ?? this.date,
      totalMoney: totalMoney ?? this.totalMoney,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brokenMoney_1': brokenMoney_1,
      'brokenMoney_050': brokenMoney_050,
      'brokenMoney_025': brokenMoney_025,
      'brokenMoney_010': brokenMoney_010,
      'brokenMoney_005': brokenMoney_005,
      'date': date,
      'totalMoney': totalMoney,
    };
  }

  factory BrokenMoneyModel.fromMap(Map<String, dynamic> map) {
    return BrokenMoneyModel(
      brokenMoney_1: map['brokenMoney_1'] as double,
      brokenMoney_050: map['brokenMoney_050'] as double,
      brokenMoney_025: map['brokenMoney_025'] as double,
      brokenMoney_010: map['brokenMoney_010'] as double,
      brokenMoney_005: map['brokenMoney_005'] as double,
      date: map['date'] as String,
      totalMoney: map['totalMoney'] as double,
    );
  }

  @override
  String toString() {
    return 'BrokenMoneyModel(brokenMoney_1: $brokenMoney_1, brokenMoney_050: $brokenMoney_050, brokenMoney_025: $brokenMoney_025, brokenMoney_010: $brokenMoney_010, brokenMoney_005: $brokenMoney_005, date: $date, totalMoney: $totalMoney)';
  }

  @override
  bool operator ==(covariant BrokenMoneyModel other) {
    if (identical(this, other)) return true;

    return other.brokenMoney_1 == brokenMoney_1 &&
        other.brokenMoney_050 == brokenMoney_050 &&
        other.brokenMoney_025 == brokenMoney_025 &&
        other.brokenMoney_010 == brokenMoney_010 &&
        other.brokenMoney_005 == brokenMoney_005 &&
        other.date == date &&
        other.totalMoney == totalMoney;
  }

  @override
  int get hashCode {
    return brokenMoney_1.hashCode ^
        brokenMoney_050.hashCode ^
        brokenMoney_025.hashCode ^
        brokenMoney_010.hashCode ^
        brokenMoney_005.hashCode ^
        date.hashCode ^
        totalMoney.hashCode;
  }
}
