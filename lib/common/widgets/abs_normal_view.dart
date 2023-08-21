

import 'package:di_sample/common/widgets/smart_pull_to_refresh.dart';
import 'package:flutter/material.dart';

import '../../core/state/abs_normal_state.dart';

class AbsNormalView extends StatelessWidget {
  final AbsNormalStatus absNormalStatus;
  final List<dynamic>? data;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Widget? noDataWidget;
  final Widget child;
  final void Function() onTapToRefresh;
  final bool isToEnablePullToRefresh;

  const AbsNormalView({
    Key? key,
    required this.absNormalStatus,
    required this.onTapToRefresh,
    required this.child,
    this.data,
    this.errorWidget,
    this.loadingWidget,
    this.noDataWidget,
    this.isToEnablePullToRefresh = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (absNormalStatus) {
      case AbsNormalStatus.initial:
        return SizedBox.shrink();
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
        return data != null && data!.isEmpty
            ? Center(
                child: noDataWidget != null ? noDataWidget : Text("No Data"),
              )
            : isToEnablePullToRefresh
                ? SmartPullToRefresh(
                    isToEnablePullToRefresh: isToEnablePullToRefresh,
                    child: child,
                    onRefresh: onTapToRefresh,
                  )
                : child;
      default:
        return SizedBox.shrink();
    }
  }
}
