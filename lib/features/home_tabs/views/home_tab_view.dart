import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';

import '../cubit/home_tabs_cubit.dart';
import 'broken_moneys/view/broken_moneys_view.dart';
import 'paper_moneys/view/paper_moneys_view.dart';

class HomeTabsView extends StatefulWidget {
  const HomeTabsView({Key? key}) : super(key: key);

  @override
  State<HomeTabsView> createState() => _HomeTabsViewState();
}

class _HomeTabsViewState extends State<HomeTabsView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeTabsCubit>(
      create: (context) => HomeTabsCubit(TabController(length: 2, vsync: this)),
      child: const _HomeTabsView(),
    );
  }
}

class _HomeTabsView extends StatelessWidget {
  const _HomeTabsView({Key? key}) : super(key: key);
  final String calculateBrokenMoneyTitle = 'Bozuk Para';
  final String calculatePaperMoneyTitle = 'Kağıt Para';
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeTabsCubit>();
    return Scaffold(
      body: TabBarView(
        controller: cubit.tabController,
        children: [BrokenMoneys(), PaperMoneys()],
      ),
      bottomNavigationBar: TabBar(
        dividerColor: context.appTheme.primaryColor,
        controller: cubit.tabController,
        tabs: [
          Tab(
            icon: const FaIcon(FontAwesomeIcons.coins),
            text: calculateBrokenMoneyTitle,
          ),
          Tab(
            icon: const Icon(Icons.money_rounded),
            text: calculatePaperMoneyTitle,
          ),
        ],
      ),
    );
  }
}
