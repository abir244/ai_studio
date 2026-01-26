import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/routes/route_name.dart';
import '../../../core/routes/route_import_path.dart';

final splashViewModelProvider =
Provider.autoDispose<SplashViewModel>((ref) {
  final vm = SplashViewModel();
  ref.onDispose(vm.dispose);
  return vm;
});

class SplashViewModel {
  Timer? _timer;

  SplashViewModel() {
    _timer = Timer(const Duration(seconds: 2), () {
      navigatorKey.currentState?.pushReplacementNamed(
        RouteName.onboarding,
      );
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
