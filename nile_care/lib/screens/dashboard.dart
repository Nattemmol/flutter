import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lottie/lottie.dart';
import 'dart:math';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  int? selectedMoodIndex;

  final List<Map<String, dynamic>> moods = [
    {'icon': Icons.sentiment_very_satisfied, 'color': Colors.green},
    {'icon': Icons.sentiment_satisfied, 'color': Colors.lightGreen},
    {'icon': Icons.sentiment_neutral, 'color': Colors.orange},
    {'icon': Icons.sentiment_dissatisfied, 'color': Colors.red},
  ];

  // Flip card animation controller
  late AnimationController _controller;
  bool _showFrontSide = true;

  final String dailyTip =
      "Drink a glass of water right now! Staying hydrated boosts your energy and focus.";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_showFrontSide) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _showFrontSide = !_showFrontSide;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? Colors.grey[850] : Colors.white;
    final carouselBg = isDark ? Colors.grey[900] : Colors.white;
    final textColor = theme.textTheme.bodyLarge?.color;
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: 0.05,
                child: Lottie.asset(
                  'assets/animations/healthcare.json',
                  repeat: true,
                  width: double.infinity,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF003366), Color(0xFF336699)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.greeting}, Nathaniel 👋',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(context)!.dashboardWelcome,
                          style: GoogleFonts.lora(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Next Appointment
                  _nextAppointmentCard(context, cardColor, textColor),

                  const SizedBox(height: 24),
                  _sectionTitle(
                      context, AppLocalizations.of(context)!.highlights),

                  _carouselSection(carouselBg!),
                  const SizedBox(height: 24),

                  _sectionTitle(
                      context, AppLocalizations.of(context)!.recentHistory),
                  _historyList(context),

                  const SizedBox(height: 24),
                  _sectionTitle(
                      context, AppLocalizations.of(context)!.dailyCheckIn),
                  _moodSelector(cardColor, textColor),

                  const SizedBox(height: 24),
                  _sectionTitle(
                      context, AppLocalizations.of(context)!.dailyWellnessTip),
                  _dailyWellnessTipFlipCard(cardColor, textColor),

                  const SizedBox(height: 24),
                  _sectionTitle(
                      context, AppLocalizations.of(context)!.healthTips),
                  _healthTips(context, cardColor),

                  const SizedBox(height: 24),
                  _sectionTitle(
                      context, AppLocalizations.of(context)!.yourWellnessScore),
                  _wellnessScoreCard(cardColor, textColor),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    final color = Theme.of(context).textTheme.titleLarge?.color;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _nextAppointmentCard(
      BuildContext context, Color? cardColor, Color? textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FadeInUp(
        duration: const Duration(milliseconds: 600),
        child: Card(
          color: cardColor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.nextAppointment,
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: textColor)),
                const SizedBox(height: 8),
                Text(AppLocalizations.of(context)!.drJaneSmith,
                    style: GoogleFonts.poppins(color: textColor)),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.video_call,
                      color: Colors.white,
                    ),
                    label: Text(
                      AppLocalizations.of(context)!.join,
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF336699),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _carouselSection(Color carouselBg) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: carouselBg,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 180,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
        ),
        items: [1, 2, 3].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/kimzy-nanney-LNDgBERq8Q0-unsplash.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _historyList(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildHistoryCard(
              context,
              AppLocalizations.of(context)!.july20,
              AppLocalizations.of(context)!.drAhmed,
              AppLocalizations.of(context)!.completed,
              Colors.green),
          const SizedBox(width: 12),
          _buildHistoryCard(
              context,
              AppLocalizations.of(context)!.july15,
              AppLocalizations.of(context)!.drRachel,
              AppLocalizations.of(context)!.canceled,
              Colors.red),
          const SizedBox(width: 12),
          _buildHistoryCard(
              context,
              AppLocalizations.of(context)!.july10,
              AppLocalizations.of(context)!.drLin,
              AppLocalizations.of(context)!.noShow,
              Colors.orange),
        ],
      ),
    );
  }

  Widget _moodSelector(Color? cardColor, Color? textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.howFeelingToday,
                  style: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor)),
              const SizedBox(height: 12),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: selectedMoodIndex == null
                    ? Row(
                        key: const ValueKey('moods'),
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(moods.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedMoodIndex = index;
                              });
                            },
                            child: Icon(
                              moods[index]['icon'],
                              color: moods[index]['color'],
                              size: 30,
                            ),
                          );
                        }),
                      )
                    : Center(
                        key: const ValueKey('selectedMood'),
                        child: Icon(
                          moods[selectedMoodIndex!]['icon'],
                          color: moods[selectedMoodIndex!]['color'],
                          size: 50,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dailyWellnessTipFlipCard(Color? cardColor, Color? textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: _flipCard,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final isUnder = (_controller.value > 0.5);
            var rotationValue = _controller.value;
            if (isUnder) {
              rotationValue = 1 - rotationValue;
            }
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi * rotationValue),
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                height: 120,
                child: isUnder
                    ? _buildTipBack(textColor)
                    : _buildTipFront(textColor),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTipFront(Color? textColor) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.dailyTipTitle,
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildTipBack(Color? textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Text(
        dailyTip,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _healthTips(BuildContext context, Color? cardColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildTipCard(
            context,
            title: AppLocalizations.of(context)!.stayHydrated,
            description: AppLocalizations.of(context)!.stayHydratedDesc,
            imageAsset: 'assets/kimzy-nanney-LNDgBERq8Q0-unsplash.jpg',
            cardColor: cardColor,
          ),
          const SizedBox(height: 16),
          _buildTipCard(
            context,
            title: AppLocalizations.of(context)!.morningWalk,
            description: AppLocalizations.of(context)!.morningWalkDesc,
            imageAsset: 'assets/kimzy-nanney-LNDgBERq8Q0-unsplash.jpg',
            cardColor: cardColor,
          ),
        ],
      ),
    );
  }

  Widget _wellnessScoreCard(Color? cardColor, Color? textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.todaysScore,
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('82 / 100',
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                  Icon(Icons.emoji_emotions, color: Colors.amber, size: 32),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, String date, String doctor,
      String status, Color color) {
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, color: textColor)),
          const SizedBox(height: 4),
          Text(doctor,
              style: GoogleFonts.poppins(fontSize: 14, color: textColor)),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                status == 'Completed' ? Icons.check_circle : Icons.cancel,
                size: 18,
                color: color,
              ),
              const SizedBox(width: 6),
              Text(status, style: GoogleFonts.poppins(color: color)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard(BuildContext context,
      {required String title,
      required String description,
      required String imageAsset,
      required Color? cardColor}) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Card(
      color: cardColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(16)),
            child: Image.asset(
              imageAsset,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.robotoSlab(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor)),
                  const SizedBox(height: 6),
                  Text(description,
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.grey[600]))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
