// ignore_for_file: public_member_api_docs, sort_constructors_first
class BrokenMoneyGram {
  final double? gram1;
  final double? gram050;
  final double? gram025;
  final double? gram010;
  final double? gram005;
  BrokenMoneyGram({
    this.gram1,
    this.gram050,
    this.gram025,
    this.gram010,
    this.gram005,
  });

  BrokenMoneyGram copyWith({
    double? gram1,
    double? gram050,
    double? gram025,
    double? gram010,
    double? gram005,
  }) {
    return BrokenMoneyGram(
      gram1: gram1 ?? this.gram1,
      gram050: gram050 ?? this.gram050,
      gram025: gram025 ?? this.gram025,
      gram010: gram010 ?? this.gram010,
      gram005: gram005 ?? this.gram005,
    );
  }

  @override
  String toString() {
    return 'BrokenMoneyGram(gram1: $gram1, gram050: $gram050, gram025: $gram025, gram010: $gram010, gram005: $gram005)';
  }
}
