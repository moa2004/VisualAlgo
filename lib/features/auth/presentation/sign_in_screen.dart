import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visual_algo/core/constants/app_colors.dart';
import 'package:visual_algo/core/widgets/app_scaffold.dart';
import 'package:visual_algo/core/widgets/glass_container.dart';
import 'package:visual_algo/features/auth/providers.dart';
import 'package:visual_algo/features/auth/presentation/sign_up_screen.dart';
import 'package:visual_algo/features/home/presentation/home_screen.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  static const routePath = '/auth/sign-in';
  static const routeName = 'sign-in';

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      await ref.read(authRepositoryProvider).signInWithEmail(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
      if (!mounted) return;
      context.go(HomeScreen.routePath);
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Sign In Failed',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          content: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close', style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWide = MediaQuery.of(context).size.width >= 1000;

    return AppScaffold(
      animateBackground: true,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 160 : 24,
            vertical: 48,
          ),
          child: Column(
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/algorithmat_logo.png',
                    height: 90,
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome Back',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Continue your problem-solving journey 🚀',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              GlassContainer(
                padding: EdgeInsets.all(isWide ? 48 : 28),
                borderRadius: 12,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.05),
                    Colors.white.withOpacity(0.02)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email address',
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                        ),
                        validator: (v) => v == null || !v.contains('@')
                            ? 'Enter a valid email'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscure,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () =>
                                setState(() => _obscure = !_obscure),
                          ),
                        ),
                        validator: (v) =>
                            v == null || v.length < 6 ? 'Invalid password' : null,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: _submit,
                        icon: const Icon(Icons.login_rounded),
                        label: const Text('Sign In'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.neonTeal.withOpacity(0.2),
                          foregroundColor: AppColors.neonTeal,
                          side: BorderSide(color: AppColors.neonTeal.withOpacity(0.4)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Divider(color: Colors.white.withOpacity(0.08)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('New to AlgorithMat? ',
                              style: TextStyle(color: Colors.white70)),
                          TextButton(
                            onPressed: () => context.go(SignUpScreen.routePath),
                            child: const Text(
                              'Create an account',
                              style: TextStyle(
                                color: AppColors.neonTeal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              GlassContainer(
                borderRadius: 10,
                padding: const EdgeInsets.all(22),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.03),
                    Colors.white.withOpacity(0.01)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                child: Column(
                  children: [
                    const Icon(Icons.auto_graph_rounded,
                        color: AppColors.neonTeal, size: 36),
                    const SizedBox(height: 12),
                    Text(
                      'Why use AlgorithMat?',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Visualize algorithms, compete with peers, and track your growth daily through real interactive experiences.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.psychology_alt_rounded,
                            color: AppColors.neonTeal),
                        SizedBox(width: 8),
                        Icon(Icons.code_rounded, color: Colors.amberAccent),
                        SizedBox(width: 8),
                        Icon(Icons.school_rounded,
                            color: Colors.lightBlueAccent),
                      ],
                    )
                  ],
                ),
              ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.3),
            ],
          ),
        ),
      ),
    );
  }
}
