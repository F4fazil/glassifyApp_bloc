import 'package:equatable/equatable.dart';

abstract class Authevent extends Equatable {
  const Authevent();

  @override
  List<Object> get props => [];
}

class GoogleSignInRequested extends Authevent {}

class GoogleSignOutRequested extends Authevent {}

class SignInRequested extends Authevent {
  final String email;
  final String password;
  const SignInRequested(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}

class SignupIsRequested extends Authevent {
  final String email;
  final String password;
  const SignupIsRequested(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}

class LogoutIsRequested extends Authevent {

}
 

class SendOtpEvent extends Authevent {
  final String phoneNumber;
  const SendOtpEvent(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class VerifyOtpEvent extends Authevent {
  final String otp;
  final String verificationId;
  const VerifyOtpEvent(this.otp, this.verificationId);

  @override
  List<Object> get props => [otp, verificationId];
}
