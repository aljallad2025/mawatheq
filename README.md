# mawatheq مواثيق — تطبيق Flutter

منصة قانونية ذكية تجمع بين الاستشارات القانونية المباشرة (نص/صوت/فيديو) والتحليل القانوني بالذكاء الاصطناعي والبحث في الأنظمة واللوائح السعودية.

---

## 📁 محتوى المشروع

```
lib/
├── main.dart                     # نقطة الدخول
├── theme/                        # الألوان، الخطوط، الأبعاد
├── utils/                        # اللغة، النصوص ثنائية اللغة
├── models/                       # نماذج البيانات (محامي، إلخ)
└── screens/
    ├── splash_screen.dart
    ├── onboarding/
    ├── auth/                     # تسجيل دخول / تسجيل
    ├── home/                     # الرئيسية + التنقل السفلي
    ├── consultation/             # قائمة المحامين، الحجز
    ├── documents/                # الذكاء الاصطناعي القانوني
    ├── laws/                     # الأنظمة واللوائح
    ├── documentation/            # خدمات التوثيق
    └── profile/                  # الملف الشخصي
```

**الحالة الحالية**: كل الشاشات مبنية بواجهات كاملة (UI) باستخدام بيانات تجريبية (Mock Data). الخطوة التالية هي ربطها بـ Backend حقيقي (PHP + MySQL) عبر REST API.

---

## 🚀 الرفع إلى GitHub

```bash
cd mawatheq_app
git init
git add .
git commit -m "Initial Flutter UI - mawatheq app"
git branch -M main
git remote add origin https://github.com/<your-username>/mawatheq-app.git
git push -u origin main
```

---

## ⚙️ ربط Codemagic وبناء APK

1. سجّل دخول على [codemagic.io](https://codemagic.io) بحساب GitHub
2. اختر **Add application** → اختر الـ repo `mawatheq-app`
3. Codemagic سيكتشف ملف `codemagic.yaml` الموجود بجذر المشروع تلقائياً
4. من تبويب **Workflows** اختر:
   - `android-apk-debug` → لبناء APK سريع للمعاينة (بدون توقيع رسمي)
   - `android-apk-release` → لبناء APK + AAB موقعين رسمياً (يحتاج keystore)
5. اضغط **Start new build**
6. بعد انتهاء البناء، حمّل ملف الـ APK من تبويب **Artifacts**

### لإضافة توقيع رسمي (مطلوب فقط لـ android-apk-release):
- من إعدادات التطبيق على Codemagic → **Code signing identities** → **Android keystore**
- رفع ملف `.jks` أو إنشاء واحد جديد من نفس الواجهة
- تسمية الـ reference بـ `mawatheq_keystore` (مطابق لما هو مكتوب في `codemagic.yaml`)

---

## 🖥️ رفع لوحة التحكم والموقع على cPanel

هذا المجلد (`mawatheq_app`) خاص بتطبيق الموبايل فقط. لوحة التحكم والموقع (PHP + MySQL) ستكون في مشروع منفصل يُرفع عبر File Manager أو FTP إلى `public_html` على cPanel، مع ربط قاعدة بيانات MySQL من واجهة cPanel.

سنبني هذا الجزء في الخطوة التالية بعد اعتماد واجهات التطبيق.

---

## 📦 المكتبات الأساسية المستخدمة

| المكتبة | الاستخدام |
|---|---|
| `flutter_riverpod` | إدارة الحالة (اللغة، تسجيل الدخول، إلخ) |
| `dio` | الاتصال بـ REST API (لاحقاً) |
| `google_fonts` | خطوط IBM Plex Sans Arabic / Inter |
| `shared_preferences` | حفظ تفضيل اللغة محلياً |
| `file_picker` / `image_picker` | رفع المستندات للتحليل |
| `flutter_localizations` | دعم RTL/LTR |

---

## 🎨 الهوية البصرية

الألوان مستخرجة من تدرج شعار مواثيق:
- 🟡 ذهبي: `#F5A623`
- 🔵 تركواز: `#2BA8C4`
- 🔷 كحلي (أساسي): `#1E3A5F`
- ⬛ كحلي غامق: `#0F1F33`
