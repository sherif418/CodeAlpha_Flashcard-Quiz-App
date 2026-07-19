# 🎴 Flashcard Quiz App

A clean and interactive Flashcard Quiz app built with **Flutter**, designed to help users study and revise efficiently. Built as part of the **App Development Internship at [CodeAlpha](https://www.codealpha.tech)**.

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/status-completed-brightgreen?style=for-the-badge" />
</p>

---

## 📖 About the Project

Flashcard Quiz App is a study tool where each card shows a **question** on the front and reveals the **answer** on the back with a smooth flip animation. Users can browse through their deck, and fully manage it by adding, editing, or deleting cards.

## ✨ Features

- 🔄 **Flip animation** — tap "Show Answer" or the card itself to flip it and reveal the answer
- ⏭️ **Next / Previous navigation** to move through the deck
- ➕ **Add** new flashcards
- ✏️ **Edit** existing flashcards
- 🗑️ **Delete** flashcards with a confirmation dialog
- 🎨 Clean, minimal UI built with Material 3

## 🛠️ Built With

| Tech | Purpose |
|------|---------|
| **Flutter & Dart** | Cross-platform mobile app development |
| **StatefulWidget / setState** | State management |
| **AnimationController + Transform** | Custom 3D flip animation |
| **Form & Validators** | Add/Edit card input validation |

## 📂 Project Structure

```
lib/
 ├── main.dart                     # App entry point & home screen logic
 ├── models/
 │    └── flashcard.dart           # Flashcard data model
 ├── widgets/
 │    └── flip_card.dart           # Reusable flip-card animation widget
 └── screens/
      └── edit_card_screen.dart    # Add / Edit flashcard screen
```

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- An emulator, physical device, or Chrome for web preview

### Installation
```bash
git clone https://github.com/sherif418/CodeAlpha_Flashcard-Quiz-App.git
cd CodeAlpha_Flashcard-Quiz-App
flutter pub get
flutter run
```

## 📱 Screenshots

| Question Side | Answer Side | Add/Edit Card |
|:---:|:---:|:---:|
| _add screenshot_ | _add screenshot_ | _add screenshot_ |

> Replace the placeholders above with real screenshots from your app (drag & drop images into the GitHub README editor, or add them to a `/screenshots` folder and link them here).

## 🎥 Demo

_Add a link to your demo video here (LinkedIn post or YouTube)._

## 👤 Author

**Sherif** — App Development Intern at CodeAlpha
- GitHub: [@sherif418](https://github.com/sherif418)

## 📄 License

This project was built for educational purposes as part of the CodeAlpha internship program.
