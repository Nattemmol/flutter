import 'package:flutter/material.dart';
import 'package:login_app/app_view.dart';
import 'package:login_app/packages/user_repository/lib/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/blocs/authentication_bloc/authentication_bloc.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          // Build UI based on the state
          return const MyAppView();
        },
      ),
    );
  }
}
