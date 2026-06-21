class LawyerModel {
  final String id;
  final String name;
  final String specializationAr;
  final String specializationEn;
  final double rating;
  final int reviewsCount;
  final int yearsExperience;
  final double pricePerSession;
  final String? imageUrl;
  final bool isVerified;
  final bool isOnline;

  LawyerModel({
    required this.id,
    required this.name,
    required this.specializationAr,
    required this.specializationEn,
    required this.rating,
    required this.reviewsCount,
    required this.yearsExperience,
    required this.pricePerSession,
    this.imageUrl,
    this.isVerified = true,
    this.isOnline = false,
  });

  String specialization(bool isArabic) =>
      isArabic ? specializationAr : specializationEn;

  static List<LawyerModel> demoList() => [
        LawyerModel(
          id: '1',
          name: 'د. بلال أحمد الزبطية',
          specializationAr: 'القانون التجاري',
          specializationEn: 'Commercial Law',
          rating: 4.9,
          reviewsCount: 214,
          yearsExperience: 15,
          pricePerSession: 250,
          isOnline: true,
        ),
        LawyerModel(
          id: '2',
          name: 'أ. سارة العتيبي',
          specializationAr: 'الأحوال الشخصية',
          specializationEn: 'Family Law',
          rating: 4.8,
          reviewsCount: 187,
          yearsExperience: 10,
          pricePerSession: 180,
          isOnline: true,
        ),
        LawyerModel(
          id: '3',
          name: 'أ. خالد المطيري',
          specializationAr: 'قانون العمل',
          specializationEn: 'Labor Law',
          rating: 4.7,
          reviewsCount: 142,
          yearsExperience: 8,
          pricePerSession: 150,
          isOnline: false,
        ),
        LawyerModel(
          id: '4',
          name: 'أ. منى القحطاني',
          specializationAr: 'الملكية الفكرية',
          specializationEn: 'Intellectual Property',
          rating: 4.9,
          reviewsCount: 98,
          yearsExperience: 12,
          pricePerSession: 220,
          isOnline: true,
        ),
        LawyerModel(
          id: '5',
          name: 'أ. عبدالله الشهري',
          specializationAr: 'القانون العقاري',
          specializationEn: 'Real Estate Law',
          rating: 4.6,
          reviewsCount: 76,
          yearsExperience: 9,
          pricePerSession: 200,
          isOnline: false,
        ),
      ];
}
