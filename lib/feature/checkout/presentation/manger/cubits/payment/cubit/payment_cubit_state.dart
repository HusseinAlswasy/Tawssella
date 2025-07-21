part of 'payment_cubit_cubit.dart';

@immutable
sealed class PaymentCubitState {}

final class PaymentCubitInitial extends PaymentCubitState {}

final class PaymentCubLoading extends PaymentCubitState {}

final class PaymentCubitSuccess extends PaymentCubitState {}

final class PaymentCubitFailuer extends PaymentCubitState {
  final String errorMesssage;

  PaymentCubitFailuer({required this.errorMesssage});
}
