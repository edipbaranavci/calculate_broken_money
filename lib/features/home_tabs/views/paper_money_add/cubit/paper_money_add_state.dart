part of 'paper_money_add_cubit.dart';

class PaperMoneyAddState extends Equatable {
  const PaperMoneyAddState({
    this.result5 = '0',
    this.result10 = '0',
    this.result20 = '0',
    this.result50 = '0',
    this.result100 = '0',
    this.result200 = '0',
    this.totalMoney = '0',
  });

  final String result5;
  final String result10;
  final String result20;
  final String result50;
  final String result100;
  final String result200;
  final String totalMoney;

  @override
  List<Object> get props => [
        result5,
        result10,
        result20,
        result50,
        result100,
        result200,
        totalMoney,
      ];

  PaperMoneyAddState copyWith({
    String? result5,
    String? result10,
    String? result20,
    String? result50,
    String? result100,
    String? result200,
    String? totalMoney,
  }) {
    return PaperMoneyAddState(
      result5: result5 ?? this.result5,
      result10: result10 ?? this.result10,
      result20: result20 ?? this.result20,
      result50: result50 ?? this.result50,
      result100: result100 ?? this.result100,
      result200: result200 ?? this.result200,
      totalMoney: totalMoney ?? this.totalMoney,
    );
  }
}

class PaperMoneyAddInitial extends PaperMoneyAddState {}
