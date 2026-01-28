import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Theme & Routes
import '../../../../core/routes/route_name.dart';
import '../../../../core/theme/app_colors.dart';

// ViewModels
import '../../viewmodel/auth_providers.dart';

// Split Widgets
import '../widgets/custom_lodaing.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/login_button.dart';
// Ensure this matches your filename

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Handles the login process
  void _login() async {
    // 1. Show the split loading dialog
    // We use rootNavigator: true to ensure the dialog sits on top of everything
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CustomLoadingDialog(),
    );

    final viewModel = ref.read(authViewModelProvider.notifier);

    // 2. Perform the async login logic
    await viewModel.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    // 3. Dismiss the loading dialog safely
    if (mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    // 4. Handle Post-Login Logic
    if (!mounted) return;
    final state = ref.read(authViewModelProvider);

    if (state.error != null) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error!),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else if (state.user != null) {
      // Navigate to the next screen (Category)
      Navigator.pushReplacementNamed(context, RouteName.Category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // App Logo
                Center(
                  child: Image.asset(
                    'assets/images/Frame.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 40),

                // Title
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Input Fields
                CustomTextField(
                  label: 'Email',
                  hint: 'Enter email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Password',
                  hint: 'Enter password',
                  controller: passwordController,
                  isPassword: true,
                ),

                const SizedBox(height: 32),

                // Login Button
                LoginButton(
                  text: 'Login',
                  isLoading: false, // Dialog handles loading state visually
                  onPressed: _login,
                ),

                const SizedBox(height: 20),

                // Registration Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, RouteName.registration),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}