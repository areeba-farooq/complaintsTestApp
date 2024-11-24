import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/bloc/authentication/auth_bloc.dart';
import 'package:test_app/bloc/complaints/complaint_bloc.dart';
import 'package:test_app/screens/auth_screen.dart';
import 'package:test_app/services/auth_service.dart';
import 'package:test_app/services/complaint_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authService: AuthService()),
        ),
        BlocProvider(
          create: (context) => ComplaintBloc(
            ComplaintService(),
          ),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Complaints Test App',
        home: AuthenticationScreen(),
      ),
    );
  }
}
