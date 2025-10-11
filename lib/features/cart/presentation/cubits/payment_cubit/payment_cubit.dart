import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:kshk/features/cart/domain/repo/payment_repo.dart';
import 'package:meta/meta.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepo paymentRepo;
  PaymentCubit(this.paymentRepo) : super(PaymentInitial());


  Future<void> makePayment({
    required int selectedMethodIndex,
  required BuildContext context}) async {
    emit(PaymentLoading());
    try {
      await paymentRepo.handlePayment(selectedIndexMethod: selectedMethodIndex, context: context);
      emit(PaymentSuccess());
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }
}
