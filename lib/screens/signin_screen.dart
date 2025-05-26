import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'signup_screen.dart';
import 'main_navigation.dart';
import '../../providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends ConsumerWidget {
  SignInScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 32),

              // Email Field
              TextField(
                controller: emailController,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 16),

              // Password Field
              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: () async{
                  // Aksi sign in di sini
                  final auth = ref.read(authRepositoryProvider);
                  try{
                    await auth.signIn(emailController.text, passwordController.text);
                    if (context.mounted) Navigator.pushReplacementNamed(context, '/main');
                  }catch (e){
                    // Handle error
                    print(e);
                  }
                },
                child: const Text('SIGN IN'),
              ),
              const SizedBox(height: 16),

              TextButton(
                onPressed: () async{
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SignUpScreen()
                    ),
                  );
                },
                child: const Text("Don't have an account? Sign Up",
                style: TextStyle(
                  color: Colors.white
                )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
