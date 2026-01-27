import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/routes/route_name.dart'; // Ensure this path is correct
import '../../viewmodel/auth_providers.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/login_button.dart';
import 'register_page.dart';

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

  void _login() async {
    final viewModel = ref.read(authViewModelProvider.notifier);

    // 1. Call the login logic
    await viewModel.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    // 2. Check if the widget is still in the tree before navigating
    if (!mounted) return;

    final state = ref.read(authViewModelProvider);

    if (state.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error!), backgroundColor: Colors.red),
      );
    } else if (state.user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Welcome ${state.user!.email}!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1),
        ),
      );

      // 3. Navigate to Category Screen using RouteName
      Navigator.pushReplacementNamed(context, RouteName.Category);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              // App Logo or Illustration could go here
              const Center(
                child: Icon(Icons.all_inclusive, size: 80, color: Colors.deepPurple),
              ),
              const SizedBox(height: 40),
              const Text(
                "Login",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
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
              LoginButton(
                text: 'Login',
                isLoading: authState.isLoading,
                onPressed: _login,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, RouteName.registration),
                    child: const Text(
                      'Register',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}