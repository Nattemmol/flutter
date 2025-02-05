part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();

  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  final MyUser? user;

  const AuthenticationUserChanged(this.user);

}
