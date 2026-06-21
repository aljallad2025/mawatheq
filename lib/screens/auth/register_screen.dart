import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../utils/app_strings.dart';
import '../../utils/locale_provider.dart';
import '../home/main_navigation_screen.dart';

enum AccountType { individual, lawyer, company }

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  AccountType _selectedType = AccountType.individual;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _register() {
    // TODO: ربط بـ API التسجيل الفعلي لاحقاً
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = ref.watch(localeProvider).languageCode == 'ar';
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(AppStrings.t(isArabic, 'create_account'))),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppDimens.md),
              Text(AppStrings.t(isArabic, 'account_type'), style: textTheme.titleSmall),
              const SizedBox(height: AppDimens.sm),
              Row(
                children: [
                  Expanded(
                    child: _AccountTypeCard(
                      label: AppStrings.t(isArabic, 'individual'),
                      icon: Icons.person_outline_rounded,
                      selected: _selectedType == AccountType.individual,
                      onTap: () => setState(() => _selectedType = AccountType.individual),
                    ),
                  ),
                  const SizedBox(width: AppDimens.sm),
                  Expanded(
                    child: _AccountTypeCard(
                      label: AppStrings.t(isArabic, 'lawyer'),
                      icon: Icons.gavel_rounded,
                      selected: _selectedType == AccountType.lawyer,
                      onTap: () => setState(() => _selectedType = AccountType.lawyer),
                    ),
                  ),
                  const SizedBox(width: AppDimens.sm),
                  Expanded(
                    child: _AccountTypeCard(
                      label: AppStrings.t(isArabic, 'company'),
                      icon: Icons.business_outlined,
                      selected: _selectedType == AccountType.company,
                      onTap: () => setState(() => _selectedType = AccountType.company),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimens.lg),

              Text(AppStrings.t(isArabic, 'full_name'), style: textTheme.titleSmall),
              const SizedBox(height: AppDimens.sm),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.badge_outlined),
                  hintText: AppStrings.t(isArabic, 'full_name'),
                ),
              ),
              const SizedBox(height: AppDimens.md),

              Text(AppStrings.t(isArabic, 'phone_number'), style: textTheme.titleSmall),
              const SizedBox(height: AppDimens.sm),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.ltr,
                decoration: const InputDecoration(
                  hintText: '05xxxxxxxx',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
              ),
              const SizedBox(height: AppDimens.md),

              Text(AppStrings.t(isArabic, 'email'), style: textTheme.titleSmall),
              const SizedBox(height: AppDimens.sm),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textDirection: TextDirection.ltr,
                decoration: const InputDecoration(
                  hintText: 'example@email.com',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: AppDimens.md),

              Text(AppStrings.t(isArabic, 'password'), style: textTheme.titleSmall),
              const SizedBox(height: AppDimens.sm),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: '••••••••',
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                ),
              ),
              const SizedBox(height: AppDimens.xl),

              SizedBox(
                height: AppDimens.buttonHeight,
                child: ElevatedButton(
                  onPressed: _register,
                  child: Text(AppStrings.t(isArabic, 'create_account')),
                ),
              ),
              const SizedBox(height: AppDimens.lg),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.t(isArabic, 'have_account'),
                    style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(AppStrings.t(isArabic, 'login')),
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

class _AccountTypeCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _AccountTypeCard({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: selected ? AppColors.navy.withOpacity(0.08) : AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          border: Border.all(
            color: selected ? AppColors.navy : AppColors.cardBorder,
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: selected ? AppColors.navy : AppColors.textMuted),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? AppColors.navy : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
