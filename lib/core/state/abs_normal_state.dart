import 'package:equatable/equatable.dart';

import 'failure_state.dart';


enum AbsNormalStatus {
  initial,
  loading,
  error,
  success,
}

abstract class AbsNormalState<T> extends Equatable {
  final T? data;
  final Failure? failure;
  final AbsNormalStatus absNormalStatus;

  const AbsNormalState({
    this.failure,
    this.data,
    required this.absNormalStatus,
  });
}

class AbsNormalStateImpl<T> extends AbsNormalState<T> {
  const AbsNormalStateImpl({
    T? data,
    Failure? failure,
    required AbsNormalStatus absNormalStatus,
  }) : super(
          absNormalStatus: absNormalStatus,
          data: data,
          failure: failure,
        );

  AbsNormalStateImpl<T> copyWith({
    T? data,
    Failure? failure,
    AbsNormalStatus? absNormalStatus,
  }) {
    return AbsNormalStateImpl(
      failure: failure ?? this.failure,
      absNormalStatus: absNormalStatus ?? this.absNormalStatus,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [
        data,
        failure,
        absNormalStatus,
      ];

  Map<String, dynamic> toJson() => {
        "data": data,
        "failure": failure,
        "absNormalStatus": absNormalStatus.toString(),
      };
}

class AbsNormalStateImplWithRef<T, R> extends AbsNormalStateImpl<T> {
  AbsNormalStateImplWithRef({
    T? data,
    Failure? failure,
    required AbsNormalStatus absNormalStatus,
  }) : super(
          absNormalStatus: absNormalStatus,
          data: data,
          failure: failure,
        );

  AbsNormalStateImplWithRef<T, R> copyWith({
    T? data,
    Failure? failure,
    AbsNormalStatus? absNormalStatus,
  }) {
    return AbsNormalStateImplWithRef(
      failure: failure ?? this.failure,
      absNormalStatus: absNormalStatus ?? this.absNormalStatus,
      data: data ?? this.data,
    );
  }

  factory AbsNormalStateImplWithRef.fromJson(
      Map<String, dynamic> json, Function fromJson) {
    return AbsNormalStateImplWithRef(
      absNormalStatus: AbsNormalStatus.success,
      failure: json['failure'],
      data: json['data'] != null && json['data'] is List
          ? List.of(json['data']).isNotEmpty
              ? List.of(json['data'])
                  .where((e) => e != null)
                  .map<R>((e) => fromJson(e))
                  .toList()
              : <R>[]
          : json['data'],
    );
  }
}

class AbsNormalInitialState<T> extends AbsNormalStateImpl<T> {
  const AbsNormalInitialState()
      : super(
          absNormalStatus: AbsNormalStatus.initial,
        );
}

class AbsNormalRefreshState<T> extends AbsNormalStateImpl<T> {
  const AbsNormalRefreshState(T? data)
      : super(
          data: data,
          absNormalStatus: AbsNormalStatus.loading,
        );
}
