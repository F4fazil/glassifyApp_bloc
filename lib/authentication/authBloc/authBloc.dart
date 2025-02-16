import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/authentication/authState/authState.dart';
import 'package:flutterbloc/authentication/events/authEvent.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authbloc extends Bloc<Authevent, Authstate> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Authbloc() : super(AuthInitial()) {
    on<SignInRequested>(_signIn);
    on<SignupIsRequested>(_signUp);
    on<LogoutIsRequested>(_logOut);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<GoogleSignOutRequested>(_onSignOutRequested);
     on<SendOtpEvent>(_onSendOtpEvent);
    on<VerifyOtpEvent>(_onVerifyOtpEvent);
    
  }


  Future<void> _onSendOtpEvent(
  SendOtpEvent event,
  Emitter<Authstate> emit,
) async {
  emit(AuthLoading());
  try {
    await _auth.verifyPhoneNumber(
      phoneNumber: event.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        emit(GoogleAuthenticated(_auth.currentUser!));
      },
      verificationFailed: (FirebaseAuthException e) {
        emit(AuthError(e.message ?? 'Verification failed'));
      },
      codeSent: (String verificationId, int? resendToken) {
        emit(OtpSentState(verificationId));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout if needed
      },
    );
  } catch (e) {
    emit(AuthError(e.toString()));
  }
}

  Future<void> _onVerifyOtpEvent(
    VerifyOtpEvent event,
    Emitter<Authstate> emit,
  ) async {
    emit(AuthLoading());
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.otp,
      );
      await _auth.signInWithCredential(credential);
      emit(GoogleAuthenticated(_auth.currentUser!));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<Authstate> emit,
  ) async {
    emit(AuthLoading());
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        emit(const AuthError('Google Sign-In failed'));
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      emit(GoogleAuthenticated(userCredential.user!));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
    GoogleSignOutRequested event,
    Emitter<Authstate> emit,
  ) async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    emit(UnAuthenticated());
  }

  void _signIn(SignInRequested event, Emitter<Authstate> emit) async {
    emit(AuthLoading());
    try {
      await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(Authenticated());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.code));
    }
  }

  void _signUp(SignupIsRequested event, Emitter<Authstate> emit) async {
    emit(AuthLoading());
    try {
      await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(Authenticated());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.code));
    }
  }

  void _logOut(LogoutIsRequested event, Emitter<Authstate> emit) async {
    emit(AuthLoading());
    try {
      await _auth.signOut();
      emit(UnAuthenticated());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.code));
    }
  }
}