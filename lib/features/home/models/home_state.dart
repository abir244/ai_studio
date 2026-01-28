class HomeState {
  final String prompt;
  final String selectedStyle;
  final String selectedAspectRatio;
  final bool isLoading;

  const HomeState({
    this.prompt = '',
    this.selectedStyle = 'Realistic',
    this.selectedAspectRatio = '1:1',
    this.isLoading = false,
  });

  HomeState copyWith({
    String? prompt,
    String? selectedStyle,
    String? selectedAspectRatio,
    bool? isLoading,
  }) {
    return HomeState(
      prompt: prompt ?? this.prompt,
      selectedStyle: selectedStyle ?? this.selectedStyle,
      selectedAspectRatio: selectedAspectRatio ?? this.selectedAspectRatio,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
