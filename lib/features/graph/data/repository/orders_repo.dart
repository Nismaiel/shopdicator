import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:shopdicator/core/models/failure.dart';
import 'package:shopdicator/features/graph/data/model/orders_model.dart';
part '../../domain/repository/orders_repo_impl.dart';
abstract class OrdersRepository {
  Future<Either<Failure,List<OrdersModel>>> getOrders();
 Either<Failure,Map<int,int>>prepareGraph({required List<OrdersModel>orders});
}