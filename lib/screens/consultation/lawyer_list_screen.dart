import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../utils/app_strings.dart';
import '../../utils/locale_provider.dart';
import '../../models/lawyer_model.dart';
import 'lawyer_profile_screen.dart';

class LawyerListScreen extends ConsumerStatefulWidget {
  const LawyerListScreen({super.key});

  @override
  ConsumerState<LawyerListScreen> createState() => _LawyerListScreenState();
}

class _LawyerListScreenState extends ConsumerState<LawyerListScreen> {
  String? _selectedFilter;
  final _lawyers = LawyerModel.demoList();

  final List<String> _filterKeys = [
    'family_law',
    'commercial_law',
    'labor_law',
    'real_estate_law',
    'criminal_law',
    'ip_law',
  ];

  @override
  Widget build(BuildContext context) {
    final isArabic = ref.watch(localeProvider).languageCode == 'ar';
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(AppStrings.t(isArabic, 'choose_lawyer'))),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
              child: TextField(
                decoration: InputDecoration(
                  hintText: AppStrings.t(isArabic, 'search'),
                  prefixIcon: const Icon(Icons.search_rounded),
                ),
              ),
            ),
            const SizedBox(height: AppDimens.md),
            SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
                itemCount: _filterKeys.length,
                itemBuilder: (context, index) {
                  final key = _filterKeys[index];
                  final selected = _selectedFilter == key;
                  return Padding(
                    padding: const EdgeInsets.only(left: AppDimens.sm),
                    child: FilterChip(
                      label: Text(AppStrings.t(isArabic, key)),
                      selected: selected,
                      onSelected: (val) {
                        setState(() => _selectedFilter = val ? key : null);
                      },
                      selectedColor: AppColors.navy.withOpacity(0.12),
                      checkmarkColor: AppColors.navy,
                      labelStyle: TextStyle(
                        color: selected ? AppColors.navy : AppColors.textSecondary,
                        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppDimens.md),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
                itemCount: _lawyers.length,
                itemBuilder: (context, index) {
                  final lawyer = _lawyers[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppDimens.md),
                    child: _LawyerListCard(
                      lawyer: lawyer,
                      isArabic: isArabic,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => LawyerProfileScreen(lawyer: lawyer),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LawyerListCard extends StatelessWidget {
  final LawyerModel lawyer;
  final bool isArabic;
  final VoidCallback onTap;

  const _LawyerListCard({
    required this.lawyer,
    required this.isArabic,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
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
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.navy.withOpacity(0.08),
                  child: Icon(Icons.person_rounded, color: AppColors.navy, size: 32),
                ),
                if (lawyer.isOnline)
                  Positioned(
                    bottom: 0,
                    right: isArabic ? null : 0,
                    left: isArabic ? 0 : null,
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.surface, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: AppDimens.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lawyer.name, style: textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(
                    lawyer.specialization(isArabic),
                    style: textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: AppColors.gold, size: 16),
                      const SizedBox(width: 2),
                      Text('${lawyer.rating}', style: textTheme.labelMedium),
                      const SizedBox(width: 2),
                      Text('(${lawyer.reviewsCount})',
                          style: textTheme.labelSmall
                              ?.copyWith(color: AppColors.textMuted)),
                      const SizedBox(width: AppDimens.sm),
                      Icon(Icons.work_outline_rounded,
                          size: 14, color: AppColors.textMuted),
                      const SizedBox(width: 2),
                      Text(
                        '${lawyer.yearsExperience} ${AppStrings.t(isArabic, "years_experience")}',
                        style: textTheme.labelSmall
                            ?.copyWith(color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${lawyer.pricePerSession.toInt()}',
                  style: textTheme.titleMedium?.copyWith(color: AppColors.navy),
                ),
                Text(
                  AppStrings.t(isArabic, 'sar'),
                  style: textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
