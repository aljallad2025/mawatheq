import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../utils/app_strings.dart';
import '../../utils/locale_provider.dart';
import '../../models/lawyer_model.dart';
import 'lawyer_profile_screen.dart';
import 'booking_success_screen.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final LawyerModel lawyer;
  final ConsultationType consultationType;

  const BookingScreen({
    super.key,
    required this.lawyer,
    required this.consultationType,
  });

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  DateTime _selectedDate = DateTime.now();
  int _selectedSlotIndex = -1;
  final _issueController = TextEditingController();

  final List<String> _timeSlots = [
    '10:00 ص', '11:00 ص', '12:00 م', '01:00 م',
    '04:00 م', '05:00 م', '06:00 م', '08:00 م',
  ];

  List<DateTime> get _next7Days =>
      List.generate(7, (i) => DateTime.now().add(Duration(days: i)));

  IconData get _typeIcon {
    switch (widget.consultationType) {
      case ConsultationType.voice:
        return Icons.call_outlined;
      case ConsultationType.video:
        return Icons.videocam_outlined;
      case ConsultationType.chat:
        return Icons.chat_bubble_outline_rounded;
    }
  }

  @override
  void dispose() {
    _issueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = ref.watch(localeProvider).languageCode == 'ar';
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(AppStrings.t(isArabic, 'book_now'))),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
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
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.navy.withOpacity(0.08),
                            child: Icon(Icons.person_rounded, color: AppColors.navy),
                          ),
                          const SizedBox(width: AppDimens.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.lawyer.name, style: textTheme.titleMedium),
                                Text(
                                  widget.lawyer.specialization(isArabic),
                                  style: textTheme.bodySmall
                                      ?.copyWith(color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.teal.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(_typeIcon, color: AppColors.teal, size: 18),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimens.lg),

                    Text(AppStrings.t(isArabic, 'select_date'), style: textTheme.titleMedium),
                    const SizedBox(height: AppDimens.sm),
                    SizedBox(
                      height: 76,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _next7Days.length,
                        itemBuilder: (context, index) {
                          final date = _next7Days[index];
                          final selected = date.day == _selectedDate.day &&
                              date.month == _selectedDate.month;
                          return Padding(
                            padding: const EdgeInsets.only(left: AppDimens.sm),
                            child: InkWell(
                              onTap: () => setState(() => _selectedDate = date),
                              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 58,
                                decoration: BoxDecoration(
                                  color: selected ? AppColors.navy : AppColors.surface,
                                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                                  border: Border.all(
                                    color: selected ? AppColors.navy : AppColors.cardBorder,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _weekdayShort(date.weekday, isArabic),
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: selected
                                            ? Colors.white70
                                            : AppColors.textMuted,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${date.day}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: selected ? Colors.white : AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppDimens.lg),

                    Text(AppStrings.t(isArabic, 'select_time'), style: textTheme.titleMedium),
                    const SizedBox(height: AppDimens.sm),
                    Wrap(
                      spacing: AppDimens.sm,
                      runSpacing: AppDimens.sm,
                      children: List.generate(_timeSlots.length, (index) {
                        final selected = _selectedSlotIndex == index;
                        return InkWell(
                          onTap: () => setState(() => _selectedSlotIndex = index),
                          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: selected ? AppColors.navy : AppColors.surface,
                              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                              border: Border.all(
                                color: selected ? AppColors.navy : AppColors.cardBorder,
                              ),
                            ),
                            child: Text(
                              _timeSlots[index],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: selected ? Colors.white : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: AppDimens.lg),

                    Text(AppStrings.t(isArabic, 'describe_issue'), style: textTheme.titleMedium),
                    const SizedBox(height: AppDimens.sm),
                    TextField(
                      controller: _issueController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: isArabic
                            ? 'مثال: أحتاج مراجعة عقد إيجار تجاري...'
                            : 'e.g. I need to review a commercial lease...',
                      ),
                    ),
                    const SizedBox(height: AppDimens.xl),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(AppDimens.pagePadding),
              decoration: BoxDecoration(color: AppColors.surface, boxShadow: AppColors.cardShadow),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  height: AppDimens.buttonHeight,
                  child: ElevatedButton(
                    onPressed: (_selectedSlotIndex == -1)
                        ? null
                        : () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => BookingSuccessScreen(lawyer: widget.lawyer),
                              ),
                            );
                          },
                    child: Text(AppStrings.t(isArabic, 'confirm_booking')),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _weekdayShort(int weekday, bool isArabic) {
    const ar = ['اث', 'ثل', 'أر', 'خم', 'جم', 'سب', 'أح'];
    const en = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return isArabic ? ar[weekday - 1] : en[weekday - 1];
  }
}
