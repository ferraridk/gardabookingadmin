import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardabookingadmin/cubits/signup_cubit.dart';


import '../repositories/auth_repository.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupCubit>(
      create: (context) => SignupCubit(authRepository: context.read<AuthRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign up'),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(100),
          child: BlocBuilder<SignupCubit, SignupState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _UserInput(onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                      state.user!.copyWith(email: value),
                    );
                  }, labelText: 'Email'),
                  const SizedBox(height: 10),
                  _UserInput(onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                      state.user!.copyWith(fullName: value),
                    );
                  }, labelText: 'Full Name'),
                  const SizedBox(height: 10),
                  _UserInput(onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                      state.user!.copyWith(country: value),
                    );
                  }, labelText: 'Country'),
                  const SizedBox(height: 10),
                  _UserInput(onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                      state.user!.copyWith(city: value),
                    );
                  }, labelText: 'City'),
                  const SizedBox(height: 10),
                  _UserInput(onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                      state.user!.copyWith(address: value),
                    );
                  }, labelText: 'Address'),
                  const SizedBox(height: 10),
                  _UserInput(onChanged: (value) {
                    context.read<SignupCubit>().userChanged(
                      state.user!.copyWith(zipCode: value),
                    );
                  }, labelText: 'Zipcode'),
                  const SizedBox(height: 10),
                  _PasswordInput(),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SignupCubit>().signUpWithCredentials();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(),
                      backgroundColor: Colors.black,
                      fixedSize: Size(200, 40),
                    ),
                    child: Text('Sign up'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _UserInput extends StatelessWidget {
  const _UserInput({
    Key? key,
    required this.onChanged,
    required this.labelText,
  }) : super(key: key);

  final Function(String)? onChanged;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return TextField(
          onChanged: onChanged,
          decoration: InputDecoration(labelText: labelText),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<SignupCubit>().passwordChanged(password);
          },
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        );
      },
    );
  }
}