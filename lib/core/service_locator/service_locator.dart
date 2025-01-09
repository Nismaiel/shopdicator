import 'package:get_it/get_it.dart';
import 'package:shopdicator/features/graph/data/repository/orders_repo.dart';
import 'package:shopdicator/features/graph/presentation/bloc/orders_bloc.dart';

final serviceLocator=GetIt.instance;

void setupServiceLocator(){
  serviceLocator.registerLazySingleton(() => OrdersRepoImpl());
  serviceLocator.registerLazySingleton(() => OrdersBloc());
 }