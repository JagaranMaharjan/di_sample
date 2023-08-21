import 'abs_normal_state.dart';
import 'failure_state.dart';

abstract class AbsPaginationState<T> extends AbsNormalState<T> {
  final int currentPage, lastPage, totalRecord;
  final T? data;
  final Failure? failure;
  final AbsNormalStatus absNormalStatus;

  const AbsPaginationState({
    this.data,
    this.failure,
    required this.absNormalStatus,
    required this.currentPage,
    required this.lastPage,
    required this.totalRecord,
  }) : super(
          absNormalStatus: absNormalStatus,
          failure: failure,
          data: data,
        );
}

class AbsPaginationStateRefImpl<T, R> extends AbsPaginationStateImpl<T> {
  AbsPaginationStateRefImpl({
    T? data,
    Failure? failure,
    required AbsNormalStatus absNormalStatus,
    required int currentPage,
    lastPage,
    totalRecord,
  }) : super(
          absNormalStatus: absNormalStatus,
          failure: failure,
          data: data,
          lastPage: lastPage,
          currentPage: currentPage,
          totalRecord: totalRecord,
        );

  AbsPaginationStateRefImpl<T, R> copyWith({
    T? data,
    Failure? failure,
    AbsNormalStatus? absNormalStatus,
    int? currentPage,
    lastPage,
    totalNo,
  }) {
    return AbsPaginationStateRefImpl(
      data: data ?? this.data,
      absNormalStatus: absNormalStatus ?? this.absNormalStatus,
      failure: failure ?? this.failure,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      totalRecord: totalNo ?? this.totalRecord,
    );
  }

  factory AbsPaginationStateRefImpl.fromJson(
    Map<String, dynamic> json,
    Function fromJson,
  ) {
    return AbsPaginationStateRefImpl<T, R>(
      currentPage: json['currentPage'] ?? 1,
      absNormalStatus: AbsNormalStatus.success,
      data: json['data'] != null && json['data'] is List
          ? List.of(json['data']).isNotEmpty
              ? List.of(json['data'])
                  .where((e) => e != null)
                  .map<R>((e) => fromJson(e))
                  .toList()
              : <R>[]
          : json['data'],
      lastPage: json['lastPage'] ?? 1,
      totalRecord: json['totalRecord'] ?? 0,
      // failure: json['failure'],
    );
  }
}

class AbsPaginationStateImpl<T> extends AbsPaginationState<T>
    with MxAbsPaginationState<T> {
  AbsPaginationStateImpl({
    T? data,
    Failure? failure,
    required AbsNormalStatus absNormalStatus,
    required int currentPage,
    lastPage,
    totalRecord,
  }) : super(
          absNormalStatus: absNormalStatus,
          failure: failure,
          data: data,
          lastPage: lastPage,
          currentPage: currentPage,
          totalRecord: totalRecord,
        );

  AbsPaginationStateImpl<T> copyWith({
    T? data,
    Failure? failure,
    AbsNormalStatus? absNormalStatus,
    int? currentPage,
    lastPage,
    totalNo,
  }) {
    return AbsPaginationStateImpl(
      data: data ?? this.data,
      absNormalStatus: absNormalStatus ?? this.absNormalStatus,
      failure: failure ?? this.failure,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      totalRecord: totalNo ?? this.totalRecord,
    );
  }

  Map<String, dynamic> toJsonWithDynamicData(
      {required List<Map<String, dynamic>> data}) {
    return {
      'data': data,
      'absNormalStatus': absNormalStatus.toString(),
      'failure': failure,
      'currentPage': currentPage,
      'lastPage': lastPage,
      'totalRecord': totalRecord,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'absNormalStatus': absNormalStatus.toString(),
      'failure': failure,
      'currentPage': currentPage,
      'lastPage': lastPage,
      'totalRecord': totalRecord,
    };
  }

  @override
  List<Object?> get props => [
        data,
        failure,
        absNormalStatus,
        currentPage,
        lastPage,
        totalRecord,
      ];
}

class AbsPaginationInitialState<T> extends AbsPaginationStateImpl<T> {
  AbsPaginationInitialState()
      : super(
          absNormalStatus: AbsNormalStatus.initial,
          currentPage: 1,
          lastPage: 1,
          totalRecord: 0,
        );
}

class AbsPaginationRefreshState<T> extends AbsPaginationStateImpl<T> {
  AbsPaginationRefreshState(T data)
      : super(
          data: data,
          absNormalStatus: AbsNormalStatus.loading,
          currentPage: 1,
          lastPage: 1,
          totalRecord: 0,
        );
}

mixin MxAbsPaginationState<T> {
  AbsPaginationStateImpl<T> initialState(T data) {
    return AbsPaginationStateImpl<T>(
      absNormalStatus: AbsNormalStatus.initial,
      totalRecord: 0,
      lastPage: 1,
      currentPage: 1,
      data: data,
    );
  }

  AbsPaginationStateImpl<T> refreshState(T data) {
    return AbsPaginationStateImpl<T>(
      absNormalStatus: AbsNormalStatus.loading,
      totalRecord: 0,
      lastPage: 1,
      currentPage: 1,
      data: data,
    );
  }
}
