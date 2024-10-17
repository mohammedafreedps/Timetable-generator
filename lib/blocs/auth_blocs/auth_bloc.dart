import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthBloc() : super(AuthInitial()) {
    
    // Listen to Firebase Authentication State changes
    on<CheckForAuthentication>((event, emit) {
      _firebaseAuth.authStateChanges().listen((User? user) {
        print(user);
        if (user == null) {
          emit(UnAuthenticatedState());
        } else {
          emit(AuthenticatedState());
        }
      });
    });

    // Manually Check Authentication
    on<MannualCheckForAuthentication>((event, emit) async {

      User? user = _firebaseAuth.currentUser;
      if (user == null) {
        emit(UnAuthenticatedState());
      } else {
        emit(AuthenticatedState());
      }

    });

    // Trigger the authentication check initially
    add(MannualCheckForAuthentication());
    // add(CheckForAuthentication());

    // Handle Google Sign-In Button Press
    on<SignInWithGoogleButtonPressed>((event, emit) async {
      emit(AuthLoadingState()); // Emit loading state during sign-in process
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        if (googleUser == null) {
          // User canceled the sign-in
          emit(UnAuthenticatedState());
          return;
        }

        // Get Google Auth credentials (access token and ID token)
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        // Create a new credential using Google auth
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google credential
        await _firebaseAuth.signInWithCredential(credential);

        // After successful sign-in, emit AuthenticatedState
        add(MannualCheckForAuthentication());
      } catch (e) {
        // emit(AuthFailureState(e.toString())); // Handle any errors
      }
    });

    on<SignOutButtonPressedEvent>((event,emit)async{
      emit(AuthLoadingState());
      await _firebaseAuth.signOut();
      emit(AuthLodedState());
    });
  }
}
