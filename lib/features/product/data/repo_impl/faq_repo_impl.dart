import 'package:dartz/dartz.dart';
import 'package:di_sample/core/network/api_request.dart';
import 'package:di_sample/core/state/failure_state.dart';
import 'package:di_sample/features/product/domain/repo/faq_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/di/injectable.dart';

@LazySingleton(as: FaqRepo)
class FaqRepoImpl implements FaqRepo {
  static const String getFaqs = "/faqs/fetch";

  @override
  Future<Either<dynamic, Failure>> getAllFAQ({int pageNo = 1}) {
    return getIt<ApiRequest>().getResponse(
      endPoint: getFaqs,
      apiMethods: ApiMethods.get,
      queryParams: {
        'page': pageNo,
      },
    );
  }
}
