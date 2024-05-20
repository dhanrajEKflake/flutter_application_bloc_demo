import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_bloc_demo/services/auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool isLogIn = false;

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
    on<LoginStateChangeEvent>(loginStateChangeEvent);
    on<LoginResetClickedEvent>(loginResetClickedEvent);
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    isLogIn
        ? await signInWithEmailAndPassword(event.email, event.password, emit)
        : await createUserWithEmailAndPassword(
            event.email, event.password, emit);
  }

  Future<void> signInWithEmailAndPassword(
      String email, String password, Emitter<LoginState> emit) async {
    try {
      await Auth().signInwithEmailAndPassword(email: email, password: password);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(message: e.message.toString()));
    } catch (e) {
      emit(LoginErrorState(message: e.toString()));
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, Emitter<LoginState> emit) async {
    try {
      await Auth()
          .createUserWithEmailAndPassword(email: email, password: password);

      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(message: e.message.toString()));
    } catch (e) {
      emit(LoginErrorState(message: e.toString()));
    }
  }

  Future<void> resetPassword(String email, Emitter<LoginState> emit) async {
    try {
      await Auth().sendResetPasswordEmail(email: email);

      emit(LoginInitial());
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(message: e.message.toString()));
    } catch (e) {
      emit(LoginErrorState(message: e.toString()));
    }
  }

  FutureOr<void> loginStateChangeEvent(
      LoginStateChangeEvent event, Emitter<LoginState> emit) {
    isLogIn = !isLogIn;
    emit(LoginInitial());
  }

  FutureOr<void> loginResetClickedEvent(
      LoginResetClickedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    await resetPassword(event.email, emit);
  }
}
