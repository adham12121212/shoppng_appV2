part of 'cart_page_cubit.dart';

@immutable
sealed class CartPageState {}

final class CartPageInitial extends CartPageState {}


final class CartLoadingInitial extends CartPageState {}
final class CartSuccessInitial extends CartPageState {}
final class CartErrorInitial extends CartPageState {
  CartErrorInitial({required this.message});
  final String message;
}

