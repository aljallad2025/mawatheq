import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../utils/app_strings.dart';
import '../../utils/locale_provider.dart';
import '../consultation/lawyer_list_screen.dart';

class DocumentAnalysisScreen extends ConsumerWidget {
  const DocumentAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = ref.watch(localeProvider).languageCode == 'ar';
    final textTheme = Theme.of(context).textTheme;

    final risks = isArabic
        ? [
            'يسمح البند الخامس بتغيير الأسعار من طرف واحد دون إشعار مسبق.',
            'لا يوجد بند واضح لتسوية النزاعات أو التحكيم.',
            'مدة الإشعار لفسخ العقد غير محددة بوضوح.',
          ]
        : [
            'Clause 5 allows unilateral price changes without prior notice.',
            'No clear dispute resolution or arbitration clause.',
            'Termination notice period is not clearly defined.',
          ];

    final recommendations = isArabic
        ? [
            'إضافة مهلة ٣٠ يوماً وموافقة متبادلة لأي تعديل مستقبلي على الأسعار.',
            'تضمين بند تحكيم واضح يحدد الجهة المختصة بالنظر في النزاعات.',
            'تحديد مدة إشعار لا تقل عن ٦٠ يوماً قبل الفسخ.',
          ]
        : [
            'Add a 30-day notice + mutual agreement requirement for price changes.',
            'Include a clear arbitration clause specifying jurisdiction.',
            'Define a minimum 60-day termination notice period.',
          ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(AppStrings.t(isArabic, 'analysis_summary'))),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.pagePadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimens.md),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.teal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                      ),
                      child: const Icon(Icons.picture_as_pdf_rounded, color: AppColors.teal),
                    ),
                    const SizedBox(width: AppDimens.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('عقد_توريد_2026.pdf', style: textTheme.titleSmall),
                          Text(
                            isArabic ? 'تم التحليل بنجاح' : 'Analysis completed',
                            style: textTheme.bodySmall?.copyWith(color: AppColors.success),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.check_circle_rounded, color: AppColors.success),
                  ],
                ),
              ),
              const SizedBox(height: AppDimens.lg),

              _SectionHeader(
                  icon: Icons.summarize_outlined,
                  color: AppColors.navy,
                  title: AppStrings.t(isArabic, 'analysis_summary')),
              const SizedBox(height: AppDimens.sm),
              Text(
                isArabic
                    ? 'هذا عقد توريد بين طرفين لمدة سنة قابلة للتجديد، يتضمن بنود التسليم والدفع والجزاءات. تم رصد عدة نقاط تحتاج مراجعة قانونية قبل التوقيع.'
                    : 'This is a one-year renewable supply contract between two parties, including delivery, payment, and penalty clauses. Several points require legal review before signing.',
                style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary, height: 1.7),
              ),
              const SizedBox(height: AppDimens.lg),

              _SectionHeader(
                  icon: Icons.warning_amber_rounded,
                  color: AppColors.danger,
                  title: AppStrings.t(isArabic, 'risk_points')),
              const SizedBox(height: AppDimens.sm),
              ...risks.map((r) => _BulletItem(text: r, color: AppColors.danger)),
              const SizedBox(height: AppDimens.lg),

              _SectionHeader(
                  icon: Icons.lightbulb_outline_rounded,
                  color: AppColors.success,
                  title: AppStrings.t(isArabic, 'recommendations')),
              const SizedBox(height: AppDimens.sm),
              ...recommendations.map((r) => _BulletItem(text: r, color: AppColors.success)),
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

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;

  const _SectionHeader({required this.icon, required this.color, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(title, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String text;
  final Color color;

  const _BulletItem({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.textSecondary, height: 1.6),
            ),
          ),
        ],
      ),
    );
  }
}
