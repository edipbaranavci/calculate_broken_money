class PaperStrings {
  static PaperStrings? _instance;
  // Avoid self isntance
  PaperStrings._();
  static PaperStrings get instance {
    _instance ??= PaperStrings._();
    return _instance!;
  }

  final String pageTitle = 'Kağıt Para Hesaplarım';
  final String emptyBoxMessage = 'Hesaplanmış Kağıt Para Bulunamadı!';
  final String moneyCategoryTitle = 'Para Cinsi';
  final String moneyCountTitle = 'Adet';
  final String moneyResultTitle = 'Sonuç';
  final String deleteButtomTitle = 'Sil';
  final String totalTitle = 'Total';
  final String screenTitle = 'Kağıt Para Hesapla';
  final String submitButtonTitle = 'Kaydet';
  final String fabTitle = 'Kağıt Para Hesapla';
  final String submittedMessage = 'Paranız Hesaplandı!';
}
