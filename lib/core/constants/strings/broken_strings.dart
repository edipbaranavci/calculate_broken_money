class BrokenStrings {
  static BrokenStrings? _instance;
  // Avoid self isntance
  BrokenStrings._();
  static BrokenStrings get instance {
    _instance ??= BrokenStrings._();
    return _instance!;
  }

  final String moneyCategoryTitle = 'Para Cinsi';
  final String moneyCountTitle = 'Adet';
  final String moneyGramTitle = 'Gram';
  final String moneyResultTitle = 'Sonuç';
  final String moneyCalculateButtonTitle = 'Para Hesapla';
  final String pageTitle = 'Bozuk Para Hesaplarım';
  final String deleteButtomTitle = 'Sil';
  final String totalTitle = 'Total';
  final String emptyBoxMessage = 'Hesaplanmış Bozuk Para Bulunamadı!';
  final String screenTitle = 'Bozuk Para Hesapla';
  final String submitButtonTitle = 'Kaydet';
  final String fabTitle = 'Bozuk Para Hesapla';
  final String submittedMessage = 'Paranız Hesaplandı!';
}
