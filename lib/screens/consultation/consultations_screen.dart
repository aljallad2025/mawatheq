import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../utils/app_strings.dart';
import '../../utils/locale_provider.dart';

class ConsultationsScreen extends ConsumerStatefulWidget {
  const ConsultationsScreen({super.key});

  @override
  ConsumerState<ConsultationsScreen> createState() => _ConsultationsScreenState();
}

class _ConsultationsScreenState extends ConsumerState<ConsultationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _upcoming = [
    {
      'name': 'د. بلال أحمد الزبطية',
      'spec_ar': 'القانون التجاري',
      'spec_en': 'Commercial Law',
      'date': '22 يونيو 2026',
      'time': '11:00 ص',
      'type': Icons.videocam_outlined,
    },
  ];

  final List<Map<String, dynamic>> _past = [
    {
      'name': 'أ. سارة العتيبي',
      'spec_ar': 'الأحوال الشخصية',
      'spec_en': 'Family Law',
      'date': '10 يونيو 2026',
      'time': '04:00 م',
      'type': Icons.chat_bubble_outline_rounded,
    },
    {
      'name': 'أ. خالد المطيري',
      'spec_ar': 'قانون العمل',
      'spec_en': 'Labor Law',
      'date': '02 يونيو 2026',
      'time': '01:00 م',
      'type': Icons.call_outlined,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = ref.watch(localeProvider).languageCode == 'ar';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppStrings.t(isArabic, 'my_bookings')),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: isArabic ? 'القادمة' : 'Upcoming'),
            Tab(text: isArabic ? 'السابقة' : 'Past'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildList(_upcoming, isArabic, isPast: false),
            _buildList(_past, isArabic, isPast: true),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> items, bool isArabic, {required bool isPast}) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today_outlined, size: 56, color: AppColors.textMuted),
            const SizedBox(height: AppDimens.md),
            Text(
              AppStrings.t(isArabic, 'no_activity_yet'),
              style: TextStyle(color: AppColors.textMuted),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppDimens.md),
          child: Container(
            padding: const EdgeInsets.all(AppDimens.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppDimens.radiusLg),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: AppColors.navy.withOpacity(0.08),
                  child: Icon(Icons.person_rounded, color: AppColors.navy),
                ),
                const SizedBox(width: AppDimens.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['name'], style: Theme.of(context).textTheme.titleMedium),
                      Text(
                        isArabic ? item['spec_ar'] : item['spec_en'],
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined,
                              size: 12, color: AppColors.textMuted),
                          const SizedBox(width: 4),
                          Text(item['date'],
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: AppColors.textMuted)),
                          const SizedBox(width: AppDimens.sm),
                          Icon(Icons.access_time_rounded,
                              size: 12, color: AppColors.textMuted),
                          const SizedBox(width: 4),
                          Text(item['time'],
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: AppColors.textMuted)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isPast
                        ? AppColors.surfaceMuted
                        : AppColors.teal.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item['type'],
                    size: 18,
                    color: isPast ? AppColors.textMuted : AppColors.teal,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
