part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class CheckForAuthentication extends AuthEvent{}

final class MannualCheckForAuthentication extends AuthEvent{}

final class SignInWithGoogleButtonPressed extends AuthEvent{}

final class SignOutButtonPressedEvent extends AuthEvent{}


