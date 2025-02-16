
class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Discover Your Style",
    image: "assets/images/image1.png",
    desc: "Explore a wide range of trendy and classic glasses that match your unique personality. Find the perfect pair to elevate your look!",
  ),
  OnboardingContents(
    title: "Easy Shopping Experience",
    image: "assets/images/image2.png",
    desc:
       "Shop with confidence! Enjoy hassle-free browsing, secure payments, and fast delivery. Your perfect pair of glasses is just a few taps away.",
  ),
  OnboardingContents(
    title: "Get notified when work happens",
    image: "assets/images/image3.png",
    desc:
        "Take control of notifications, collaborate live or on your own time.",
  ),
];
