import 'di_export.dart';

GetIt getIt = GetIt.instance;
Future<void> initGetIt() async {
  Hive.initFlutter();

  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<WebServices>(() => WebServices(getIt<Dio>()));
  getIt.registerLazySingleton<HomeDataBaseServices>(
    () => HomeDataBaseServices(),
  );
  getIt.registerLazySingleton<HomeDateBaseProvider>(
    () => HomeDateBaseProvider(getIt<HomeDataBaseServices>()),
  );

  getIt.registerLazySingleton(() => InternetConnectionHelper());
  getIt.registerLazySingleton<GetProductRepo>(
    () => GetProductRepo(getIt<WebServices>(), getIt<HomeDateBaseProvider>()),
  );
}
