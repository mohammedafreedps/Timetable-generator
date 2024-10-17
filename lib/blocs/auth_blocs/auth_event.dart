part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class CheckForAuthentication extends AuthEvent{}

class MannualCheckForAuthentication extends AuthEvent{}

class SignInWithGoogleButtonPressed extends AuthEvent{}

class SignOutButtonPressedEvent extends AuthEvent{}


