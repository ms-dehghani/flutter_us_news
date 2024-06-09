import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_us_news/res/color/ui_colors.dart';
import 'package:flutter_us_news/res/dimens/insets.dart';
import 'package:flutter_us_news/res/drawable/app_icons.dart';
import 'package:flutter_us_news/res/drawable/drawable.dart';
import 'package:flutter_us_news/res/drawable/item_splitter.dart';
import 'package:flutter_us_news/res/string/texts.dart';
import 'package:flutter_us_news/res/styles/text_style.dart';
import 'package:flutter_us_news/src/app/di/di.dart';
import 'package:flutter_us_news/src/app/logic/base/page_status.dart';
import 'package:flutter_us_news/src/app/logic/news/list/news_list_bloc.dart';
import 'package:flutter_us_news/src/app/logic/news/list/news_list_event.dart';
import 'package:flutter_us_news/src/app/logic/news/list/news_list_page_data.dart';
import 'package:flutter_us_news/src/app/ui/pages/empty/empty_screen.dart';
import 'package:flutter_us_news/src/app/ui/pages/error/error_screen.dart';
import 'package:flutter_us_news/src/app/ui/pages/news/item/news_item_screen.dart';
import 'package:flutter_us_news/src/app/ui/widgets/base/widget_view_template.dart';
import 'package:flutter_us_news/src/app/ui/widgets/image/image_view.dart';
import 'package:flutter_us_news/src/app/ui/widgets/items/list/news/news_list_item_view.dart';
import 'package:flutter_us_news/src/app/ui/widgets/items/list/trends/trend_list_item_view.dart';
import 'package:flutter_us_news/src/app/ui/widgets/progress/in_page_progress.dart';
import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';
import 'package:flutter_us_news/src/domain/dto/sort/sort_by.dart';
import 'package:flutter_us_news/src/domain/dto/trend/trend_item.dart';
import 'package:flutter_us_news/src/utils/device.dart';
import 'package:flutter_us_news/src/utils/extensions/translates_string_extensions.dart';
import 'package:flutter_us_news/src/utils/navigator.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen>
    with WidgetViewTemplate {
  final _listScrollController = ScrollController();

  final NewsListBloc _newsListBloc = NewsListBloc(
      newsListUseCase: DI.instance().getNewsListUseCase(),
      trendListUseCase: DI.instance().getTrendListUseCase());

  final queries = ["Microsoft", "Apple", "Google", "Tesla"];

  late int todayTimeStamp;
  late int yesterdayTimeStamp;

  @override
  void initState() {
    super.initState();
    _listScrollController.addListener(_onScrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) => _reload());
  }

  @override
  void dispose() {
    _listScrollController
      ..removeListener(_onScrollListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsListBloc>(
      create: (BuildContext context) => _newsListBloc,
      child: Scaffold(
          backgroundColor: UiColors.pageBackground,
          body: SafeArea(child: showPage(context))),
    );
  }

  @override
  Widget phoneView(BuildContext context) {
    return BlocBuilder<NewsListBloc, NewsListBlocPageData>(
      buildWhen: (previous, current) {
        return previous.pageStatus != current.pageStatus;
      },
      bloc: _newsListBloc,
      builder: (context, state) {
        return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: _page(state));
      },
    );
  }

  Widget _searchView() {
    return Container(
      height: Insets.searchViewHeight,
      width: getWidth(context) - Insets.med * 2,
      margin: EdgeInsets.symmetric(vertical: Insets.med),
      padding: EdgeInsets.all(Insets.xs),
      decoration: Drawable.searchEdittextDecoration,
      child: CupertinoTextField(
        padding: EdgeInsets.only(
          left: Insets.sm,
          right: Insets.sm,
        ),
        showCursor: true,
        placeholder: Texts.searchHint.translate,
        maxLines: 1,
        cursorColor: UiColors.primaryText,
        suffix: Padding(
          padding: EdgeInsets.symmetric(horizontal: Insets.med),
          child: ImageView(
            src: AppIcons.searchIcon,
            size: Insets.d24,
            color: UiColors.primaryText,
          ),
        ),
        placeholderStyle: TextStyles.h3.copyWith(color: UiColors.secondaryText),
        style: TextStyles.h3.copyWith(color: UiColors.primaryText),
        decoration: Drawable.searchEdittextDecoration,
      ),
    );
  }

  Widget _page(NewsListBlocPageData state) {
    if (state.pageStatus == PageStatus.loading) {
      if (state.newsList.isNotEmpty) {
        return _pageList(state.trendList, state.newsList, true);
      } else {
        return _loadingWidget(double.infinity);
      }
    } else if (state.pageStatus == PageStatus.success) {
      if (state.newsList.isNotEmpty) {
        return _pageList(state.trendList, state.newsList, false);
      } else {
        return _emptyView();
      }
    } else if (state.pageStatus == PageStatus.failure) {
      if (state.newsList.isNotEmpty) {
        return _pageList(state.trendList, state.newsList, false);
      } else {
        return _errorView();
      }
    }
    return _loadingWidget(double.infinity);
  }

  Widget _pageList(
      List<TrendItem> trendList, List<NewsItem> items, bool showLoading) {
    return Column(
      children: [
        _searchView(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              _reload();
              return Future.value();
            },
            child: ListView(
              controller: _listScrollController,
              children: [
                Padding(
                  padding: EdgeInsets.all(Insets.pagePadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Texts.walkWithTrends.translate,
                        style: TextStyles.h1Bold
                            .copyWith(color: UiColors.primaryText),
                      ),
                      Text(
                        Texts.walkWithTrendsDesc.translate,
                        style: TextStyles.h2
                            .copyWith(color: UiColors.secondaryText),
                      ),
                    ],
                  ),
                ),
                _trendList(trendList),
                ItemSplitter.ultraThickSplitter,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Insets.pagePadding),
                  child: Text(
                    Texts.topReadsOfTheDay.translate,
                    style:
                        TextStyles.h1Bold.copyWith(color: UiColors.primaryText),
                  ),
                ),
                _newsList(items, showLoading)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _trendList(List<TrendItem> trendList) {
    return Column(
      children: [
        SizedBox(
          height: Insets.trendListItemHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: index == 0 ? Insets.pagePadding : Insets.med,
                    right:
                        index < trendList.length - 1 ? 0 : Insets.pagePadding),
                child: TrendListItemView(
                  item: trendList[index],
                  onTap: (item) {},
                ),
              );
            },
            itemCount: trendList.length,
          ),
        ),
      ],
    );
  }

  Widget _newsList(List<NewsItem> items, bool showLoading) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        if (index < items.length) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Insets.pagePadding),
            child: NewsListItemView(
              item: items[index],
              onTap: (item) {
                navigateToPage(context, NewsItemScreen(newsID: item.id));
              },
            ),
          );
        } else {
          return _loadingWidget(Insets.backButtonHeight);
        }
      },
      itemCount: items.length + (showLoading ? 1 : 0),
    );
  }

  Widget _loadingWidget(double height) {
    return Container(
        width: double.infinity,
        height: height,
        color: UiColors.pageBackground,
        child: Center(child: InPageProgress()));
  }

  Widget _emptyView() {
    return EmptyScreen(
      width: double.infinity,
      height: double.infinity,
      onReload: () {
        _reload();
      },
    );
  }

  Widget _errorView() {
    return ErrorScreen(
      width: double.infinity,
      height: double.infinity,
      onReload: () {
        _reload();
      },
    );
  }

  void _onScrollListener() {
    if (isReachedToEnd()) {
      _newsListBloc.add(NewsListGetEvent(
          from: yesterdayTimeStamp,
          sortBy: SortBy.publishedDate,
          queries: queries,
          to: todayTimeStamp));
    }
  }

  void _reload() {
    _setTime();
    _newsListBloc.add(NewsListRefreshEvent(
        from: yesterdayTimeStamp,
        sortBy: SortBy.publishedDate,
        queries: queries,
        to: todayTimeStamp));
  }

  void _setTime() {
    todayTimeStamp = DateTime.now()
        .copyWith(hour: 23, minute: 59, second: 59)
        .millisecondsSinceEpoch;
    yesterdayTimeStamp =
        todayTimeStamp - const Duration(hours: 48).inMilliseconds;
  }

  bool isReachedToEnd() {
    if (!_listScrollController.hasClients) return false;
    final maxScroll = _listScrollController.position.maxScrollExtent;
    final currentScroll = _listScrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
