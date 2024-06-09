import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_us_news/res/color/ui_colors.dart';
import 'package:flutter_us_news/res/dimens/insets.dart';
import 'package:flutter_us_news/res/drawable/drawable.dart';
import 'package:flutter_us_news/res/drawable/item_splitter.dart';
import 'package:flutter_us_news/res/string/texts.dart';
import 'package:flutter_us_news/res/styles/text_style.dart';
import 'package:flutter_us_news/src/app/di/di.dart';
import 'package:flutter_us_news/src/app/logic/base/page_status.dart';
import 'package:flutter_us_news/src/app/logic/news/item/news_item_get_bloc.dart';
import 'package:flutter_us_news/src/app/logic/news/item/news_item_get_event.dart';
import 'package:flutter_us_news/src/app/logic/news/item/news_item_get_page_data.dart';
import 'package:flutter_us_news/src/app/ui/pages/empty/empty_screen.dart';
import 'package:flutter_us_news/src/app/ui/pages/error/error_screen.dart';
import 'package:flutter_us_news/src/app/ui/widgets/base/widget_view_template.dart';
import 'package:flutter_us_news/src/app/ui/widgets/buttons/back_button.dart';
import 'package:flutter_us_news/src/app/ui/widgets/buttons/flat_border_button.dart';
import 'package:flutter_us_news/src/app/ui/widgets/image/network_image_view.dart';
import 'package:flutter_us_news/src/app/ui/widgets/progress/in_page_progress.dart';
import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';
import 'package:flutter_us_news/src/utils/device.dart';
import 'package:flutter_us_news/src/utils/extensions/translates_string_extensions.dart';
import 'package:flutter_us_news/src/utils/status_bar_color.dart';
import 'package:flutter_us_news/src/utils/time_util.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItemScreen extends StatefulWidget {
  final String newsID;

  const NewsItemScreen({super.key, required this.newsID});

  @override
  State<NewsItemScreen> createState() => _NewsItemScreenState();
}

class _NewsItemScreenState extends State<NewsItemScreen>
    with WidgetViewTemplate {
  final NewsItemGetBloc _newsItemBloc =
      NewsItemGetBloc(newsItemUseCase: DI.instance().getNewsItemUseCase());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsItemGetBloc>(
      create: (BuildContext context) => _newsItemBloc,
      child: Scaffold(
          backgroundColor: UiColors.pageBackground,
          body: SafeArea(child: showPage(context))),
    );
  }

  @override
  Widget phoneView(BuildContext context) {
    return BlocBuilder<NewsItemGetBloc, NewsItemGetBlocPageData>(
      buildWhen: (previous, current) {
        return previous.pageStatus != current.pageStatus;
      },
      bloc: _newsItemBloc,
      builder: (context, state) {
        return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: _page(state));
      },
    );
  }

  Widget _page(NewsItemGetBlocPageData state) {
    if (state.pageStatus == PageStatus.loading) {
      return _loadingWidget(double.infinity);
    } else if (state.pageStatus == PageStatus.success) {
      if (state.newsItem != null) {
        return _newsDetailView(state.newsItem!);
      } else {
        return _emptyView();
      }
    } else if (state.pageStatus == PageStatus.failure) {
      return _errorView();
    }
    return _loadingWidget(double.infinity);
  }

  Widget _newsDetailView(NewsItem newsItem) {
    setStatusBarColor(UiColors.primaryDark, brightness: Brightness.light);
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: getHeight(context) / 3,
              floating: false,
              pinned: true,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppBarBackButton(
                  onTap: () {
                    Navigator.of(context).maybePop().then((value) {
                      setStatusBarColor(UiColors.pageBackground);
                    });
                  },
                ),
              ),
              backgroundColor: UiColors.primary,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                collapseMode: CollapseMode.parallax,
                background: NetworkImageView(
                  image: newsItem.image,
                  size: Size(getWidth(context), getHeight(context) / 4),
                  borderRadius: 0,
                ),
              ),
            ),
          ];
        },
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: Insets.pagePadding),
          children: [
            ItemSplitter.ultraThickSplitter,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_sourceItemView(newsItem), _dateItemView(newsItem)],
            ),
            ItemSplitter.thinSplitter,
            _titleItemView(newsItem),
            _authorItemView(newsItem),
            ItemSplitter.thinSplitter,
            _descriptionItemView(newsItem),
            ItemSplitter.thickSplitter,
            _loadFullContent(newsItem),
            ItemSplitter.thinSplitter,
          ],
        ),
      ),
    );
  }

  Widget _sourceItemView(NewsItem newsItem) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: Insets.d24, vertical: Insets.xs),
      decoration: Drawable.simpleRoundCorner(UiColors.primary),
      child: Text(
        newsItem.source,
        maxLines: 1,
        style: TextStyles.h3Bold.copyWith(color: UiColors.white),
      ),
    );
  }

  Widget _authorItemView(NewsItem newsItem) {
    return Visibility(
      visible: newsItem.author.isNotEmpty,
      child: Text(
        "${Texts.by.translate}: ${newsItem.author}",
        maxLines: 3,
        style: TextStyles.h3.copyWith(color: UiColors.secondaryText),
      ),
    );
  }

  Widget _titleItemView(NewsItem newsItem) {
    return Text(
      newsItem.title,
      maxLines: 3,
      style: TextStyles.h1Bold.copyWith(color: UiColors.primaryText),
    );
  }

  Widget _descriptionItemView(NewsItem newsItem) {
    return Text(
      newsItem.description,
      style: TextStyles.h2.copyWith(color: UiColors.secondaryText),
    );
  }

  Widget _dateItemView(NewsItem newsItem) {
    return Text(
      timeToText(newsItem.date),
      style: TextStyles.h3.copyWith(color: UiColors.secondaryText),
    );
  }

  Widget _loadFullContent(NewsItem newsItem) {
    return Visibility(
      visible: newsItem.url.isNotEmpty,
      child: Align(
        alignment: Alignment.center,
        child: FlatBorderButton(
            onTap: () async {
              try {
                await launchUrl(Uri.parse(newsItem.url));
              } catch (e) {}
            },
            borderColor: UiColors.borderColor,
            rippleColor: UiColors.primaryRipple,
            size: Size(getWidth(context) / 2, Insets.buttonHeight),
            child: Text(
              Texts.openFullArticle.translate,
              style: TextStyles.h3.copyWith(color: UiColors.primaryText),
            )),
      ),
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
        _loadData();
      },
    );
  }

  Widget _errorView() {
    return ErrorScreen(
      width: double.infinity,
      height: double.infinity,
      onReload: () {
        _loadData();
      },
    );
  }

  void _loadData() {
    _newsItemBloc.add(GetNewsItemEvent(widget.newsID));
  }
}
