# 💰 Personal Money Manager

A Flutter-based personal money manager application to help you efficiently track your income and expenses.

![Flutter](https://img.shields.io/badge/Flutter-v3.0-blue.svg)
![Firebase](https://img.shields.io/badge/Firebase-Auth-orange.svg)
![Hive](https://img.shields.io/badge/Hive-Database-yellow.svg)
![Local Notifications](https://img.shields.io/badge/Flutter-Local%20Notifications-green.svg)
![GetX](https://img.shields.io/badge/GetX-State%20Management-purple.svg)

## 📋 Features

- **🔐 Firebase Email Authentication**: Secure login with email authentication via Firebase.
  
- **💾 Hive Database**: All transaction data is stored locally using Hive, providing quick access and offline availability.
  
- **📊 Income & Expense Tracking**: Add, view, and manage your income and expenses.
  
- **📂 Categorization**: Organize transactions by categories for better tracking.
  
- **⏰ Scheduled Notifications**: Set and receive reminders for transactions using Flutter Local Notifications.
  
- **⚙️ Settings Management**: Access the settings from the home screen to update the notification schedule time and add test transactions.

## 🛠️ Architecture

This application follows the **Model-View-Controller (MVC) pattern** to ensure a clean separation of concerns and maintainable code structure. The state management is handled using **GetX**, providing efficient and reactive state handling, dependency injection, and navigation within the app.

## 🚀 Getting Started

### Prerequisites

- **Flutter**: Ensure you have Flutter installed on your machine. [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Firebase Project**: Set up a Firebase project and enable email authentication.
- **Hive Setup**: Hive database setup within the project.

### Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/MuneerAhamed01/Money-Manager.git
    cd money_manager
    ```

2. **Install dependencies**:
    ```bash
    flutter pub get
    ```

3. **Run the app**:
    ```bash
    flutter run
    ```

### Configuration

1. **Firebase Configuration**: Add your `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) to the respective directories.

2. **Hive Database**: Ensure Hive is properly initialized in your `main.dart` file:
    ```dart
    void main() async {
      await Hive.initFlutter();
      // Register adapters here
      runApp(MyApp());
    }
    ```

## 📚 Usage

1. **Authentication**: Sign up or log in using your email.
2. **Manage Transactions**: Add income or expenses, categorize them, and view all transactions on the home screen.
3. **Notifications**: Customize and schedule reminders through the settings accessed by tapping the leading icon on the home screen.

## 📦 Dependencies

- **Firebase Auth**: `firebase_auth`
- **Hive Database**: `hive`, `hive_flutter`
- **Flutter Local Notifications**: `flutter_local_notifications`
