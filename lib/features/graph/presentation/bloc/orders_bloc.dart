import 'dart:async';
import 'dart:developer';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopdicator/core/service_locator/service_locator.dart';
import 'package:shopdicator/features/graph/data/model/orders_model.dart';
import 'package:shopdicator/features/graph/data/repository/orders_repo.dart';

part 'orders_event.dart';

part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  static OrdersBloc get(context) => BlocProvider.of(context);

  OrdersBloc() : super(OrdersState.initial()) {
    on<GetOrdersEvent>(onGetOrdersEvent);
    on<GetGraphPoints>(onGetGraphPoints);
  }

  final ordersRepository = serviceLocator<OrdersRepoImpl>();

  FutureOr<void> onGetOrdersEvent(
      GetOrdersEvent event, Emitter<OrdersState> emit) async {
    emit(state.copyWith(status: OrdersStatus.loading));
    final result = await ordersRepository.getOrders();

    result.fold(
      (failure) => emit(
          state.copyWith(status: OrdersStatus.error, message: failure.message)),
      (orders) =>
          emit(state.copyWith(status: OrdersStatus.loaded, orders: orders)),
    );
  }

  FutureOr<void> onGetGraphPoints(
      GetGraphPoints event, Emitter<OrdersState> emit) {
    emit(state.copyWith(status: OrdersStatus.loading));
    final result = ordersRepository.prepareGraph(orders: state.orders ?? []);
    result.fold(
      (failure) => emit(
          state.copyWith(status: OrdersStatus.error, message: failure.message)),
      (graphPoints) => emit(state.copyWith(
          status: OrdersStatus.graphLoaded, graphPoints: graphPoints)),
    );
  }

  String getTotalPrice() {
    double total = state.orders?.fold(
            0,
            (previousValue, element) =>
                (previousValue ?? 0) + (element.price ?? 0)) ??
        0;
    return total.toStringAsFixed(2);
  }

  String getTotalReturns() {
    int totalReturns = 0;
    for (OrdersModel order in state.orders ?? []) {
      if (order.isReturned) {
        totalReturns++;
      }
    }
    return totalReturns.toStringAsFixed(2);
  }

  String getAveragePrice() {
    return ((double.tryParse(getTotalPrice()) ?? 0) /
            (state.orders?.length ?? 0))
        .toStringAsFixed(2);
  }
}
