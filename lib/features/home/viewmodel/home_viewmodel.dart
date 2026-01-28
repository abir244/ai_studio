import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart' show StateNotifierProvider, StateNotifier;
import '../models/home_state.dart';

final homeViewModelProvider =
StateNotifierProvider<HomeViewModel, HomeState>(
      (ref) => HomeViewModel(),
);

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel() : super(const HomeState());

  void setPrompt(String value) {
    state = state.copyWith(prompt: value);
  }

  void setStyle(String style) {
    state = state.copyWith(selectedStyle: style);
  }

  void setAspectRatio(String ratio) {
    state = state.copyWith(selectedAspectRatio: ratio);
  }

  Future<void> generateImage() async {
    state = state.copyWith(isLoading: true);

    await Future.delayed(const Duration(seconds: 2)); // fake API call

    print(
      "Generating image with prompt: ${state.prompt}, "
          "Style: ${state.selectedStyle}, "
          "Ratio: ${state.selectedAspectRatio}",
    );

    state = state.copyWith(isLoading: false);
  }
}
