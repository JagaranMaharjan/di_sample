import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SmartPullToRefresh extends StatefulWidget {
  final Widget child;
  final Function() onRefresh;
  final ScrollController? scrollController;
  final bool isToEnablePullToRefresh;

  const SmartPullToRefresh({
    Key? key,
    required this.child,
    required this.onRefresh,
    this.scrollController,
    this.isToEnablePullToRefresh = true,
  }) : super(key: key);

  @override
  State<SmartPullToRefresh> createState() => _SmartPullToRefreshState();
}

class _SmartPullToRefreshState extends State<SmartPullToRefresh> {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      physics: !widget.isToEnablePullToRefresh
          ? const NeverScrollableScrollPhysics()
          : null,
      scrollController: widget.scrollController,
      controller: _refreshController,
      enablePullUp: false,
      enablePullDown: widget.isToEnablePullToRefresh,
      onRefresh: widget.isToEnablePullToRefresh
          ? () async {
              widget.onRefresh();
              _refreshController.refreshCompleted();
            }
          : null,
      header: const WaterDropHeader(
        completeDuration: Duration(milliseconds: 100),
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
