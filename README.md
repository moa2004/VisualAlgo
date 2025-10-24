# ⚡ AlgorithMat – Visual Algorithm Learning Platform

[![Made with Flutter](https://img.shields.io/badge/Made%20with-Flutter-02569B?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Powered%20by-Firebase-FFCA28?logo=firebase)](https://firebase.google.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Web%20%7C%20Android%20%7C%20iOS-blue)](#)

---

## 🧠 Overview

**AlgorithMat** (formerly *VisualAlgo / Problem Solving Platform*) is a **fully-featured Flutter application** that revolutionizes how algorithms are learned, visualized, and mastered.  
It’s an interactive learning ecosystem combining visualization, quizzes, analytics, and performance tracking — all in one cross-platform app.

---

## 🚀 Features

### 🧩 Core Functionalities
- 🎥 **Algorithm Visualizer** — step-by-step animations for sorting, searching, graphs, and dynamic programming algorithms.  
- 📚 **Problem-Solving Modules** — curated ICPC-inspired challenges and structured practice sets.  
- 💬 **Multi-Language Code Tabs** — instantly switch between C++, Java, and Python implementations.  
- 🧮 **Complexity Analysis** — Big-O comparison for best, average, and worst cases.  
- 🧠 **Adaptive Quizzes** — topic-based questions with explanations and accuracy tracking.

---

## 📊 Smart Analytics

- 📈 **User Performance Dashboard**  
  Real-time progress graphs and accuracy statistics.

- 🧾 **Streak & Activity Tracking**  
  Daily engagement insights with progress streaks.

- 🧠 **AI-Driven Recommendations**  
  Personalized suggestions based on weak or strong topics.

- 🔍 **Algorithm Engagement Logs**  
  Tracks your most-viewed algorithms and latest activities.

---

## 💡 Tech Stack

| Layer | Technology |
|-------|-------------|
| **Frontend** | Flutter 3.x (Material 3, Riverpod, GoRouter, Flutter Animate) |
| **Backend** | Firebase (Auth, Firestore, Functions, Storage) |
| **Analytics** | Firestore + Custom `UserAnalyticsRepository` |
| **Design System** | Glassmorphism UI with Neon Teal Highlights |
| **Platforms** | Web, Android, iOS, Windows, macOS |

---

## 🧱 Project Architecture

```plaintext
lib/
├── core/
│   ├── constants/        # Global colors, typography, assets
│   ├── widgets/          # Shared UI components (GlassContainer, AppScaffold)
│   └── layout/           # Responsive design handlers
├── features/
│   ├── auth/             # Authentication (Sign In, Sign Up, Profile)
│   ├── analytics/        # User statistics & quiz analysis
│   ├── algorithms/       # Visualization studio & code walkthroughs
│   ├── quizzes/          # Adaptive quizzes + result summaries
│   └── home/             # Dashboard & streak display
└── firebase_options.dart # Firebase environment setup
```
🧰 Setup & Installation

1️⃣ Clone the repository

git clone https://github.com/<YOUR_USERNAME>/AlgorithMat.git
cd AlgorithMat

2️⃣ Install dependencies

flutter pub get

3️⃣ Configure Firebase

Use FlutterFire CLI to link your Firebase project:

flutterfire configure

Then add your google-services.json (Android) and GoogleService-Info.plist (iOS) files.

4️⃣ Run the project

For web:

flutter run -d chrome

For mobile:

flutter run

🧩 Key Packages

Package	Purpose

flutter_riverpod	Reactive state management

go_router	Declarative navigation and deep linking

firebase_auth	Authentication

cloud_firestore	Real-time database

firebase_storage	Image and file uploads

flutter_animate	Smooth UI transitions

intl	Date & time formatting

🎨 Design Highlights

✨ Glassmorphism Interface — soft blur, transparency, and neon teal gradients.

📱 Responsive Layout — fully adaptive for desktop, tablet, and mobile.

🎬 Animated Interactions — powered by flutter_animate for fluid UX.

🌙 Dark-Mode First — clean futuristic design language.

🧭 Screens Overview

Screen	Description
🧑‍💻 Sign In / Sign Up	Neon-themed authentication with animation & validation

🏠 Home Dashboard	Personalized summary & recent activity cards

🔢 Algorithm Studio	Interactive visualizations with multilingual code

🧠 Quiz Result	Performance report with weak/strong topic highlights

📊 Analytics Dashboard	Full breakdown of user progress & streak trends

🔐 Security & Data

    All data stored securely under users/{uid} in Firestore.

    Firebase Storage rules restrict unauthorized uploads.

    Authentication & access managed via Firebase Auth.

👨‍💻 Author

Moamen Mohammed
💼 Flutter & .NET Developer | Computer Science Student @ EELU
📍 Egypt
🔗 LinkedIn : www.linkedin.com/in/moamen-gebril-b3791226b
🛣️ Roadmap

    🏆 Leaderboards & XP system

    🤝 Collaborative visualization mode

    🌞 Light-mode theme toggle
--
    💬 “Don’t just learn algorithms — visualize, interact, and master them.”
    — AlgorithMat Team ⚡
