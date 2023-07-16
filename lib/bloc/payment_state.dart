part of 'payment_cubit.dart';

enum PaymentStatus { initial, success, error, loading }

extension PaymentStatusX on PaymentStatus {
  bool get isInitial => this == PaymentStatus.initial;
  bool get isSuccess => this == PaymentStatus.success;
  bool get isError => this == PaymentStatus.error;
  bool get isLoading => this == PaymentStatus.loading;
}

class PaymentState extends Equatable {
  const PaymentState({
    this.status = PaymentStatus.initial,
    List<PaymentHive>? payments,
  }) : payments = payments ?? const [];

  final PaymentStatus? status;
  final List<PaymentHive> payments;

  @override
  List<Object?> get props => [status, payments];

  PaymentState copyWith({
    List<PaymentHive>? payments,
    PaymentStatus? status,
  }) {
    return PaymentState(
      payments: payments ?? this.payments,
      status: status ?? this.status,
    );
  }
}
