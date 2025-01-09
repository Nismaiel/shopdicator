part of 'orders_bloc.dart';

@immutable
sealed class OrdersEvent {}

class GetOrdersEvent extends OrdersEvent {}

class GetGraphPoints extends OrdersEvent {}
