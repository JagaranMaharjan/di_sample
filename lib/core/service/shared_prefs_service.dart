import 'package:di_sample/core/di/injectable.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPrefsService {
  bool hasKey({required String key});

  String? readKey({required String key});

  void storeValue({required String key, required String value});
}

@LazySingleton(as: SharedPrefsService)
class SharedPrefsServiceImpl implements SharedPrefsService {
  @override
  bool hasKey({required String key}) {
    return getIt<SharedPreferences>().containsKey(key);
  }

  @override
  String? readKey({required String key}) {
    return getIt<SharedPreferences>().getString(key);
  }

  @override
  void storeValue({required String key, required String value}) async {
    await getIt<SharedPreferences>().setString(key, value);
  }
}
