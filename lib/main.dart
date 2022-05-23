import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forestvpn_test/constants/ui_constants.dart';
import 'package:forestvpn_test/widgets/featured_news_widget.dart';
import 'package:forestvpn_test/widgets/latest_news_widget.dart';
import 'package:forestvpn_test/screens/viewmodels/news_screen_viewmodel.dart';
import 'package:get/get.dart';

import 'constants/assets.dart';

void main() {
  runApp(ForestVPNTestApp());
}

class ForestVPNTestApp extends StatelessWidget {
  final NewsScreenViewModel _vm = Get.put(NewsScreenViewModel());
  final _pageController = PageController(initialPage: 0);
  final _title = 'ForestVPN test';
  final _appBarTitle = 'Notifications';
  final _actionTitle = 'Mark all read';
  final _featuredNewsTitle = 'Featured';
  final _latestNewsTitle = 'Latest news';

  ForestVPNTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: _title,
      home: SafeArea(
        child: Scaffold(
          appBar: _appBar(),
          body: RefreshIndicator(
            displacement: 56.0,
            onRefresh: () => _vm.loadNews(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40.0),
                    Text(
                      _featuredNewsTitle,
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    _featuredNews(),
                    const SizedBox(height: 20.0),
                    Text(
                      _latestNewsTitle,
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Obx(
                      () => ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            LatestNewsWidget(_vm.latestNews[index]),
                        itemCount: _vm.latestNews.length,
                        scrollDirection: Axis.vertical,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(
        backgroundColor: UIConstants.lightGrayColor,
        leading: IconButton(
          icon: SvgPicture.asset(
            Assets.backArrow,
            color: Colors.black,
          ),
          onPressed: () => SystemNavigator.pop(),
        ),
        title: Text(
          _appBarTitle,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: _vm.markAllRead,
                child: Text(
                  _actionTitle,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          )
        ],
      );

  Widget _featuredNews() => Obx(
        () => SizedBox(
          height: 300.0,
          child: PageView(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              children: _vm.featuredNews
                  .map((item) => FeaturedNewsWidget(item))
                  .toList()),
        ),
      );
}
