import 'package:di_sample/core/config/injectable.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// VARs [getIt] : get instance of get it
final getIt = GetIt.instance;


/// [InjectableInit] : inform this is the start point
/// it gets get it instance to use inside generated class
@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)

/// FUNC [configureDependencies] : pass generated get it instance to it
Future<void> configureDependencies() async=> getIt.init();


/// flutter packages pub run build_runner build — delete-conflicting-outputs
/// flutter packages pub run build_runner watch — delete-conflicting-outputs