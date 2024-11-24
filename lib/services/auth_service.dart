import 'dart:convert';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/utils/constants.dart';

class AuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  // Authenticate with Fingerprint
  Future<bool> authenticate() async {
    try {
      // Check if biometric authentication is available
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      bool isDeviceSupported = await _localAuth.isDeviceSupported();

      if (canCheckBiometrics && isDeviceSupported) {
        bool didAuthenticate = await _localAuth.authenticate(
          localizedReason: 'Please authenticate to unlock the App',
          options: const AuthenticationOptions(biometricOnly: true),
        );
        return didAuthenticate;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to authenticate: $e');
    }
  }

  // Authenticate with Password
  Future<bool> authenticateWithPassword(String password) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseURL/ChefRegister/ValidateChefPassword?ChefId=$chefID&CurrentPassword=$password&APIKey=$apiKey',
        ),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 1) {
          return true;
        } else {
          return false;
        }
      } else {
        throw Exception(
            'Failed to validate password. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error validating password: $e');
    }
  }
}
