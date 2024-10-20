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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => CourseBloc()..add(FechCoursesDataEvent()),
        ),
        BlocProvider(
          create: (context) => CourseAddingBloc(),
        ),
        BlocProvider(
          create: (context) => StaffBloc()..add(FetchStaffDetailsEvent()),
        ),
        BlocProvider(
          create: (context) => StaffAddingBloc(),
        ),
        BlocProvider(
          create: (context) => SelectSubjectBloc(),
        ),
        BlocProvider(
          create: (context) => SelectCourseBloc(),
        ),
        BlocProvider(
          create: (context) => DashboardBloc()..add(LoadNeededDatasEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthenticatedState) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
