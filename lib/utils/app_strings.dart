/// قاموس النصوص ثنائي اللغة — عربي / إنجليزي
/// الاستخدام: AppStrings.of(context).key  أو AppStrings.t(isArabic, 'key')
class AppStrings {
  AppStrings._();

  static const Map<String, Map<String, String>> _strings = {
    // ===== عام =====
    'app_name': {'ar': 'مواثيق', 'en': 'mawatheq'},
    'app_tagline': {
      'ar': 'منصتك القانونية الذكية',
      'en': 'Your Smart Legal Platform'
    },
    'continue': {'ar': 'استمرار', 'en': 'Continue'},
    'next': {'ar': 'التالي', 'en': 'Next'},
    'skip': {'ar': 'تخطي', 'en': 'Skip'},
    'back': {'ar': 'رجوع', 'en': 'Back'},
    'cancel': {'ar': 'إلغاء', 'en': 'Cancel'},
    'confirm': {'ar': 'تأكيد', 'en': 'Confirm'},
    'save': {'ar': 'حفظ', 'en': 'Save'},
    'search': {'ar': 'بحث', 'en': 'Search'},
    'see_all': {'ar': 'عرض الكل', 'en': 'See all'},
    'loading': {'ar': 'جاري التحميل...', 'en': 'Loading...'},

    // ===== Onboarding =====
    'onboard_title_1': {
      'ar': 'استشارات قانونية موثوقة',
      'en': 'Trusted Legal Consultations'
    },
    'onboard_desc_1': {
      'ar': 'تواصل مع محامين مرخصين عبر مكالمة صوتية أو فيديو أو محادثة نصية',
      'en': 'Connect with licensed lawyers via voice, video, or chat'
    },
    'onboard_title_2': {
      'ar': 'تحليل مستندات بالذكاء الاصطناعي',
      'en': 'AI-Powered Document Analysis'
    },
    'onboard_desc_2': {
      'ar': 'ارفع عقودك ومستنداتك واحصل على تلخيص فوري وبنود الخطر',
      'en': 'Upload your contracts and get instant summaries & risk points'
    },
    'onboard_title_3': {
      'ar': 'الأنظمة واللوائح السعودية',
      'en': 'Saudi Laws & Regulations'
    },
    'onboard_desc_3': {
      'ar': 'اسأل أي سؤال نظامي واحصل على إجابة موثقة بالمرجع القانوني',
      'en': 'Ask any legal question and get answers with regulatory references'
    },
    'get_started': {'ar': 'ابدأ الآن', 'en': 'Get Started'},

    // ===== Auth =====
    'login': {'ar': 'تسجيل الدخول', 'en': 'Login'},
    'register': {'ar': 'إنشاء حساب', 'en': 'Register'},
    'welcome_back': {'ar': 'مرحباً بعودتك', 'en': 'Welcome Back'},
    'login_subtitle': {
      'ar': 'سجّل دخولك للمتابعة',
      'en': 'Sign in to continue'
    },
    'phone_number': {'ar': 'رقم الهاتف', 'en': 'Phone Number'},
    'email': {'ar': 'البريد الإلكتروني', 'en': 'Email'},
    'password': {'ar': 'كلمة المرور', 'en': 'Password'},
    'full_name': {'ar': 'الاسم الكامل', 'en': 'Full Name'},
    'confirm_password': {'ar': 'تأكيد كلمة المرور', 'en': 'Confirm Password'},
    'forgot_password': {'ar': 'نسيت كلمة المرور؟', 'en': 'Forgot Password?'},
    'no_account': {
      'ar': 'ليس لديك حساب؟',
      'en': "Don't have an account?"
    },
    'have_account': {'ar': 'لديك حساب؟', 'en': 'Already have an account?'},
    'create_account': {'ar': 'إنشاء حساب جديد', 'en': 'Create New Account'},
    'or_continue_with': {'ar': 'أو الاستمرار باستخدام', 'en': 'Or continue with'},
    'account_type': {'ar': 'نوع الحساب', 'en': 'Account Type'},
    'individual': {'ar': 'فرد', 'en': 'Individual'},
    'lawyer': {'ar': 'محامٍ', 'en': 'Lawyer'},
    'company': {'ar': 'شركة', 'en': 'Company'},
    'verify_otp': {'ar': 'تأكيد رمز التحقق', 'en': 'Verify OTP'},
    'otp_sent': {
      'ar': 'تم إرسال رمز التحقق إلى',
      'en': 'Verification code sent to'
    },
    'resend_code': {'ar': 'إعادة إرسال الرمز', 'en': 'Resend Code'},

    // ===== Home =====
    'home': {'ar': 'الرئيسية', 'en': 'Home'},
    'hello': {'ar': 'مرحباً', 'en': 'Hello'},
    'how_can_we_help': {
      'ar': 'كيف نقدر نساعدك اليوم؟',
      'en': 'How can we help you today?'
    },
    'try_legal_ai': {'ar': 'جرّب الذكاء الاصطناعي القانوني', 'en': 'Try Legal AI'},
    'book_consultation': {'ar': 'احجز استشارة', 'en': 'Book Consultation'},
    'our_services': {'ar': 'خدماتنا', 'en': 'Our Services'},
    'service_consultation': {'ar': 'استشارة قانونية', 'en': 'Legal Consultation'},
    'service_documents': {'ar': 'تحليل المستندات', 'en': 'Document Analysis'},
    'service_laws': {'ar': 'الأنظمة واللوائح', 'en': 'Laws & Regulations'},
    'service_documentation': {'ar': 'التوثيق', 'en': 'Notarization'},
    'recent_activity': {'ar': 'النشاط الأخير', 'en': 'Recent Activity'},
    'no_activity_yet': {
      'ar': 'لا يوجد نشاط حتى الآن',
      'en': 'No activity yet'
    },
    'top_lawyers': {'ar': 'أفضل المحامين', 'en': 'Top Lawyers'},

    // ===== Consultation =====
    'choose_lawyer': {'ar': 'اختر محامياً', 'en': 'Choose a Lawyer'},
    'consultation_type': {'ar': 'نوع الاستشارة', 'en': 'Consultation Type'},
    'chat_consultation': {'ar': 'محادثة نصية', 'en': 'Text Chat'},
    'voice_consultation': {'ar': 'مكالمة صوتية', 'en': 'Voice Call'},
    'video_consultation': {'ar': 'مكالمة فيديو', 'en': 'Video Call'},
    'specialization': {'ar': 'التخصص', 'en': 'Specialization'},
    'rating': {'ar': 'التقييم', 'en': 'Rating'},
    'years_experience': {'ar': 'سنوات الخبرة', 'en': 'Years of Experience'},
    'price_per_session': {'ar': 'السعر للجلسة', 'en': 'Price per Session'},
    'book_now': {'ar': 'احجز الآن', 'en': 'Book Now'},
    'select_date': {'ar': 'اختر التاريخ', 'en': 'Select Date'},
    'select_time': {'ar': 'اختر الوقت', 'en': 'Select Time'},
    'describe_issue': {
      'ar': 'صف مشكلتك القانونية باختصار',
      'en': 'Briefly describe your legal issue'
    },
    'confirm_booking': {'ar': 'تأكيد الحجز', 'en': 'Confirm Booking'},
    'booking_success': {
      'ar': 'تم تأكيد حجزك بنجاح',
      'en': 'Your booking has been confirmed'
    },
    'sar': {'ar': 'ريال', 'en': 'SAR'},
    'family_law': {'ar': 'الأحوال الشخصية', 'en': 'Family Law'},
    'commercial_law': {'ar': 'القانون التجاري', 'en': 'Commercial Law'},
    'labor_law': {'ar': 'قانون العمل', 'en': 'Labor Law'},
    'real_estate_law': {'ar': 'القانون العقاري', 'en': 'Real Estate Law'},
    'criminal_law': {'ar': 'القانون الجنائي', 'en': 'Criminal Law'},
    'ip_law': {'ar': 'الملكية الفكرية', 'en': 'Intellectual Property'},

    // ===== Documents / AI Analysis =====
    'upload_document': {'ar': 'رفع مستند', 'en': 'Upload Document'},
    'upload_document_desc': {
      'ar': 'ارفع عقدك أو مستندك القانوني (PDF أو صورة) واحصل على تحليل فوري',
      'en': 'Upload your contract or legal file (PDF or image) for instant analysis'
    },
    'tap_to_upload': {'ar': 'اضغط لرفع الملف', 'en': 'Tap to upload file'},
    'supported_formats': {
      'ar': 'الصيغ المدعومة: PDF, JPG, PNG',
      'en': 'Supported formats: PDF, JPG, PNG'
    },
    'analyzing_document': {
      'ar': 'جاري تحليل المستند بالذكاء الاصطناعي...',
      'en': 'Analyzing document with AI...'
    },
    'analysis_summary': {'ar': 'الملخص', 'en': 'Summary'},
    'risk_points': {'ar': 'بنود الخطر', 'en': 'Risk Points'},
    'recommendations': {'ar': 'التوصيات', 'en': 'Recommendations'},
    'ask_ai_placeholder': {
      'ar': 'اسأل أي سؤال قانوني...',
      'en': 'Ask any legal question...'
    },
    'document_history': {'ar': 'سجل المستندات', 'en': 'Document History'},
    'discuss_with_lawyer': {
      'ar': 'مناقشة مع محامٍ',
      'en': 'Discuss with a Lawyer'
    },

    // ===== Laws & Regulations =====
    'laws_title': {'ar': 'الأنظمة واللوائح السعودية', 'en': 'Saudi Laws & Regulations'},
    'laws_subtitle': {
      'ar': 'اسأل أي سؤال نظامي واحصل على إجابة موثّقة',
      'en': 'Ask any regulatory question and get a referenced answer'
    },
    'search_laws_placeholder': {
      'ar': 'مثال: شروط إنهاء عقد العمل؟',
      'en': 'e.g. Conditions for ending an employment contract?'
    },
    'popular_questions': {'ar': 'أسئلة شائعة', 'en': 'Popular Questions'},
    'regulatory_reference': {'ar': 'المرجع النظامي', 'en': 'Regulatory Reference'},
    'browse_categories': {'ar': 'تصفح حسب التصنيف', 'en': 'Browse by Category'},

    // ===== Documentation/Notary =====
    'documentation_title': {'ar': 'خدمات التوثيق', 'en': 'Notarization Services'},
    'power_of_attorney': {'ar': 'إنشاء وفسخ الوكالات', 'en': 'Power of Attorney'},
    'company_formation': {'ar': 'تأسيس الشركات', 'en': 'Company Formation'},
    'mortgage_release': {'ar': 'الإفراج والرهن العقاري', 'en': 'Mortgage & Release'},
    'financial_disclosure': {'ar': 'الإقرارات المالية', 'en': 'Financial Disclosure'},
    'verified_notaries': {
      'ar': 'محامون موثقون معتمدون',
      'en': 'Certified Notary Lawyers'
    },
    'request_service': {'ar': 'طلب الخدمة', 'en': 'Request Service'},
    'verify_license': {'ar': 'تحقق من الرخصة', 'en': 'Verify License'},

    // ===== Profile =====
    'profile': {'ar': 'الملف الشخصي', 'en': 'Profile'},
    'my_account': {'ar': 'حسابي', 'en': 'My Account'},
    'my_bookings': {'ar': 'حجوزاتي', 'en': 'My Bookings'},
    'my_documents': {'ar': 'مستنداتي', 'en': 'My Documents'},
    'payment_methods': {'ar': 'وسائل الدفع', 'en': 'Payment Methods'},
    'notifications': {'ar': 'الإشعارات', 'en': 'Notifications'},
    'language': {'ar': 'اللغة', 'en': 'Language'},
    'settings': {'ar': 'الإعدادات', 'en': 'Settings'},
    'help_support': {'ar': 'المساعدة والدعم', 'en': 'Help & Support'},
    'about_us': {'ar': 'عن مواثيق', 'en': 'About Mawatheq'},
    'logout': {'ar': 'تسجيل الخروج', 'en': 'Logout'},
    'edit_profile': {'ar': 'تعديل الملف الشخصي', 'en': 'Edit Profile'},

    // ===== Navigation =====
    'nav_home': {'ar': 'الرئيسية', 'en': 'Home'},
    'nav_consultations': {'ar': 'الاستشارات', 'en': 'Consultations'},
    'nav_ai': {'ar': 'الذكاء القانوني', 'en': 'Legal AI'},
    'nav_laws': {'ar': 'الأنظمة', 'en': 'Laws'},
    'nav_profile': {'ar': 'حسابي', 'en': 'Profile'},
  };

  static String t(bool isArabic, String key) {
    final entry = _strings[key];
    if (entry == null) return key;
    return entry[isArabic ? 'ar' : 'en'] ?? key;
  }
}
