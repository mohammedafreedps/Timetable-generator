import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttg/blocs/blocs.dart';
import 'package:ttg/screens/dashboard_screen/widgets/dashboard_tile.dart';
import 'package:ttg/screens/timetable_creating_screen/timetable_creating_screen.dart';
import 'package:ttg/utils/constants.dart';
import 'package:ttg/widgets/widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if (state is LoadAllDataForDashboardState) {
          context.read<CourseBloc>().add(FechCoursesDataEvent());
          context.read<StaffBloc>().add(FetchStaffDetailsEvent());
        }
      },
      child: BlocListener<CourseBloc, CourseState>(
        listener: (context, state) {
          if (state is FechedCourseDataState) {
            context.read<DashboardBloc>().add(DatasHaveLoadedEvent());
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Generate TimeTable'),
              actions: [
                IconButton(
                    onPressed: () {
                      appDialogBox(
                          context: context,
                          title: 'Do you really want to Sign Out',
                          yesFunction: () {
                            context
                                .read<AuthBloc>()
                                .add(SignOutButtonPressedEvent());
                          });
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(AppPaddings.screenPadding),
              child: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  if (state is AlldataHaveLoadedState) {
                    return CourseBloc.courses.isNotEmpty
                        ? ListView.builder(
                            itemCount: CourseBloc.courses.length,
                            itemBuilder: (context, index) {
                              return dashboardTile(
                                  CourseBloc.courses[index].courseName, () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => TimetableCreatingScreen(
                                        courseModel:
                                            CourseBloc.courses[index])));
                              });
                            })
                        : const Center(
                            child: Text('No Data to Show'),
                          );
                  } else {
                    return Center(child: appCircularProgressIndicator());
                  }
                },
              ),
            )),
      ),
    );
  }
}
