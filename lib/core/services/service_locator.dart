import 'package:get_it/get_it.dart';

// Splash Feature
import '../../features/splash/data/datasources/splash_local_datasource.dart';
import '../../features/splash/data/repositories/splash_repository_impl.dart';
import '../../features/splash/domain/repositories/splash_repository.dart';
import '../../features/splash/domain/usecases/initialize_app_usecase.dart';
import '../../features/splash/presentation/bloc/splash_bloc.dart';

// Login Feature
import '../../features/login/data/datasources/login_remote_datasource.dart';
import '../../features/login/data/repositories/login_repository_impl.dart';
import '../../features/login/domain/repositories/login_repository.dart';
import '../../features/login/domain/usecases/login_usecase.dart';
import '../../features/login/presentation/bloc/login_bloc.dart';

// Home Feature
import '../../features/home/data/datasources/home_remote_datasource.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_lobby_state_usecase.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // --- SPLASH FEATURE ---
  sl.registerLazySingleton<SplashLocalDataSource>(() => SplashLocalDataSourceImpl());
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton(() => InitializeAppUseCase(sl()));
  sl.registerFactory(() => SplashBloc(initializeAppUseCase: sl()));

  // --- LOGIN FEATURE ---
  sl.registerLazySingleton<LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl());
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));

  // --- HOME FEATURE ---
  sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl());
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetLobbyStateUseCase(sl()));
  sl.registerFactory(() => HomeBloc(getLobbyStateUseCase: sl()));
}
