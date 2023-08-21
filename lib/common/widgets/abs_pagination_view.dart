import 'package:di_sample/common/widgets/smart_pagination_listview.dart';
import 'package:flutter/material.dart';

import '../../core/state/abs_normal_state.dart';

class AbsPaginationView<T> extends StatelessWidget {
  final bool isToHideRefresh;
  final AbsNormalStatus absNormalStatus;
  final Widget? initialWidget;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Widget? noDataWidget;
  final Widget child;
  final void Function() onTapToRefresh;
  final void Function() onLoading;
  final List<T> data;

  const AbsPaginationView({
    Key? key,
    required this.absNormalStatus,
    required this.data,
    required this.onTapToRefresh,
    required this.onLoading,
    required this.child,
    this.errorWidget,
    this.loadingWidget,
    this.isToHideRefresh = false,
    this.noDataWidget,
    this.initialWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (absNormalStatus) {
      case AbsNormalStatus.initial:
        if (initialWidget != null) {
          return initialWidget!;
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      case AbsNormalStatus.loading:
        if (loadingWidget != null) {
          return loadingWidget!;
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      case AbsNormalStatus.error:
        if (errorWidget != null) {
          return errorWidget!;
        } else {
          return Text("Something wrong");
        }
      case AbsNormalStatus.success:
        if (data.isEmpty && noDataWidget != null) {
          return noDataWidget!;
        } else if (data.isEmpty && noDataWidget == null) {
          return Center(
            child: Text("No Data"),
          );
        } else {
          return SmartListViewWithPagination(
            showRefresh: !isToHideRefresh,
            onRefresh: onTapToRefresh,
            onLoading: onLoading,
            child: child,
          );
        }
      default:
        return SizedBox.shrink();
    }
  }
}
