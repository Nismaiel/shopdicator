part of 'orders_bloc.dart';

class OrdersState {
  final OrdersStatus? status;
  final List<OrdersModel>? orders;
  final String? message;
  final Map<int, int>? graphPoints;

  OrdersState({this.status, this.orders, this.message, this.graphPoints});

  copyWith({
    OrdersStatus? status,
    List<OrdersModel>? orders,
    Map<int, int>? graphPoints,
    String? message,
  }) {
    return OrdersState(
      status: status ?? this.status,
      graphPoints: graphPoints ?? this.graphPoints,
      orders: orders ?? this.orders,
      message: message ?? this.message,
    );
  }

  OrdersState.initial()
      : this(
            status: OrdersStatus.initial,
            message: null,
            orders: [],
            graphPoints: {});

  getSpots() => graphPoints?.entries
      .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
      .toList();

  String getMonthName(int month) {
    List<String> monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    if (month < 1 || month > 12) {
      return "";
    }
    return monthNames[month - 1];
  }


  bool get isError => status == OrdersStatus.error;

  bool get isLoading => status == OrdersStatus.loading;

  bool get isLoaded => status == OrdersStatus.loaded;

  bool get isGraphLoaded => status == OrdersStatus.graphLoaded;
}

enum OrdersStatus { initial, loading, graphLoaded, loaded, error }
