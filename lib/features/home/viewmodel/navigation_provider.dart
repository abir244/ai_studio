import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// This tracks which tab is currently active globally
final navigationIndexProvider = StateProvider<int>((ref) => 0);