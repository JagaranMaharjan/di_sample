import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SmartListViewWithPagination<T> extends StatefulWidget {
  final Function() onRefresh;
  final Function() onLoading;
  final bool isScrollable;
  final Widget child;
  final bool showRefresh;

  const SmartListViewWithPagination({
    Key? key,
    required this.onRefresh,
    required this.onLoading,
    required this.child,
    this.showRefresh = true,
    this.isScrollable = true,
  }) : super(key: key);

  @override
  State<SmartListViewWithPagination> createState() =>
      _SmartListViewWithPaginationState();
}

class _SmartListViewWithPaginationState
    extends State<SmartListViewWithPagination> {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: true,
      enablePullDown: widget.showRefresh,
      onRefresh: () async {
        widget.onRefresh();
        _refreshController.refreshCompleted();
      },
      onLoading: () async {
        widget.onLoading();
        _refreshController.loadComplete();
      },
      // enablePullDown: !widget.isChat,
      header: const WaterDropHeader(
        complete: SizedBox(),
      ),
      footer: CustomFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const SizedBox();
          } else if (mode == LoadStatus.loading) {
            body = const Center(
              child: CircularProgressIndicator(),
            );
          } else if (mode == LoadStatus.failed) {
            body = const Text("Load Failed! Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            body = const SizedBox();
          }
          return SizedBox(
            height: 55,
            child: Center(child: body),
          );
        },
      ),
      child: widget.child,
    );
  }
}
