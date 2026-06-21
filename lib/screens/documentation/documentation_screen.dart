import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../utils/app_strings.dart';
import '../../utils/locale_provider.dart';

class DocumentationScreen extends ConsumerWidget {
  const DocumentationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = ref.watch(localeProvider).languageCode == 'ar';
    final textTheme = Theme.of(context).textTheme;

    final services = [
      {
        'icon': Icons.assignment_outlined,
        'title': AppStrings.t(isArabic, 'power_of_attorney'),
        'desc': isArabic ? 'إنشاء أو فسخ وكالة موثقة' : 'Create or revoke a notarized power of attorney',
        'color': AppColors.navy,
      },
      {
        'icon': Icons.business_outlined,
        'title': AppStrings.t(isArabic, 'company_formation'),
        'desc': isArabic ? 'تأسيس شركة وتوثيق عقد التأسيس' : 'Establish a company and notarize its articles',
        'color': AppColors.teal,
      },
      {
        'icon': Icons.real_estate_agent_outlined,
        'title': AppStrings.t(isArabic, 'mortgage_release'),
        'desc': isArabic ? 'توثيق الرهن العقاري أو فسخه' : 'Notarize or release a property mortgage',
        'color': AppColors.gold,
      },
      {
        'icon': Icons.description_outlined,
        'title': AppStrings.t(isArabic, 'financial_disclosure'),
        'desc': isArabic ? 'توثيق الإقرارات المالية' : 'Notarize financial disclosures',
        'color': AppColors.success,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(AppStrings.t(isArabic, 'documentation_title'))),
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
                  color: AppColors.success.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                  border: Border.all(color: AppColors.success.withOpacity(0.25)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified_rounded, color: AppColors.success),
                    const SizedBox(width: AppDimens.sm),
                    Expanded(
                      child: Text(
                        AppStrings.t(isArabic, 'verified_notaries'),
                        style: textTheme.titleSmall?.copyWith(color: AppColors.success),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimens.lg),

              ...services.map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: AppDimens.md),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                      child: Container(
                        padding: const EdgeInsets.all(AppDimens.md),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                          border: Border.all(color: AppColors.cardBorder),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: (s['color'] as Color).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                              ),
                              child: Icon(s['icon'] as IconData, color: s['color'] as Color),
                            ),
                            const SizedBox(width: AppDimens.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(s['title'] as String, style: textTheme.titleSmall),
                                  const SizedBox(height: 2),
                                  Text(
                                    s['desc'] as String,
                                    style: textTheme.bodySmall
                                        ?.copyWith(color: AppColors.textMuted),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              isArabic
                                  ? Icons.arrow_back_ios_rounded
                                  : Icons.arrow_forward_ios_rounded,
                              size: 14,
                              color: AppColors.textMuted,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: AppDimens.sm),

              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.search_rounded),
                label: Text(AppStrings.t(isArabic, 'verify_license')),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, AppDimens.buttonHeight),
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
