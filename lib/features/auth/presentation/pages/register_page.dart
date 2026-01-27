import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodel/auth_providers.dart';
import '../../viewmodel/auth_viewmodel.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/login_button.dart';
import 'login_page.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    final viewModel = ref.read(authViewModelProvider.notifier);
    await viewModel.register(nameController.text.trim(), emailController.text.trim(), passwordController.text.trim());
    final state = ref.read(authViewModelProvider);

    if (state.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!), backgroundColor: Colors.red));
    } else if (state.user != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registered ${state.user!.email}!'), backgroundColor: Colors.green));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 60),
            CustomTextField(label: 'Name', hint: 'Enter name', controller: nameController),
            const SizedBox(height: 20),
            CustomTextField(label: 'Email', hint: 'Enter email', controller: emailController),
            const SizedBox(height: 20),
            CustomTextField(label: 'Password', hint: 'Enter password', controller: passwordController, isPassword: true),
            const SizedBox(height: 24),
            LoginButton(text: 'Register', isLoading: authState.isLoading, onPressed: _register),
          ],
        ),
      ),
    );
  }
}
