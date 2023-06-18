import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardabookingadmin/cubits/login_cubit.dart';
import 'package:gardabookingadmin/cubits/signup_cubit.dart';
import 'package:gardabookingadmin/repositories/auth_repository.dart';
import 'package:gardabookingadmin/repositories/user_repository.dart';
import 'package:gardabookingadmin/screens/admin_login_screen.dart';
import 'package:gardabookingadmin/screens/new_product_screen.dart';
import 'package:gardabookingadmin/screens/products_screen.dart';
import 'package:gardabookingadmin/screens/signup_screen.dart';
import 'package:get/get.dart';

import 'blocs/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GardaBooking Backend',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AdminLoginScreen(),
      getPages: [
        GetPage(name: '/products', page: () => ProductsScreen()),
        GetPage(name: '/products/new', page: () => NewProductScreen()),
        GetPage(name: '/signup', page: () => SignupScreen())
      ],
      builder: (context, child) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => UserRepository(),
            ),
            RepositoryProvider(
              create: (context) => AuthRepository(userRepository: context.read<UserRepository>()),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(
                create: (context) => AuthBloc(
                  authRepository: context.read<AuthRepository>(),
                  userRepository: context.read<UserRepository>(),
                ),
              ),
              BlocProvider<LoginCubit>(
                create: (context) => LoginCubit(
                  authRepository: context.read<AuthRepository>(),
                ),
              ),
              BlocProvider<SignupCubit>(
                create: (context) => SignupCubit(
                  authRepository: context.read<AuthRepository>(),
                ),
              ),
            ],
            child: child!,
          ),
        );
      },
    );
  }
}
