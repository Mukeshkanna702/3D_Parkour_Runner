import 'package:get_it/get_it.dart';
import '../../features/splash/data/datasources/splash_local_datasource.dart';
import '../../features/splash/data/repositories/splash_repository_impl.dart';
import '../../features/splash/domain/repositories/splash_repository.dart';
import '../../features/splash/domain/usecases/initialize_app_usecase.dart';
import '../../features/splash/presentation/bloc/splash_bloc.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Data Sources
  sl.registerLazySingleton<SplashLocalDataSource>(() => SplashLocalDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(localDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => InitializeAppUseCase(sl()));

  // BLoCs
  sl.registerFactory(() => SplashBloc(initializeAppUseCase: sl()));
}
