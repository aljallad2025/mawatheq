import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../utils/app_strings.dart';
import '../../utils/locale_provider.dart';
import 'law_answer_screen.dart';

class LawsScreen extends ConsumerWidget {
  const LawsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = ref.watch(localeProvider).languageCode == 'ar';
    final textTheme = Theme.of(context).textTheme;

    final categories = [
      {'icon': Icons.work_outline_rounded, 'label_ar': 'نظام العمل', 'label_en': 'Labor Law', 'color': AppColors.navy},
      {'icon': Icons.family_restroom_rounded, 'label_ar': 'الأحوال الشخصية', 'label_en': 'Family Law', 'color': AppColors.teal},
      {'icon': Icons.store_outlined, 'label_ar': 'النظام التجاري', 'label_en': 'Commercial Law', 'color': AppColors.gold},
      {'icon': Icons.home_work_outlined, 'label_ar': 'النظام العقاري', 'label_en': 'Real Estate', 'color': AppColors.success},
      {'icon': Icons.security_outlined, 'label_ar': 'النظام الجنائي', 'label_en': 'Criminal Law', 'color': AppColors.danger},
      {'icon': Icons.copyright_outlined, 'label_ar': 'الملكية الفكرية', 'label_en': 'IP Law', 'color': AppColors.warning},
    ];

    final popularQuestions = isArabic
        ? [
            'ما شروط إنهاء عقد العمل؟',
            'كيف يتم تسجيل العلامة التجارية؟',
            'ما حقوق الموظف عند الاستقالة؟',
            'شروط تأسيس شركة ذات مسؤولية محدودة',
          ]
        : [
            'Conditions for ending an employment contract',
            'How to register a trademark',
            'Employee rights upon resignation',
            'Requirements for establishing an LLC',
          ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(AppDimens.pagePadding, AppDimens.md,
                    AppDimens.pagePadding, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.t(isArabic, 'laws_title'), style: textTheme.headlineMedium),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.t(isArabic, 'laws_subtitle'),
                      style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: AppDimens.lg),
                    TextField(
                      decoration: InputDecoration(
                        hintText: AppStrings.t(isArabic, 'search_laws_placeholder'),
                        prefixIcon: const Icon(Icons.search_rounded),
                      ),
                      onSubmitted: (q) {
                        if (q.trim().isEmpty) return;
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => LawAnswerScreen(question: q)),
                        );
                      },
                    ),
                    const SizedBox(height: AppDimens.lg),
                    Text(AppStrings.t(isArabic, 'browse_categories'), style: textTheme.titleMedium),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(AppDimens.pagePadding),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: AppDimens.sm,
                  crossAxisSpacing: AppDimens.sm,
                  childAspectRatio: 0.9,
                ),
                delegate: SliverChildListDelegate(
                  categories.map((c) {
                    return InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                      child: Container(
                        padding: const EdgeInsets.all(AppDimens.sm),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                          border: Border.all(color: AppColors.cardBorder),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(c['icon'] as IconData, color: c['color'] as Color, size: 26),
                            const SizedBox(height: 6),
                            Text(
                              isArabic ? c['label_ar'] as String : c['label_en'] as String,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
                child: Text(AppStrings.t(isArabic, 'popular_questions'), style: textTheme.titleMedium),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(AppDimens.pagePadding),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  popularQuestions.map((q) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppDimens.sm),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => LawAnswerScreen(question: q)),
                          );
                        },
                        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                        child: Container(
                          padding: const EdgeInsets.all(AppDimens.md),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                            border: Border.all(color: AppColors.cardBorder),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.menu_book_outlined,
                                  size: 18, color: AppColors.navy),
                              const SizedBox(width: AppDimens.sm),
                              Expanded(child: Text(q, style: textTheme.bodyMedium)),
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
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
