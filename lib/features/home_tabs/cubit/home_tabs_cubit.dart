import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_tabs_state.dart';

class HomeTabsCubit extends Cubit<HomeTabsState> {
  HomeTabsCubit(this.tabController) : super(HomeTabsInitial());

  final TabController tabController;
}
