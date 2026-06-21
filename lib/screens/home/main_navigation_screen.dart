import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/locale_provider.dart';
import 'home_screen.dart';
import '../consultation/consultations_screen.dart';
import '../documents/ai_legal_screen.dart';
import '../laws/laws_screen.dart';
import '../profile/profile_screen.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  ConsumerState<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ConsultationsScreen(),
    AiLegalScreen(),
    LawsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isArabic = ref.watch(localeProvider).languageCode == 'ar';

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: AppColors.navy.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home_rounded),
                label: AppStrings.t(isArabic, 'nav_home'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.calendar_month_outlined),
                activeIcon: const Icon(Icons.calendar_month_rounded),
                label: AppStrings.t(isArabic, 'nav_consultations'),
              ),
              BottomNavigationBarItem(
                icon: const _AiNavIcon(active: false),
                activeIcon: const _AiNavIcon(active: true),
                label: AppStrings.t(isArabic, 'nav_ai'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.menu_book_outlined),
                activeIcon: const Icon(Icons.menu_book_rounded),
                label: AppStrings.t(isArabic, 'nav_laws'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline_rounded),
                activeIcon: const Icon(Icons.person_rounded),
                label: AppStrings.t(isArabic, 'nav_profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// أيقونة مميزة لقسم الذكاء الاصطناعي القانوني بتدرج الهوية
class _AiNavIcon extends StatelessWidget {
  final bool active;
  const _AiNavIcon({required this.active});

  @override
  Widget build(BuildContext context) {
    if (!active) {
      return const Icon(Icons.auto_awesome_outlined);
    }
    return ShaderMask(
      shaderCallback: (bounds) => AppColors.accentGradient.createShader(bounds),
      child: const Icon(Icons.auto_awesome_rounded, color: Colors.white),
    );
  }
}
