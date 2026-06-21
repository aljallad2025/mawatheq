import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../utils/app_strings.dart';
import '../../utils/locale_provider.dart';
import '../home/main_navigation_screen.dart';
import 'register_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _login() {
    // TODO: ربط بـ API تسجيل الدخول الفعلي لاحقاً
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = ref.watch(localeProvider).languageCode == 'ar';
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppDimens.xl),
              Center(
                child: Container(
                  width: 84,
                  height: 84,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                    boxShadow: AppColors.cardShadow,
                  ),
                  child: Image.asset('assets/images/logo.webp', fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: AppDimens.xl),
              Text(
                AppStrings.t(isArabic, 'welcome_back'),
                textAlign: TextAlign.center,
                style: textTheme.headlineLarge,
              ),
              const SizedBox(height: AppDimens.sm),
              Text(
                AppStrings.t(isArabic, 'login_subtitle'),
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppDimens.xl),

              Text(AppStrings.t(isArabic, 'phone_number'), style: textTheme.titleSmall),
              const SizedBox(height: AppDimens.sm),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.ltr,
                decoration: InputDecoration(
                  hintText: '05xxxxxxxx',
                  prefixIcon: const Icon(Icons.phone_outlined),
                ),
              ),
              const SizedBox(height: AppDimens.md),

              Text(AppStrings.t(isArabic, 'password'), style: textTheme.titleSmall),
              const SizedBox(height: AppDimens.sm),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: '••••••••',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),
              Align(
                alignment:
                    isArabic ? Alignment.centerLeft : Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(AppStrings.t(isArabic, 'forgot_password')),
                ),
              ),
              const SizedBox(height: AppDimens.md),

              SizedBox(
                height: AppDimens.buttonHeight,
                child: ElevatedButton(
                  onPressed: _login,
                  child: Text(AppStrings.t(isArabic, 'login')),
                ),
              ),
              const SizedBox(height: AppDimens.lg),

              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimens.sm),
                    child: Text(
                      AppStrings.t(isArabic, 'or_continue_with'),
                      style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: AppDimens.lg),

              Row(
                children: [
                  Expanded(
                    child: _SocialButton(icon: Icons.g_mobiledata_rounded, onTap: () {}),
                  ),
                  const SizedBox(width: AppDimens.md),
                  Expanded(
                    child: _SocialButton(icon: Icons.apple_rounded, onTap: () {}),
                  ),
                ],
              ),
              const SizedBox(height: AppDimens.xl),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.t(isArabic, 'no_account'),
                    style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const RegisterScreen()),
                      );
                    },
                    child: Text(AppStrings.t(isArabic, 'create_account')),
                  ),
                ],
              ),
              const SizedBox(height: AppDimens.lg),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.cardBorder),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: Icon(icon, color: AppColors.textPrimary, size: 26),
    );
  }
}
