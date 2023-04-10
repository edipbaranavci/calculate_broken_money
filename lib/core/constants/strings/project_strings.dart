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
  final String adsBannerId = 'ca-app-pub-7487352118674207/6510070395';
  final String adsBannerId2 = 'ca-app-pub-7487352118674207/7812114594';
  final String adsFullScreenId = 'ca-app-pub-7487352118674207/2162188668';
}
