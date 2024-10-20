import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthBloc() : super(AuthInitial()) {
    
    on<CheckForAuthentication>((event, emit) {
      _firebaseAuth.authStateChanges().listen((User? user) {
        if (user == null) {
          emit(UnAuthenticatedState());
        } else {
          emit(AuthenticatedState());
        }
      });
    });

    on<MannualCheckForAuthentication>((event, emit) async {

      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        emit(UnAuthenticatedState());
      } else {
        emit(AuthenticatedState());
      }

    });

    add(MannualCheckForAuthentication());

    on<SignInWithGoogleButtonPressed>((event, emit) async {
      emit(AuthLoadingState()); 
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        if (googleUser == null) {
          emit(UnAuthenticatedState());
          return;
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _firebaseAuth.signInWithCredential(credential);

        add(MannualCheckForAuthentication());
      } catch (e) {
        //
      }
    });

    on<SignOutButtonPressedEvent>((event,emit)async{
      emit(AuthLoadingState());
      await _firebaseAuth.signOut();
      emit(AuthLodedState());
    });
  }
}
