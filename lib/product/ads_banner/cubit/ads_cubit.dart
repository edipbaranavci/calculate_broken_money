import 'dart:developer';

import 'package:calculate_broken_money/core/constants/strings/project_strings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// import 'dart:math' as math show Random;

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit() : super(AdsInitial()) {
    _init();
  }

  void _init() {
    try {
      // final rndm = math.Random().nextBool();
      final bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: ProjectStrings.instance.adsBannerId,
        listener: BannerAdListener(
            onAdLoaded: (_) => emit(state.copyWith(isLoadedBannerAd: true)),
            onAdFailedToLoad: (ad, error) {
              // ignore: avoid_print
              print(
                  '${'-' * 100} \n ${error.code} \n ${error.message} \n ${'' * 100} \n');
              ad.dispose();
            }),
        request: const AdRequest(),
      );
      emit(state.copyWith(bannerAd: bannerAd));
      if (state.bannerAd != null) {
        state.bannerAd?.load();
      }
    } catch (e) {
      log('${'-' * 100} \n ${e.toString()} \n ${'' * 100} \n');
    }
  }
}
