import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttg/blocs/blocs.dart';
import 'package:ttg/screens/staff_adding_screen/staff_adding_screen.dart';
import 'package:ttg/screens/staff_screen/widgets/staff_tile.dart';
import 'package:ttg/utils/constants.dart';
import 'package:ttg/widgets/widgets.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<StaffAddingBloc, StaffAddingState>(
      listener: (context, state) {
        if (state is StaffDataSavedState) {
          context.read<StaffBloc>().add(FetchStaffDetailsEvent());
        }
      },
      child: BlocListener<StaffBloc, StaffState>(
        listener: (context, state) {
          if (state is StaffDeletedState) {
            context.read<StaffBloc>().add(FetchStaffDetailsEvent());
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Staffs'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StaffAddingScreen()));
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(AppPaddings.screenPadding),
            child: BlocBuilder<StaffBloc, StaffState>(
              builder: (context, state) {
                if (state is StaffDetailsLoadedState) {
                  return state.staffs.isNotEmpty
                      ? ListView.builder(
                          itemCount: state.staffs.length,
                          itemBuilder: (context, index) {
                            return staffTile(
                                deleteFunction: () {
                                  appDialogBox(
                                      context: context,
                                      title:
                                          'Do you really want to delete staff',
                                      yesFunction: () {
                                        context.read<StaffBloc>().add(
                                            DeleteStaffButtonClickedEvent(
                                                id: state.staffs[index].id));
                                      });
                                },
                                editFunction: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => StaffAddingScreen(
                                            isForEdit: true,
                                            index: index,
                                          )));
                                },
                                subjects: state.staffs[index].subjects,
                                staffName: state.staffs[index].name,
                                courseName: state.staffs[index].courseName);
                          })
                      : const Center(
                          child: Text('No Staff to show'),
                        );
                }
                return Center(child: appCircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
