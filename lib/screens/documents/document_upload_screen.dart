import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../utils/app_strings.dart';
import '../../utils/locale_provider.dart';
import 'document_analysis_screen.dart';

class DocumentUploadScreen extends ConsumerStatefulWidget {
  const DocumentUploadScreen({super.key});

  @override
  ConsumerState<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends ConsumerState<DocumentUploadScreen> {
  String? _selectedFileName;
  bool _isAnalyzing = false;

  void _pickFile() {
    // TODO: استخدام file_picker الفعلي لاحقاً عند ربط الـ Backend
    setState(() => _selectedFileName = 'عقد_توريد_2026.pdf');
  }

  void _analyze() {
    setState(() => _isAnalyzing = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DocumentAnalysisScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = ref.watch(localeProvider).languageCode == 'ar';
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(AppStrings.t(isArabic, 'upload_document'))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.pagePadding),
          child: Column(
            children: [
              Text(
                AppStrings.t(isArabic, 'upload_document_desc'),
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppDimens.xl),

              InkWell(
                onTap: _pickFile,
                borderRadius: BorderRadius.circular(AppDimens.radiusXl),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: AppDimens.xxl),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppDimens.radiusXl),
                    border: Border.all(
                      color: _selectedFileName != null
                          ? AppColors.teal
                          : AppColors.cardBorder,
                      width: _selectedFileName != null ? 1.6 : 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: AppColors.teal.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _selectedFileName != null
                              ? Icons.picture_as_pdf_rounded
                              : Icons.cloud_upload_outlined,
                          color: AppColors.teal,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: AppDimens.md),
                      Text(
                        _selectedFileName ?? AppStrings.t(isArabic, 'tap_to_upload'),
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppStrings.t(isArabic, 'supported_formats'),
                        style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimens.xl),

              if (_isAnalyzing) ...[
                const CircularProgressIndicator(color: AppColors.navy),
                const SizedBox(height: AppDimens.md),
                Text(
                  AppStrings.t(isArabic, 'analyzing_document'),
                  style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                ),
              ],

              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: AppDimens.buttonHeight,
                child: ElevatedButton(
                  onPressed: (_selectedFileName == null || _isAnalyzing) ? null : _analyze,
                  child: Text(AppStrings.t(isArabic, 'continue')),
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
