part of '../../data/repository/orders_repo.dart';

class OrdersRepoImpl implements OrdersRepository {
  @override
  Future<Either<Failure, List<OrdersModel>>> getOrders() async {
    try {
      final String response = await rootBundle.loadString('assets/orders.json');
      final List<dynamic> data = json.decode(response);
      List<OrdersModel> orders = data
          .map<OrdersModel>(
            (e) => OrdersModel.fromJson(e),
          )
          .toList();
      return Right(orders);
    } catch (e, stack) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Either<Failure, Map<int, int>> prepareGraph(
      {required List<OrdersModel> orders}) {
    try {
      Map<int, int> graphPoints = {};
      for (var element in orders) {
        if (graphPoints.containsKey(element.registered.month)) {
          graphPoints[element.registered.month] =
              (graphPoints[element.registered.month] ?? 0) + 1;
        } else {
          graphPoints[element.registered.month] = 1;
        }
      }
      List<MapEntry<int, int>> sortedEntries = graphPoints.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));
      Map<int, int> sortedMap = Map.fromEntries(sortedEntries);
      return Right(sortedMap);
    } catch (e, stack) {
      return Left(Failure(e.toString()));
    }
  }
}
