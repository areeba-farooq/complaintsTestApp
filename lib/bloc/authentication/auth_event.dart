import 'package:flutter/material.dart';

abstract class AuthEvent {}

class FingerprintAuthEvent extends AuthEvent {
  final BuildContext context;

  FingerprintAuthEvent(this.context);
}

class PasswordAuthEvent extends AuthEvent {
  final String password;

  PasswordAuthEvent({required this.password});
}
