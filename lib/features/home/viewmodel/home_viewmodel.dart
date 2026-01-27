import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  String _selectedAspectRatio = '1:1';
  String _selectedStyle = 'Realistic';
  String _prompt = '';

  String get selectedAspectRatio => _selectedAspectRatio;
  String get selectedStyle => _selectedStyle;
  String get prompt => _prompt;

  void setAspectRatio(String ratio) {
    _selectedAspectRatio = ratio;
    notifyListeners();
  }

  void setStyle(String style) {
    _selectedStyle = style;
    notifyListeners();
  }

  void setPrompt(String value) {
    _prompt = value;
    notifyListeners();
  }

  void generateImage() {
    // Logic to call image generation API
    print("Generating image with prompt: $_prompt, Style: $_selectedStyle, Ratio: $_selectedAspectRatio");
  }
}