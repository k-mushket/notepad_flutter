import 'package:vibration/vibration.dart';

class VibrationService {
  static Future<void> vibrate() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(
        pattern: [0, 50],
        intensities: [0, 100],
      );
    }
  }
}