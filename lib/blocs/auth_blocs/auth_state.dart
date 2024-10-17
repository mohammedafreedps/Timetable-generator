part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthenticatedState extends AuthState{}

class UnAuthenticatedState extends AuthState{}

class AuthLoadingState extends AuthState{}

class AuthLodedState extends AuthState{}


