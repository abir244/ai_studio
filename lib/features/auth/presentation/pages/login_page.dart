import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../core/theme/app_colors.dart';
import '../../viewmodel/auth_providers.dart';
import '../widgets/custom_lodaing.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/login_button.dart';

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
  Future<void> _login() async {
    // 1. Basic validation
    if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
      return;
    }

    // 2. Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const CustomLoadingDialog(),
    );

    // 3. Perform login
    final authNotifier = ref.read(authNotifierProvider.notifier);
    await authNotifier.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    // 4. Close loading dialog
    if (mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    if (!mounted) return;

    // 5. Check final state
    final authState = ref.read(authNotifierProvider);

    if (authState.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authState.error!),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else if (authState.user != null) {
      // NOTE: currentUsernameProvider updates automatically now
      // because it watches authNotifierProvider!
      Navigator.pushReplacementNamed(context, RouteName.Category);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen for loading states to disable buttons if necessary
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/Frame.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.lock, size: 80, color: AppColors.primaryPurple),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: passwordController,
                  isPassword: true,
                ),
                const SizedBox(height: 32),
                LoginButton(
                  text: 'Login',
                  onPressed: _login,
                  isLoading: authState.isLoading,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: authState.isLoading
                          ? null
                          : () => Navigator.pushNamed(context, RouteName.registration),
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