import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:outclass/injectable.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
void configureInjection(String env) => getIt.init(environment: env);
