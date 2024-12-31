import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:solutech/utils/app_colors.dart';

final List<Map<String, dynamic>> questions = [
  {
    "type": "time",
    "question": "What time do you usually wake up in the morning?",
    "key": "wake_up_time"
  },
  {
    "type": "time",
    "question": "What time do you usually go to bed?",
    "key": "bed_time"
  },
  {
    "type": "choice",
    "question": "What motivates you the most in habit tracking?",
    "choices": [
      "Points and rewards",
      "Visualization and charts",
      "Daily reminders"
    ],
    "key": "motivation"
  },
  {
    "type": "choice",
    "question": "What challenges do you face in the habit-building process?",
    "choices": [
      "Lack of motivation",
      "Maintaining consistency",
      "Time management"
    ],
    "key": "challenges"
  },
  {
    "type": "choice",
    "question": "What kind of reminders do you prefer when building habits?",
    "choices": ["Notifications", "Email", "Calendar events"],
    "key": "reminders"
  },
];
List<String> imgURL = [
  "assets/images/badge1.png",
  "assets/images/badge2.png",
  "assets/images/badge3.png",
  "assets/images/badge4.png",
  "assets/images/badge5.png",
  "assets/images/badge6.png",
  "assets/images/badge7.png",
  "assets/images/badge8.png",
  "assets/images/badge9.png",
  "assets/images/badge10.png",
  "assets/images/badge11.png",
  "assets/images/badge12.png",
  "assets/images/badge13.png",
  "assets/images/badge14.png",
  "assets/images/BADGE-BG1.png",
  "assets/images/BADGE-BG2.png",
  "assets/images/BADGE-BG3.png",
  "assets/images/BADGE-BG4.png",
];

List<String> imgURL2 = [
  "assets/images/badge12.png",
  "assets/images/badge13.png",
  "assets/images/badge14.png",
  "assets/images/badge11.png",
];

List<String> imgURL4 = [
  "assets/images/badge12.png",
  "assets/images/badge13.png",
  "assets/images/badge14.png",
  "assets/images/badge11.png",
];

List<String> title1 = [
  "SUPER SAVER",
  "BUDGET PRO",
  "AMBASSADOR",
  "PREMIUM",
];
List<String> title2 = [
  "INSURE GENIUS",
  "INVESTMENT WHIZ",
  "ESTATE PLANNER",
  "BASIC",
];

List<String> title3 = [
  "UZASHOPPER",
  "INVESTMENT WHIZ",
  "LIFELONG LEARNER",
  "PREMIUM",
];

List<String> imgURL3 = [
  "assets/images/BADGE-BG1.png",
  "assets/images/BADGE-BG2.png",
  "assets/images/BADGE-BG3.png",
  "assets/images/BADGE-BG4.png",
];

List<HeroIcons> accountIcons = [
  HeroIcons.user,
  HeroIcons.bell,
  HeroIcons.key,
];

List<String> accountTitles = [
  'Personal Info',
  'Notifications',
  'Privacy and Security',
];

List<HeroIcons> customizationIcons = [
  HeroIcons.computerDesktop,
  HeroIcons.arrowLeftCircle,
  HeroIcons.globeAlt,
];

List<String> custimizationTitles = [
  'Display & Appearance',
  'Accessibility',
  'Language',
];

List<HeroIcons> supportIcons = [
  HeroIcons.lockOpen,
  HeroIcons.cursorArrowRipple,
  HeroIcons.numberedList,
];

List<String> supportTitles = [
  'App Permisions',
  'Support & FAQ',
  'Give us feedback',
];

List<Color> profileColors = [
  AppColors.peach200,
  AppColors.pink400,
  AppColors.purple400,
];

final List<Map<String, String>> pages = [
  {
    "title": "Habit Quest",
    "description":
        "Embark on a quest to build better habits and transform your life with small daily steps. Unlock your potential and achieve your dreams.",
    "image": "assets/icons/logo.png",
    "isSvg": "false"
  },
  {
    "title": "Manage Your Daily Habits",
    "description":
        "Keep your streaks alive by completing daily tasks. Build momentum and achieve big goals with consistent habits.",
    "image": "assets/images/events.svg",
    "isSvg": "true"
  },
  {
    "title": "Challenge Yourself!",
    "description":
        "Take on 30-day challenges to set new goals and push your limits. Discover what you're truly capable of!",
    "image": "assets/images/winners.svg",
    "isSvg": "true"
  }
];
