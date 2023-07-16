import 'package:budget_app/models/payment_hive.dart';
import 'package:budget_app/repository/payment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part '../bloc/payment_state.dart';
// part '../bloc/payment_event.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({
    required this.paymentRepository,
  }) : super(const PaymentState());

  final PaymentRepository paymentRepository;

  Future<void> getPayments() async {
    emit(state.copyWith(status: PaymentStatus.loading));

    try {
      final payments = await paymentRepository.getPayments();
      emit(
        state.copyWith(status: PaymentStatus.success, payments: payments),
      );
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(status: PaymentStatus.error));
    }
  }

  @override
  void onChange(Change<PaymentState> change) {
    super.onChange(change);

    var statusChange = Change(
        currentState: change.currentState.status,
        nextState: change.nextState.status);
    print('${this.runtimeType} changed: $statusChange');
  }

  // void _maptGetPaymentsEventToState(
  //     GetPayments event, Emitter<PaymentState> emit) async {
  //   emit(state.copyWith(status: PaymentStatus.loading));
  //   try {
  //     final payments = await paymentRepository.getPayments();
  //     emit(
  //       state.copyWith(status: PaymentStatus.success, payments: payments),
  //     );
  //   } catch (error, stacktrace) {
  //     print(stacktrace);
  //     emit(state.copyWith(status: PaymentStatus.error));
  //   }
  // }
}
