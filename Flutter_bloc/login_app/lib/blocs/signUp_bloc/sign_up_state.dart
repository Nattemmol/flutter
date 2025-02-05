part of 'sign_up_bloc.dart';


sealed class SignUpState {
  const SignUpState();

  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState{}
class SignUpFailure extends SignUpState{}
class SignUpProcess extends SignUpState{}