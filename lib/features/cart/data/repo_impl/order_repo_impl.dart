import 'package:dartz/dartz.dart';
import 'package:kshk/core/Services/database_service.dart';
import 'package:kshk/core/errors/failure.dart';
import 'package:kshk/core/utils/backend_endpoints.dart';
import 'package:kshk/core/utils/helper_functions/get_user_data.dart';
import 'package:kshk/features/cart/data/models/order_model.dart';
import 'package:kshk/features/cart/domain/repo/order_repo.dart';

class OrderRepoImpl extends OrderRepo {
  final DatabaseService fireStoreService;

  OrderRepoImpl({required this.fireStoreService});
  @override
  Future<Either<Failure, void>> placeOrder({
    required OrderModel orderModel,
  }) async {
    try {
      final path = '${BackendEndpoints.orders}/${getUserData().uid}/userOrders';
      await fireStoreService.addData(
        path: path,
        data: orderModel.toJson(),
        documentId: orderModel.id,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
