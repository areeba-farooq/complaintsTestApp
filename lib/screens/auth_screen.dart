import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/bloc/authentication/auth_bloc.dart';
import 'package:test_app/bloc/authentication/auth_event.dart';
import 'package:test_app/bloc/authentication/auth_state.dart';
import 'package:test_app/screens/complaint_screen.dart';
import 'package:test_app/utils/constants.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("You are authorized"),
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ComplaintListScreen(
                        userName: _nameController.text,
                      )),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: primaryColor,
            ));
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Name TextField
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      enabledBorder: textFieldBorder,
                      focusedBorder: textFieldBorder,
                      border: textFieldBorder,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  // Password TextField
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      enabledBorder: textFieldBorder,
                      focusedBorder: textFieldBorder,
                      border: textFieldBorder,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      final password = _passwordController.text;

                      if (password.isNotEmpty) {
                        context
                            .read<AuthBloc>()
                            .add(PasswordAuthEvent(password: password));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a password'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Authenticate with Password',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Fingerprint Authentication Button
                  IconButton(
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(FingerprintAuthEvent(context));
                    },
                    icon: const Icon(Icons.fingerprint),
                    color: primaryColor,
                    iconSize: 80,
                    tooltip: 'Authenticate with Fingerprint',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
