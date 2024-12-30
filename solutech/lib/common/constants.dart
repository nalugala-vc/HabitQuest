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
