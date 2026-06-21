import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimens.dart';
import '../../utils/app_strings.dart';
import '../../utils/locale_provider.dart';
import 'document_upload_screen.dart';
import 'document_analysis_screen.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}

class AiLegalScreen extends ConsumerStatefulWidget {
  const AiLegalScreen({super.key});

  @override
  ConsumerState<AiLegalScreen> createState() => _AiLegalScreenState();
}

class _AiLegalScreenState extends ConsumerState<AiLegalScreen> {
  final _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _showWelcome = true;

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _showWelcome = false;
      _messages.add(ChatMessage(text: text, isUser: true));
    });
    _messageController.clear();

    // رد توضيحي تجريبي (Mock) — سيُستبدل لاحقاً بنداء API فعلي
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      final isArabic = ref.read(localeProvider).languageCode == 'ar';
      setState(() {
        _messages.add(ChatMessage(
          text: isArabic
              ? 'تنص المادة ٨٠ من نظام العمل السعودي على حالات إنهاء العقد المقبولة. يجب على صاحب العمل تقديم إشعار خطي وتسوية نهائية، ما لم يثبت سوء سلوك جسيم من الموظف.'
              : 'Article 80 of the Saudi Labor Law outlines the accepted cases for contract termination. The employer must provide written notice and final settlement, unless serious misconduct by the employee is proven.',
          isUser: false,
        ));
      });
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = ref.watch(localeProvider).languageCode == 'ar';
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShaderMask(
              shaderCallback: (b) => AppColors.accentGradient.createShader(b),
              child: const Icon(Icons.auto_awesome_rounded, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Text(AppStrings.t(isArabic, 'nav_ai')),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DocumentUploadScreen()),
              );
            },
            icon: const Icon(Icons.upload_file_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _showWelcome
                  ? _buildWelcome(isArabic, textTheme)
                  : ListView.builder(
                      padding: const EdgeInsets.all(AppDimens.pagePadding),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        return _ChatBubble(message: msg);
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimens.pagePadding),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.md, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppDimens.radiusXl),
                  border: Border.all(color: AppColors.cardBorder),
                  boxShadow: AppColors.cardShadow,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const DocumentUploadScreen()),
                        );
                      },
                      icon: const Icon(Icons.attach_file_rounded, color: AppColors.textMuted),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: AppStrings.t(isArabic, 'ask_ai_placeholder'),
                          filled: false,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onSubmitted: _sendMessage,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: AppColors.accentGradient,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => _sendMessage(_messageController.text),
                        icon: Icon(
                          isArabic ? Icons.arrow_back_rounded : Icons.arrow_forward_rounded,
                          color: Colors.white,
                        ),
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

  Widget _buildWelcome(bool isArabic, TextTheme textTheme) {
    final suggestions = isArabic
        ? [
            'ما شروط إنهاء عقد العمل في السعودية؟',
            'كيف أؤسس شركة ذات مسؤولية محدودة؟',
            'ما حقوقي في حالة فسخ عقد الإيجار؟',
          ]
        : [
            'What are the conditions for ending an employment contract?',
            'How do I establish an LLC in Saudi Arabia?',
            'What are my rights if a lease is terminated?',
          ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      child: Column(
        children: [
          const SizedBox(height: AppDimens.lg),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 40),
          ),
          const SizedBox(height: AppDimens.lg),
          Text(
            isArabic ? 'مرحباً، أنا مساعدك القانوني' : "Hi, I'm your legal assistant",
            textAlign: TextAlign.center,
            style: textTheme.headlineMedium,
          ),
          const SizedBox(height: AppDimens.sm),
          Text(
            isArabic
                ? 'اسأل عن الأنظمة السعودية أو ارفع مستنداً لتحليله'
                : 'Ask about Saudi regulations or upload a document to analyze',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimens.xl),

          // بطاقة تحليل المستندات السريعة
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DocumentUploadScreen()),
              );
            },
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimens.md),
              decoration: BoxDecoration(
                color: AppColors.teal.withOpacity(0.07),
                borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                border: Border.all(color: AppColors.teal.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.teal.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                    ),
                    child: const Icon(Icons.document_scanner_rounded, color: AppColors.teal),
                  ),
                  const SizedBox(width: AppDimens.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.t(isArabic, 'upload_document'),
                            style: textTheme.titleSmall),
                        Text(
                          isArabic ? 'PDF أو صورة' : 'PDF or image',
                          style: textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isArabic ? Icons.arrow_back_ios_rounded : Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppDimens.lg),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              isArabic ? 'أسئلة مقترحة' : 'Suggested questions',
              style: textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: AppDimens.sm),
          ...suggestions.map((q) => Padding(
                padding: const EdgeInsets.only(bottom: AppDimens.sm),
                child: InkWell(
                  onTap: () => _sendMessage(q),
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppDimens.md),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lightbulb_outline_rounded,
                            size: 18, color: AppColors.gold),
                        const SizedBox(width: AppDimens.sm),
                        Expanded(child: Text(q, style: textTheme.bodyMedium)),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;
  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppDimens.md),
        padding: const EdgeInsets.all(AppDimens.md),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
        decoration: BoxDecoration(
          color: message.isUser ? AppColors.navy : AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
          border: message.isUser ? null : Border.all(color: AppColors.cardBorder),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? Colors.white : AppColors.textPrimary,
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ),
    );
  }
}
