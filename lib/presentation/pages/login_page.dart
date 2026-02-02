import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omdb_movie_app/presentation/bloc/login_bloc.dart';
import 'package:omdb_movie_app/presentation/pages/search_page.dart';

import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(builder: (context, state) {
        if (state is LoginLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context).add(LoginRequest(
                          username: usernameController.text,
                          password: passwordController.text));
                    },
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is LoginSuccess) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => SearchPage()));
        }
      }),
    );
  }
}
