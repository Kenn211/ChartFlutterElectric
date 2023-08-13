import 'package:local_auth/local_auth.dart';

class BiometricAuth {
  final auth = LocalAuthentication();

  Future<bool> _canAuthenticate() async =>
      await auth.canCheckBiometrics || await auth.isDeviceSupported();

  Future<bool> authenticate() async {
    try {
      if (!await _canAuthenticate()) {
        return false;
      }
      return await auth.authenticate(
          localizedReason: 'Biometrics',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
            biometricOnly: false,
          ));
    } catch (e) {
      return false;
    }
  }
}
