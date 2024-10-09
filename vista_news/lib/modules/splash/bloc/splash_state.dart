part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}

final class UnRegisteredState extends SplashState {}

final class RegisteredState extends SplashState {
  final User registerUserData;

  const RegisteredState({required this.registerUserData});
}
