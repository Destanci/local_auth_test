import 'package:flutter/widgets.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

///
/// Biometric authentication utilities
///
/// Use this to authenticate get local authentication of the phone.
/// Checks if there biometric login possibility then requests login.
///
/// ***Dependencies***
/// - *package:* 'local_auth'
///
/// ***Returns***
/// - *false:* if not possible, canceled or unsuccessful.
/// - *true:* if authentication successful.
///
/// ***Usage***
/// on initState:
///
/// ```
///  WidgetsBinding.instance.addPostFrameCallback((_) {
///   BiometricUtilities.authenticate(context).then((value) {
///     if (value) {
///       // Do your secure stuff
///     }
///   });
/// });
/// ```
///
class BiometricUtilities {
  static LocalAuthentication? _auth;
  static LocalAuthentication get auth => _auth ??= LocalAuthentication();

  static Future<bool> get canAuthenticate async {
    var value = await auth.canCheckBiometrics && await auth.isDeviceSupported();

    return value;
  }

  static Future<List<BiometricType>> get availableBiometrics async {
    List<BiometricType> value =
        (await canAuthenticate) ? await auth.getAvailableBiometrics() : const [];

    return value;
  }

  static void cancelAuth() {
    _auth?.stopAuthentication();
    _auth = null;
  }

  static Future<bool> authenticate(BuildContext context) async {
    try {
      var value = await availableBiometrics.then((biometrics) async {
        if (biometrics.isNotEmpty) {
          return await auth.authenticate(
            localizedReason: 'Please authenticate to show account balance',
            authMessages: const <AuthMessages>[
              AndroidAuthMessages(
                signInTitle: 'Oops! Biometric authentication required!',
                cancelButton: 'No thanks',
              ),
              IOSAuthMessages(
                cancelButton: 'No thanks',
              ),
            ],
            options: const AuthenticationOptions(
              biometricOnly: true,
              stickyAuth: true,
              useErrorDialogs: false,
            ),
          );
        }
        return false;
      });
      return value;
    } catch (error, _) {
      cancelAuth();
    }
    return false;
  }
}
