import 'package:dartz/dartz.dart';

import '../../../../core/state/failure_state.dart';

abstract class FaqRepo {
  Future<Either<dynamic, Failure>> getAllFAQ({int pageNo = 1});
}
