// lib/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _onboardingPages = [
    OnboardingPage(
      title: 'Discover Traditional Elegance',
      description: 'Explore our exclusive collection of cultural attire for weddings, introductions, and special ceremonies.',
      imagePath: 'assets/images/elligance.png',
    ),
    OnboardingPage(
      title: 'Perfect Fit Guaranteed',
      description: 'Get custom-tailored traditional wear with precise measurements for the perfect cultural celebration look.',
      imagePath: 'assets/images/booking.png',
    ),
    OnboardingPage(
      title: 'Easy Booking & Delivery',
      description: 'Seamlessly book your favorite traditional wear and get it delivered ready for your special occasion.',
      imagePath: 'assets/images/elligance.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      body: SafeArea(
        child: Column(
          children: [
            _buildSkipButton(),
            _buildPageView(),
            _buildNavigationSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(top: 16, right: 16),
        child: TextButton(
          onPressed: _goToLogin,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: const Color(0xFF800020).withOpacity(0.1),
          ),
          child: const Text(
            'Skip',
            style: TextStyle(
              color: Color(0xFF800020),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return Expanded(
      flex: 5,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _onboardingPages.length,
        onPageChanged: (int page) {
          setState(() => _currentPage = page);
        },
        itemBuilder: (context, index) {
          return _buildOnboardingPage(_onboardingPages[index]);
        },
      ),
    );
  }

  Widget _buildNavigationSection() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            _buildPageIndicators(),
            const Spacer(),
            _buildNavigationButtons(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingPage page) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildImageContainer(page.imagePath),
          const SizedBox(height: 48),
          _buildTitle(page.title),
          const SizedBox(height: 20),
          _buildDescription(page.description),
        ],
      ),
    );
  }

  Widget _buildImageContainer(String imagePath) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildErrorPlaceholder(),
        ),
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF800020).withOpacity(0.1),
            const Color(0xFFB8860B).withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(
        Icons.celebration,
        color: Color(0xFF800020),
        size: 60,
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF333333),
        fontSize: 26,
        fontWeight: FontWeight.bold,
        height: 1.3,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription(String description) {
    return Text(
      description,
      style: TextStyle(
        color: const Color(0xFF333333).withOpacity(0.7),
        fontSize: 16,
        height: 1.6,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_onboardingPages.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _currentPage == index
                ? const Color(0xFF800020)
                : const Color(0xFF800020).withOpacity(0.3),
          ),
        );
      }),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _currentPage > 0 ? _buildPreviousButton() : const SizedBox(width: 80),
        _buildNextButton(),
      ],
    );
  }

  Widget _buildPreviousButton() {
    return TextButton(
      onPressed: () {
        _pageController.previousPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: const Row(
        children: [
          Icon(Icons.arrow_back_ios, size: 16, color: Color(0xFF800020)),
          SizedBox(width: 4),
          Text(
            'Previous',
            style: TextStyle(
              color: Color(0xFF800020),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: () {
        if (_currentPage == _onboardingPages.length - 1) {
          _goToLogin();
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF800020),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _currentPage == _onboardingPages.length - 1 ? 'Get Started' : 'Next',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          if (_currentPage < _onboardingPages.length - 1) ...[
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ],
      ),
    );
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}