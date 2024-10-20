import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttg/blocs/blocs.dart';
import 'package:ttg/styles/styles.dart';
import 'package:ttg/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LogIn',
              style: AppTextStyles.secondaryStyle.copyWith(fontSize: 40),
            ),
            AppButton(
              lable: 'With Google',
              function: () {
                context.read<AuthBloc>().add(SignInWithGoogleButtonPressed());
              },
            ),
            const SizedBox(height: 20,),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if(state is AuthLoadingState){
                return CircularProgressIndicator(color: AppColors.primaryColor,);
                }else if(state is AuthLodedState){
                  return Container();
                }else{
                  return Container();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
