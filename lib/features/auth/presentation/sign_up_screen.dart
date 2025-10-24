import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visual_algo/core/constants/app_colors.dart';
import 'package:visual_algo/core/widgets/app_scaffold.dart';
import 'package:visual_algo/core/widgets/glass_container.dart';
import 'package:visual_algo/features/auth/providers.dart';
import 'package:visual_algo/features/auth/presentation/sign_in_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  static const routePath = '/auth/sign-up';
  static const routeName = 'sign-up';

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  double _passwordStrength = 0;
  String _passwordStrengthLabel = '';
  bool _obscure = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkPasswordStrength(String password) {
    if (password.isEmpty) {
      setState(() {
        _passwordStrength = 0;
        _passwordStrengthLabel = '';
      });
      return;
    }
    int strength = 0;
    if (password.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength++;
    if (RegExp(r'[0-9]').hasMatch(password)) strength++;
    if (RegExp(r'[!@#\$&*~]').hasMatch(password)) strength++;
    setState(() {
      _passwordStrength = strength / 4;
      if (strength <= 1) {
        _passwordStrengthLabel = 'Weak';
      } else if (strength == 2 || strength == 3) {
        _passwordStrengthLabel = 'Medium';
      } else {
        _passwordStrengthLabel = 'Strong';
      }
    });
  }

  Widget _buildPasswordStrengthBar(BuildContext context) {
    if (_passwordStrength == 0) return const SizedBox.shrink();
    List<Color> gradientColors;
    if (_passwordStrength <= 0.33) {
      gradientColors = [Colors.redAccent, Colors.red];
    } else if (_passwordStrength <= 0.66) {
      gradientColors = [Colors.orangeAccent, Colors.deepOrange];
    } else {
      gradientColors = [AppColors.neonTeal, Colors.greenAccent];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: 300.ms,
          height: 8,
          width: MediaQuery.of(context).size.width * 0.3 * (_passwordStrength + 0.1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          _passwordStrengthLabel,
          style: TextStyle(
            color: gradientColors.last,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      await ref.read(authRepositoryProvider).signUpWithEmail(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            displayName: _nameController.text.trim(),
          );
      if (!mounted) return;
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(40),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonTeal.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Animate(
                  effects: [
                    ScaleEffect(duration: 500.ms, curve: Curves.easeOutBack),
                    FadeEffect(duration: 400.ms),
                  ],
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.neonTeal,
                    size: 90,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Account Created!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Welcome aboard to AlgorithMat 🚀",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    context.go(SignInScreen.routePath);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonTeal.withOpacity(0.85),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                  label: const Text("Continue to Sign In"),
                ),
              ],
            ),
          ),
        ),
      );
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
            'Registration Failed',
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
                    'Create Your Account',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
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
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Full name',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Enter your name' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) =>
                            v == null || !v.contains('@') ? 'Enter a valid email' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscure,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                            onPressed: () => setState(() => _obscure = !_obscure),
                          ),
                        ),
                        onChanged: _checkPasswordStrength,
                        validator: (v) => v == null || v.length < 8
                            ? 'Password must be at least 8 characters'
                            : null,
                      ),
                      const SizedBox(height: 8),
                      _buildPasswordStrengthBar(context),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirm password',
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                        ),
                        validator: (v) => v != _passwordController.text
                            ? 'Passwords do not match'
                            : null,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: _submit,
                        icon: const Icon(Icons.auto_fix_high_rounded),
                        label: const Text('Create Account'),
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
                          const Text('Already have an account? ',
                              style: TextStyle(color: Colors.white70)),
                          TextButton(
                            onPressed: () => context.go(SignInScreen.routePath),
                            child: const Text(
                              'Sign in',
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
                      'Why join AlgorithMat?',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Level up your skills with interactive algorithm visualizations, coding challenges, and adaptive quizzes that help you grow faster — every day.',
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
