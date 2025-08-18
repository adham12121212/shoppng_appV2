part of 'login_page_cubit.dart';

@immutable
sealed class LoginPageState {}

final class LoginPageInitial extends LoginPageState {}

final class LoginPageLoading extends LoginPageState {}

final class LoginPageSuccess extends LoginPageState {}

final class LoginPageError extends LoginPageState {
  final String message;
  LoginPageError({required this.message});
}


