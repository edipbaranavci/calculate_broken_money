class ProjectStrings {
  static ProjectStrings? _instance;
  static ProjectStrings get instance {
    _instance ??= ProjectStrings._init();
    return _instance!;
  }

  ProjectStrings._init();
  final String appTitle = 'Para Hesapla';
  final String brokenMoneyBoxTitle = 'brokenMoney';
  final String paperMoneyBoxTitle = 'paperMoney';
  final String adsBannerId = 'ca-app-pub-7487352118674207/2460700662';
}
