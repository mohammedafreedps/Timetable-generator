import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttg/blocs/course_blocs/course_bloc.dart';
import 'package:ttg/blocs/staff_adding_blocs/select_course_blocs/select_course_bloc.dart';
import 'package:ttg/blocs/staff_adding_blocs/select_subject_blocs/select_subject_bloc.dart';
import 'package:ttg/blocs/staff_adding_blocs/staff_adding_bloc.dart';
import 'package:ttg/blocs/staff_blocs/staff_bloc.dart';
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
      ],
      child: MaterialApp(
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthenticatedState) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
