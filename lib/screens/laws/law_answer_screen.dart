import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../utils/app_strings.dart';
import '../../utils/locale_provider.dart';
import '../consultation/lawyer_list_screen.dart';

class LawAnswerScreen extends ConsumerWidget {
  final String question;
  const LawAnswerScreen({super.key, required this.question});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = ref.watch(localeProvider).languageCode == 'ar';
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(AppStrings.t(isArabic, 'laws_title'))),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppDimens.md),
                decoration: BoxDecoration(
                  gradient: AppColors.heroGradient,
                  borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.help_outline_rounded, color: Colors.white),
                    const SizedBox(width: AppDimens.sm),
                    Expanded(
                      child: Text(
                        question,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimens.lg),

              Text(
                isArabic
                    ? 'تنص المادة ٨٠ من نظام العمل على حالات الإنهاء المقبولة. يجب على صاحب العمل تقديم إشعار خطي وتسوية نهائية ما لم يثبت سوء سلوك جسيم من الموظف يستوجب الفصل دون إشعار.'
                    : 'Article 80 of the Labor Law outlines the accepted termination cases. The employer must provide written notice and final settlement unless serious employee misconduct is proven, which would justify dismissal without notice.',
                style: textTheme.bodyLarge?.copyWith(height: 1.8),
              ),
              const SizedBox(height: AppDimens.lg),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppDimens.md),
                decoration: BoxDecoration(
                  color: AppColors.gold.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  border: Border.all(color: AppColors.gold.withOpacity(0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.bookmark_outline_rounded, color: AppColors.gold, size: 20),
                    const SizedBox(width: AppDimens.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.t(isArabic, 'regulatory_reference'),
                            style: textTheme.labelMedium?.copyWith(color: AppColors.textMuted),
                          ),
                          Text(
                            isArabic
                                ? 'نظام العمل السعودي - المادة ٨٠'
                                : 'Saudi Labor Law - Article 80',
                            style: textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimens.xl),

              SizedBox(
                width: double.infinity,
                height: AppDimens.buttonHeight,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LawyerListScreen()),
                    );
                  },
                  icon: const Icon(Icons.gavel_rounded),
                  label: Text(AppStrings.t(isArabic, 'discuss_with_lawyer')),
                ),
              ),
              const SizedBox(height: AppDimens.lg),
            ],
          ),
        ),
      ),
    );
  }
}
