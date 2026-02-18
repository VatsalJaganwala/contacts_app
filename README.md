# Contacts App

A feature-rich Flutter application for managing your contacts efficiently. Built with performance and usability in mind, utilizing modern Flutter development practices.

## 📱 Features

- **Contact Management**: Easily add, edit, and delete contacts.
- **Favorites**: Mark important contacts as favorites for quick access.
- **Direct Calling**: Call contacts directly from the app.
- **Dark Mode**: Fully supported dark and light themes for comfortable viewing in any environment.


## 🛠 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **Language**: [Dart](https://dart.dev/)
- **State Management**: [GetX](https://pub.dev/packages/get)
- **Database**: [sqflite](https://pub.dev/packages/sqflite) (Local storage)
- **Navigation**: GetX Navigation
- **Icons**: [Font Awesome Flutter](https://pub.dev/packages/font_awesome_flutter)

## 📦 Key Dependencies

- `get`: State management and route management.
- `sqflite`: SQLite plugin for Flutter.
- `flutter_phone_direct_caller`: Making direct phone calls.

## 🚀 Getting Started

Follow these steps to set up the project locally.

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed on your machine.
- An IDE (VS Code or Android Studio) with Flutter and Dart plugins.
- Android Emulator or iOS Simulator (or a physical device).

### Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/VatsalJaganwala/contacts_app.git
    cd contacts_app
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Run the app:**

    ```bash
    flutter run
    ```

## 📂 Project Structure

```
lib/
├── app/
│   ├── bindings/       # Dependency injection bindings
│   ├── constants/      # App constants (Colors, Strings)
│   ├── routes/         # App navigation routes
│   ├── theme/          # App theme configuration
│   └── utils/          # Utility classes
├── modules/
│   ├── add_edit_contact/ # Add/Edit Contact Screen & Controller
│   ├── contact_profile/  # Contact Details Screen
│   ├── contacts/         # Contacts List & Favorites Screens
│   └── home/             # Main Home Screen (Tab navigation)
└── main.dart           # Application entry point
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1.  Fork the project
2.  Create your feature branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request
