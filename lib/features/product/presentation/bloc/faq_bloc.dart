import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:di_sample/core/state/abs_normal_state.dart';
import 'package:di_sample/core/state/abs_state_extension.dart';
import 'package:di_sample/features/product/domain/repo/faq_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../core/config/injectable.dart';
import '../../../../core/state/abs_pagination_state.dart';
import '../../../../core/state/failure_state.dart';
import '../../domain/model/faq_model.dart';

part 'faq_event.dart';

part 'faq_state.dart';

@lazySingleton
class FaqBloc extends Bloc<FaqEvent, FaqImp> {
  FaqBloc() : super(FaqInitial()) {
    on<FaqFetchEvent>((event, emit) async {
      if (event.isToRefresh) {
        emit(
          state.copyWith(
            faqState: state.faqState.copyWith(
              data: [],
              absNormalStatus: AbsNormalStatus.loading,
            ),
          ),
        );
      }

      if (state.faqState.currentPage <= state.faqState.lastPage) {
        Either<dynamic, Failure> response = await getIt<FaqRepo>().getAllFAQ(
          pageNo: state.faqState.currentPage,
        );
        response.fold((l) {
          emit(
            state.copyWith(
                faqState: state.faqState.copyWith(
              absNormalStatus: AbsNormalStatus.success,
              data: getPaginationListData<Faqs>(
                stateData: state.faqState.data ?? [],
                isToRefresh: event.isToRefresh,
                l: l,
                fromJson: Faqs.fromJson,
              ),
              currentPage: getCurrentStatePage(l: l).currentPage,
              lastPage: getCurrentStatePage(l: l).lastPage,
              totalNo: getCurrentStatePage(l: l).total,
            )),
          );
        }, (r) {
          emit(
            state.copyWith(
                faqState: state.faqState.copyWith(
              failure: r,
              absNormalStatus: AbsNormalStatus.error,
            )),
          );
        });
      }
    });
  }
}
