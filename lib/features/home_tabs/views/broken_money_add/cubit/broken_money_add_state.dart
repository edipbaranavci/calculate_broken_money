// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'broken_money_add_cubit.dart';

class BrokenMoneyAddState extends Equatable {
  const BrokenMoneyAddState({
    this.resultMoney1 = '0',
    this.resultMoney050 = '0',
    this.resultMoney025 = '0',
    this.resultMoney010 = '0',
    this.resultMoney005 = '0',
    this.totalMoney = '0',
  });

  final String resultMoney1;
  final String resultMoney050;
  final String resultMoney025;
  final String resultMoney010;
  final String resultMoney005;
  final String totalMoney;

  @override
  List<Object> get props {
    return [
      resultMoney1,
      resultMoney050,
      resultMoney025,
      resultMoney010,
      resultMoney005,
      totalMoney,
    ];
  }

  BrokenMoneyAddState copyWith({
    String? resultMoney1,
    String? resultMoney050,
    String? resultMoney025,
    String? resultMoney010,
    String? resultMoney005,
    String? totalMoney,
  }) {
    return BrokenMoneyAddState(
      resultMoney1: resultMoney1 ?? this.resultMoney1,
      resultMoney050: resultMoney050 ?? this.resultMoney050,
      resultMoney025: resultMoney025 ?? this.resultMoney025,
      resultMoney010: resultMoney010 ?? this.resultMoney010,
      resultMoney005: resultMoney005 ?? this.resultMoney005,
      totalMoney: totalMoney ?? this.totalMoney,
    );
  }
}

class BrokenMoneyAddInitial extends BrokenMoneyAddState {}
