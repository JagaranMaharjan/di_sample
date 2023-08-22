// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../../features/product/data/repo_impl/faq_repo_impl.dart' as _i7;
import '../../features/product/domain/repo/faq_repo.dart' as _i6;
import '../../features/product/presentation/bloc/faq_bloc.dart' as _i5;
import '../network/api_manager.dart' as _i3;
import '../network/api_request.dart' as _i4;
import '../service/shared_prefs_service.dart' as _i9;
import 'module/injection_module.dart' as _i10;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final customInjectionModule = _$CustomInjectionModule();
    gh.singleton<_i3.ApiManager>(_i3.ApiManager());
    gh.lazySingleton<_i4.ApiRequest>(() => _i4.ApiRequestImpl());
    gh.lazySingleton<_i5.FaqBloc>(() => _i5.FaqBloc());
    gh.lazySingleton<_i6.FaqRepo>(() => _i7.FaqRepoImpl());
    await gh.factoryAsync<_i8.SharedPreferences>(
      () => customInjectionModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i9.SharedPrefsService>(
        () => _i9.SharedPrefsServiceImpl());
    return this;
  }
}

class _$CustomInjectionModule extends _i10.CustomInjectionModule {}
