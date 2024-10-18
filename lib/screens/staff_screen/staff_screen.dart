import 'package:flutter/material.dart';
import 'package:ttg/screens/staff_adding_screen/staff_adding_screen.dart';
import 'package:ttg/screens/staff_screen/widgets/staff_tile.dart';
import 'package:ttg/utils/constants.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StaffAddingScreen()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(AppPaddings.screenPadding),
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
          return staffTile();
        }),
      ),
    );
  }
}
