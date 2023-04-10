class BrokenMoneysCount {
  int? countMoney1;
  int? countMoney050;
  int? countMoney025;
  int? countMoney010;
  int? countMoney005;

  BrokenMoneysCount({
    this.countMoney1,
    this.countMoney050,
    this.countMoney025,
    this.countMoney010,
    this.countMoney005,
  });

  BrokenMoneysCount copyWith({
    int? countMoney1,
    int? countMoney050,
    int? countMoney025,
    int? countMoney010,
    int? countMoney005,
  }) {
    return BrokenMoneysCount(
      countMoney1: countMoney1 ?? this.countMoney1,
      countMoney050: countMoney050 ?? this.countMoney050,
      countMoney025: countMoney025 ?? this.countMoney025,
      countMoney010: countMoney010 ?? this.countMoney010,
      countMoney005: countMoney005 ?? this.countMoney005,
    );
  }
}
