import 'package:equatable/equatable.dart';

abstract class Authstate extends Equatable {
  const Authstate();
  @override
  List<Object> get props => [];
}

class AuthInitial extends Authstate {}

class AuthLoading extends Authstate {}

class Authenticated extends Authstate {}

class UnAuthenticated extends Authstate {}

class AuthError extends Authstate {
  final String error;
  const AuthError(this.error);
   @override
  List<Object> get props => [error];
}
