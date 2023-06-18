import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardabookingadmin/cubits/signup_cubit.dart';
import 'package:gardabookingadmin/cubits/signup_cubit.dart';
import 'package:gardabookingadmin/screens/products_screen.dart';
import 'package:gardabookingadmin/screens/signup_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../cubits/login_cubit.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login/signup'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _EmailInput(),
            const SizedBox(height: 10),
            _Password(),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.read<LoginCubit>().logInWithCredentials().then((success) {
                  if (success) {
                    Get.offAll(() => ProductsScreen());
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(),
                backgroundColor: Colors.black,
                fixedSize: Size(200, 40),
              ),
              child: Text(
                'Login',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => SignupScreen());
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(),
                backgroundColor: Colors.black54,
                fixedSize: Size(200, 40),
              ),
              child: Text(
                'Sign Up',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<LoginCubit>().emailChanged(email);
          },
          decoration: const InputDecoration(labelText: 'Email'),
        );
      },
    );
  }
}

class _Password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        );
      },
    );
  }
}

// final loginCubit = context.read<LoginCubit>();
// loginCubit.logInWithCredentials().then((success) {
//   if (success) {
//     Get.offAll(() => ProductsScreen()); // Navigate to products screen
//   } else {
//     // Handle login failure, show error message, etc.
//   }
//if(context.read<LoginCubit>().logInWithCredentials())
//context.read<LoginCubit>().logInWithCredentials();