import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../utils/app_strings.dart';
import '../../utils/locale_provider.dart';
import '../consultation/lawyer_list_screen.dart';
import '../documents/ai_legal_screen.dart';
import '../laws/laws_screen.dart';
import '../documentation/documentation_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = ref.watch(localeProvider).languageCode == 'ar';
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ===== Header =====
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppDimens.pagePadding, AppDimens.md, AppDimens.pagePadding, 0),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        boxShadow: AppColors.cardShadow,
                      ),
                      child: Image.asset('assets/images/logo.webp'),
                    ),
                    const SizedBox(width: AppDimens.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${AppStrings.t(isArabic, 'hello')}, ثائر 👋',
                            style: textTheme.titleMedium,
                          ),
                          Text(
                            AppStrings.t(isArabic, 'how_can_we_help'),
                            style: textTheme.bodySmall
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_outlined),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.surface,
                        shape: const CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ===== Hero AI Banner =====
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.pagePadding),
                child: _AiHeroBanner(isArabic: isArabic),
              ),
            ),

            // ===== Services Grid =====
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
                child: Text(AppStrings.t(isArabic, 'our_services'),
                    style: textTheme.headlineSmall),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(AppDimens.pagePadding),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppDimens.md,
                  crossAxisSpacing: AppDimens.md,
                  childAspectRatio: 1.05,
                ),
                delegate: SliverChildListDelegate([
                  _ServiceCard(
                    icon: Icons.gavel_rounded,
                    color: AppColors.navy,
                    label: AppStrings.t(isArabic, 'service_consultation'),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LawyerListScreen()),
                    ),
                  ),
                  _ServiceCard(
                    icon: Icons.document_scanner_rounded,
                    color: AppColors.teal,
                    label: AppStrings.t(isArabic, 'service_documents'),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AiLegalScreen()),
                    ),
                  ),
                  _ServiceCard(
                    icon: Icons.menu_book_rounded,
                    color: AppColors.gold,
                    label: AppStrings.t(isArabic, 'service_laws'),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LawsScreen()),
                    ),
                  ),
                  _ServiceCard(
                    icon: Icons.verified_outlined,
                    color: AppColors.success,
                    label: AppStrings.t(isArabic, 'service_documentation'),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const DocumentationScreen()),
                    ),
                  ),
                ]),
              ),
            ),

            // ===== Top Lawyers =====
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppStrings.t(isArabic, 'top_lawyers'),
                        style: textTheme.headlineSmall),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const LawyerListScreen()),
                      ),
                      child: Text(AppStrings.t(isArabic, 'see_all')),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 190,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
                  itemCount: _demoLawyers.length,
                  itemBuilder: (context, index) {
                    final lawyer = _demoLawyers[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: AppDimens.md),
                      child: _LawyerCard(data: lawyer, isArabic: isArabic),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: AppDimens.xxl)),
          ],
        ),
      ),
    );
  }
}

final _demoLawyers = [
  {'name': 'د. بلال الزبطية', 'spec_ar': 'القانون التجاري', 'spec_en': 'Commercial Law', 'rating': '4.9'},
  {'name': 'أ. سارة العتيبي', 'spec_ar': 'الأحوال الشخصية', 'spec_en': 'Family Law', 'rating': '4.8'},
  {'name': 'أ. خالد المطيري', 'spec_ar': 'قانون العمل', 'spec_en': 'Labor Law', 'rating': '4.7'},
];

class _AiHeroBanner extends StatelessWidget {
  final bool isArabic;
  const _AiHeroBanner({required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.lg),
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.circular(AppDimens.radiusXl),
        boxShadow: AppColors.elevatedShadow,
      ),
      child: Stack(
        children: [
          Positioned(
            left: isArabic ? null : -20,
            right: isArabic ? -20 : null,
            top: -20,
            child: Icon(Icons.auto_awesome_rounded,
                size: 120, color: Colors.white.withOpacity(0.06)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  gradient: AppColors.accentGradient,
                  borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                ),
                child: const Text(
                  'AI',
                  style: TextStyle(
                      color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: AppDimens.md),
              Text(
                isArabic
                    ? 'اسأل، حلّل، وافهم القانون بثقة'
                    : 'Ask, analyze, and understand the law with confidence',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: AppDimens.lg),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const AiLegalScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.navy,
                      ),
                      child: Text(AppStrings.t(isArabic, 'try_legal_ai')),
                    ),
                  ),
                  const SizedBox(width: AppDimens.sm),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const LawyerListScreen()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white54),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        AppStrings.t(isArabic, 'book_consultation'),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              ),
              child: Icon(icon, color: color),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _LawyerCard extends StatelessWidget {
  final Map<String, String> data;
  final bool isArabic;

  const _LawyerCard({required this.data, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.navy.withOpacity(0.08),
            child: Icon(Icons.person_rounded, color: AppColors.navy, size: 28),
          ),
          const SizedBox(height: AppDimens.sm),
          Text(
            data['name']!,
            style: Theme.of(context).textTheme.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            isArabic ? data['spec_ar']! : data['spec_en']!,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.textMuted),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Row(
            children: [
              const Icon(Icons.star_rounded, color: AppColors.gold, size: 16),
              const SizedBox(width: 2),
              Text(data['rating']!, style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
        ],
      ),
    );
  }
}
