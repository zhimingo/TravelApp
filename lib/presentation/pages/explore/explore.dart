import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel/injection/injection.dart';
import 'package:travel/presentation/blocs/moment_pool/moment_pool_bloc.dart';

import './tabviews/tabviews.dart';
import './components/components.dart';

class Explore extends StatefulWidget {
  Explore({Key key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {

  TabController _tabController;
  final List<Widget> _tabs = [
    Tab(text: '国内'),
    Tab(text: '国外'),
    Tab(text: '话题'),
    Tab(text: '美食'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: ExploreAppBar(
          tabs: _tabs,
          controller: _tabController,
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
             BlocProvider<MomentPoolBloc>(
              create: (context) => getIt.get<MomentPoolBloc>()..add(InitializeMomentPool()),
              child: MomentTabView(),
            ),
             BlocProvider<MomentPoolBloc>(
              create: (context) => getIt.get<MomentPoolBloc>()..add(InitializeMomentPool()),
              child: MomentTabView(),
            ),
            TopicTabView(),
             BlocProvider<MomentPoolBloc>(
              create: (context) => getIt.get<MomentPoolBloc>()..add(InitializeMomentPool()),
              child: MomentTabView(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
