import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../utils/app_strings.dart';
import '../../utils/locale_provider.dart';
import '../../models/lawyer_model.dart';
import 'booking_screen.dart';

enum ConsultationType { chat, voice, video }

class LawyerProfileScreen extends ConsumerStatefulWidget {
  final LawyerModel lawyer;
  const LawyerProfileScreen({super.key, required this.lawyer});

  @override
  ConsumerState<LawyerProfileScreen> createState() => _LawyerProfileScreenState();
}

class _LawyerProfileScreenState extends ConsumerState<LawyerProfileScreen> {
  ConsultationType _selectedType = ConsultationType.chat;

  @override
  Widget build(BuildContext context) {
    final isArabic = ref.watch(localeProvider).languageCode == 'ar';
    final textTheme = Theme.of(context).textTheme;
    final lawyer = widget.lawyer;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding, vertical: AppDimens.sm),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(isArabic ? Icons.arrow_forward_rounded : Icons.arrow_back_rounded),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border_rounded),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.navy.withOpacity(0.08),
                      child: Icon(Icons.person_rounded, color: AppColors.navy, size: 56),
                    ),
                    const SizedBox(height: AppDimens.md),
                    Text(lawyer.name, style: textTheme.headlineMedium),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.navy.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                      ),
                      child: Text(
                        lawyer.specialization(isArabic),
                        style: textTheme.labelMedium?.copyWith(color: AppColors.navy),
                      ),
                    ),
                    const SizedBox(height: AppDimens.lg),

                    Row(
                      children: [
                        Expanded(
                          child: _StatBox(
                            icon: Icons.star_rounded,
                            iconColor: AppColors.gold,
                            value: '${lawyer.rating}',
                            label: AppStrings.t(isArabic, 'rating'),
                          ),
                        ),
                        Expanded(
                          child: _StatBox(
                            icon: Icons.work_outline_rounded,
                            iconColor: AppColors.teal,
                            value: '${lawyer.yearsExperience}+',
                            label: AppStrings.t(isArabic, 'years_experience'),
                          ),
                        ),
                        Expanded(
                          child: _StatBox(
                            icon: Icons.people_outline_rounded,
                            iconColor: AppColors.navy,
                            value: '${lawyer.reviewsCount}',
                            label: AppStrings.t(isArabic, 'rating'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimens.lg),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(AppStrings.t(isArabic, 'consultation_type'),
                          style: textTheme.titleMedium),
                    ),
                    const SizedBox(height: AppDimens.sm),
                    Row(
                      children: [
                        Expanded(
                          child: _TypeOption(
                            icon: Icons.chat_bubble_outline_rounded,
                            label: AppStrings.t(isArabic, 'chat_consultation'),
                            selected: _selectedType == ConsultationType.chat,
                            onTap: () => setState(() => _selectedType = ConsultationType.chat),
                          ),
                        ),
                        const SizedBox(width: AppDimens.sm),
                        Expanded(
                          child: _TypeOption(
                            icon: Icons.call_outlined,
                            label: AppStrings.t(isArabic, 'voice_consultation'),
                            selected: _selectedType == ConsultationType.voice,
                            onTap: () => setState(() => _selectedType = ConsultationType.voice),
                          ),
                        ),
                        const SizedBox(width: AppDimens.sm),
                        Expanded(
                          child: _TypeOption(
                            icon: Icons.videocam_outlined,
                            label: AppStrings.t(isArabic, 'video_consultation'),
                            selected: _selectedType == ConsultationType.video,
                            onTap: () => setState(() => _selectedType = ConsultationType.video),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimens.lg),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        isArabic ? 'نبذة' : 'About',
                        style: textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: AppDimens.sm),
                    Text(
                      isArabic
                          ? 'محامٍ مرخص من وزارة العدل السعودية، متخصص في ${lawyer.specializationAr} مع خبرة ${lawyer.yearsExperience} سنوات في تمثيل الأفراد والشركات.'
                          : 'Licensed lawyer by the Saudi Ministry of Justice, specialized in ${lawyer.specializationEn} with ${lawyer.yearsExperience} years of experience representing individuals and companies.',
                      style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: AppDimens.xxl),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(AppDimens.pagePadding),
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: AppColors.cardShadow,
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.t(isArabic, 'price_per_session'),
                          style: textTheme.labelSmall?.copyWith(color: AppColors.textMuted),
                        ),
                        Text(
                          '${lawyer.pricePerSession.toInt()} ${AppStrings.t(isArabic, "sar")}',
                          style: textTheme.titleLarge?.copyWith(color: AppColors.navy),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BookingScreen(
                                lawyer: lawyer,
                                consultationType: _selectedType,
                              ),
                            ),
                          );
                        },
                        child: Text(AppStrings.t(isArabic, 'book_now')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatBox({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
        Text(label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppColors.textMuted)),
      ],
    );
  }
}

class _TypeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TypeOption({
    required this.icon,
    required this.label,
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
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: selected ? AppColors.navy : AppColors.surfaceMuted,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        ),
        child: Column(
          children: [
            Icon(icon, color: selected ? Colors.white : AppColors.textSecondary, size: 22),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
