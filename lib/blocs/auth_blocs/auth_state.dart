part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthenticatedState extends AuthState{}

final class UnAuthenticatedState extends AuthState{}

final class AuthLoadingState extends AuthState{}

final class AuthLodedState extends AuthState{}


