import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:kshk/features/cart/domain/repo/order_repo.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo orderRepo;
  OrderCubit(this.orderRepo) : super(OrderInitial());

  Future<void> placeOrder({required orderModel}) async {
    emit(OrderLoading());
    Either failureOrSuccess = await orderRepo.placeOrder(
      orderModel: orderModel,
    );
    failureOrSuccess.fold(
      (failure) => emit(OrderFailure(failure.message)),
      (success) => emit(OrderSuccess()),
    );
  }
}
