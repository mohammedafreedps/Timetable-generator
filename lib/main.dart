import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttg/screens/home_screen/home_screen.dart';
import 'package:ttg/screens/login_screen/login_screen.dart';

import 'blocs/blocs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
          // BlocProvider(
          //   create: (context) => LoginBloc(),
          // ),
        ],
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if(state is AuthenticatedState){
              return HomeScreen();
            }
            else{
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
