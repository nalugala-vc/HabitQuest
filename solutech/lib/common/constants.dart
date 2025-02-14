import 'package:heroicons/heroicons.dart';

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
Map<String, String> badgesAndNames = {
  "assets/images/badge2.png": "DAY ONE DONE",
  "assets/images/badge1.png": "TRIPLE THREAT",
  "assets/images/badge4.png": "HIGH FIVE",
  "assets/images/badge6.png": "WEEKLY WARRIOR",
  "assets/images/badge9.png": "PERFECT TEN",
  "assets/images/badge10.png": "FIFTEEN FORTITUDE",
  "assets/images/badge11.png": "TWENTY TROOPER",
  "assets/images/badge12.png": "MONTHLY MARVEL",
  "assets/images/badge13.png": "TRIPLE TRIUMPH",
  "assets/images/badge14.png": "TENACIOUS TEN",
  "assets/images/BADGE-BG1.png": "THIRTY THRIVER",
  "assets/images/BADGE-BG2.png": "HABIT HERO",
};

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
//CONSISTENCY
List<String> title1 = [
  "DAY ONE DONE", //Complete your first habit
  "TRIPLE THREAT", //Maintain 3 day streak
  "HIGH FIVE",

  ///Maintain 5 day streak
  "WEEKLY WARRIOR", //Maintain 7 day streak
];
//TASK COMPLETION
List<String> title2 = [
  "PERFECT TEN", //Maintain 103 day streak
  "FIFTEEN FORTITUDE", //Maintain 15 day streak
  "TWENTY TROOPER", //Maintain 20 day streak
  "MONTHLY MARVEL", //Maintain 30 day streak
];

List<String> title3 = [
  "TRIPLE TRIUMPH", //Complete a total of 3 habits
  "TENACIOUS TEN", // Complete 5010 total habits
  "THIRTY THRIVER", //Complete 30 total habits
  "HABIT HERO", //Complete 100 total habits
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
  'Log out',
  'Give us feedback',
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

final List<Map<String, dynamic>> notifications = [
  {
    "type": "Reminder",
    "title": "Workout Reminder",
    "description": "Time for your evening workout!",
    "time": "2h ago",
    "isRead": false,
  },
  {
    "type": "Tip",
    "title": "Hydration Tip",
    "description": "Drink a glass of water to stay hydrated.",
    "time": "4h ago",
    "isRead": true,
  },
  {
    "type": "Update",
    "title": "App Update",
    "description": "New features have been added to the app!",
    "time": "1d ago",
    "isRead": false,
  },
  {
    "type": "Reminder",
    "title": "Meditation Reminder",
    "description": "Take 10 minutes to meditate and relax.",
    "time": "3d ago",
    "isRead": true,
  },
  {
    "type": "Tip",
    "title": "Healthy Snack",
    "description": "Try eating some almonds for a healthy snack.",
    "time": "5d ago",
    "isRead": false,
  },
];
