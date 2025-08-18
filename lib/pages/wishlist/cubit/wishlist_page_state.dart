part of 'wishlist_page_cubit.dart';

@immutable
sealed class WishlistPageState {}

final class WishlistPageInitial extends WishlistPageState {}


final class WishlistLoadingInitial extends WishlistPageState {}
final class WishlistSuccessInitial extends WishlistPageState {}
final class WishlistErrorInitial extends WishlistPageState {
  WishlistErrorInitial({required this.message});
  final String message;
}

