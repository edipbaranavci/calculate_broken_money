import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../cubit/ads_cubit.dart';

class AdsBanner extends StatelessWidget {
  const AdsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdsCubit>(
      create: (context) => AdsCubit(),
      child: const _AdsBanner(),
    );
  }
}

class _AdsBanner extends StatelessWidget {
  const _AdsBanner();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdsCubit, AdsState>(
      builder: (context, state) {
        final bannerAd = state.bannerAd;
        if (bannerAd == null) {
          return const SizedBox.shrink();
        } else {
          return SizedBox(
            height: (bannerAd.size.height).toDouble(),
            width: (bannerAd.size.width).toDouble(),
            child: AdWidget(ad: bannerAd),
          );
        }
      },
    );
  }
}
