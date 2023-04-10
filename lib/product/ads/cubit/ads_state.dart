part of 'ads_cubit.dart';

class AdsState extends Equatable {
  const AdsState({this.bannerAd, this.isLoadedBannerAd = false});

  final BannerAd? bannerAd;
  final bool isLoadedBannerAd;

  @override
  List<Object> get props => [
        bannerAd ?? BannerAd,
        isLoadedBannerAd,
      ];

  AdsState copyWith({
    BannerAd? bannerAd,
    bool? isLoadedBannerAd,
  }) {
    return AdsState(
      bannerAd: bannerAd ?? this.bannerAd,
      isLoadedBannerAd: isLoadedBannerAd ?? this.isLoadedBannerAd,
    );
  }
}

class AdsInitial extends AdsState {}
