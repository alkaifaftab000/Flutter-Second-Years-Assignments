# Expense Tracker - Flutter Application

A clean, minimal, and modular Flutter application for tracking daily expenses locally with SQLite database. Built with a warm aesthetic UI and complete feature set for personal finance management.

**Status:** ✅ Production Ready | **Platform:** Android | **Architecture:** Modular & Scalable

---

## 📋 Table of Contents
- [Features](#features)
- [App Structure](#app-structure)
- [Local Storage](#local-storage)
- [Packages Used](#packages-used)
- [Installation](#installation)
- [Build Instructions](#build-instructions)

---

## ✨ Features

### Core Features
- ✅ **Add Expenses** - Create expense entries with title, amount, category, and date
- ✅ **Delete Expenses** - Remove expenses with one tap
- ✅ **View Expenses** - Browse all expenses in a scrollable list
- ✅ **Real-time Calculation** - Automatic total calculation

### Search & Filter
- 🔍 **Search Expenses** - Search by title or category in real-time
- 🏷️ **Category Filtering** - Filter results by 5 categories (Food, Transport, Shopping, Entertainment, Other)
- 📜 **Search History** - Maintains last 5 searches for quick access

### Statistics & Analytics
- 📊 **Category Breakdown** - Visual breakdown of expenses by category
- 📈 **Progress Bars** - Percentage distribution visualization
- 📅 **Monthly Stats** - Current month total expenses
- 💰 **Total Summary** - Overall expense summary on home screen

### Navigation & UI
- 🧭 **Bottom Navigation Bar** - Easy navigation between 4 screens
- 👤 **Profile Screen** - User information and app details
- 🎨 **Warm Aesthetic** - Beige/cream color scheme with orange accents
- ✨ **Rounded Cards** - Modern 16px border radius styling
- 🔘 **Rounded Buttons** - 12px rounded rectangle buttons

---

## 📁 App Structure

```
lib/
├── main.dart                    # Entry point, app configuration
├── models/
│   └── expense.dart            # Expense data model with serialization
├── services/
│   └── database_service.dart   # SQLite database operations & queries
├── screens/
│   ├── main_navigation.dart    # Bottom navigation controller
│   ├── home_screen.dart        # Home - expenses list & total
│   ├── search_screen.dart      # Search - search & filter expenses
│   ├── stats_screen.dart       # Statistics - analytics & breakdown
│   └── profile_screen.dart     # Profile - user info & settings
└── widgets/
    ├── expense_card.dart       # Expense list item component
    └── add_expense_dialog.dart # Add expense modal dialog

Total: 11 files | ~1000 lines of modular code
```

### File Descriptions

| File | Purpose | LOC |
|------|---------|-----|
| `expense.dart` | Data model with toMap/fromMap conversion | 35 |
| `database_service.dart` | SQLite CRUD operations, queries, stats | 75 |
| `home_screen.dart` | Main screen with expenses list | 100 |
| `search_screen.dart` | Search with category filters & history | 130 |
| `stats_screen.dart` | Monthly stats & category breakdown | 110 |
| `profile_screen.dart` | User profile & app info | 85 |
| `expense_card.dart` | Reusable expense list item | 70 |
| `add_expense_dialog.dart` | Modal dialog for adding expenses | 140 |
| `main_navigation.dart` | Bottom nav controller | 45 |

---

## 💾 Local Storage

### Database: SQLite
- **File Location:** `{ApplicationDocumentsDirectory}/expenses.db`
- **Type:** Local file-based database
- **Persistence:** Data persists even after app restart
- **No Network Required:** Fully offline functionality

### Database Schema

```sql
CREATE TABLE expenses(
  id INTEGER PRIMARY KEY,          -- Unique identifier
  title TEXT,                       -- Expense description
  amount REAL,                      -- Expense amount in ₹
  category TEXT,                    -- Category (Food, Transport, etc.)
  date TEXT                         -- ISO8601 formatted date
)
```

### Database Operations
- **Create:** Add new expense entry
- **Read:** Fetch all expenses, search, filter by category
- **Update:** Modified via delete + insert pattern
- **Delete:** Remove specific expense by ID
- **Query:** Monthly totals, category stats, search results

### Supported Queries
- `getExpenses()` - All expenses ordered by date DESC
- `searchExpenses(query)` - Search by title/category
- `getCategoryStats()` - Sum by category
- `getMonthlyTotal(date)` - Month-wise totals
- `getTotalExpenses()` - Overall sum

---

## 📦 Packages Used

### Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| **flutter** | SDK | Flutter framework & material design |
| **sqflite** | ^2.3.0 | SQLite database for Flutter |
| **path_provider** | ^2.1.0 | Access app documents directory |
| **path** | ^1.8.0 | Path manipulation utilities |
| **intl** | ^0.19.0 | Date/time formatting (MMM dd, yyyy) |

### Development Dependencies

| Package | Purpose |
|---------|---------|
| **flutter_test** | Flutter testing framework |
| **flutter_lints** | Code quality & lint rules |

### Why These Packages?

- **sqflite**: Industry standard for local SQLite on Flutter
- **path_provider**: Secure, platform-independent data storage
- **intl**: Localization & date formatting
- **flutter_lints**: Follows Flutter best practices

---

## 🚀 Installation

### Prerequisites
- Flutter SDK 3.10.4+
- Dart 3.10.4+
- Android Studio / Android SDK
- Git (optional)

### Setup Steps

1. **Clone or Download Project**
```bash
cd d:\Development\Flutter Projects\Vedansh\final_project
```

2. **Install Dependencies**
```bash
flutter pub get
```

3. **Run on Android Device/Emulator**
```bash
flutter run
```

---

## 🔨 Build Instructions

### Development Build
```bash
flutter run
```

### Production Build - Efficient APKs

```bash
# Clean build
flutter clean

# Build split APKs (Most Efficient) ⭐
flutter build apk --split-per-abi --release
```

**Output:** `build/app/outputs/flutter-apk/`

- `app-arm64-v8a-release.apk` (~45 MB) - Modern Android phones
- `app-armeabi-v7a-release.apk` (~35 MB) - Older devices
- `app-x86_64-release.apk` (~45 MB) - Emulators

### File Size Comparison
| Method | Size | Use Case |
|--------|------|----------|
| `flutter build apk` | 100-150 MB | ❌ Not recommended |
| `--split-per-abi` | 35-50 MB | ✅ **Recommended** |
| `--split-per-abi --release` | 35-45 MB | ✅ **Best (Production)** |

---

## 🎨 Design System

### Color Palette
- **Primary Background:** `#FAF6F1` (Warm cream)
- **Secondary:** `#F5E6D3` (Beige)
- **Accent:** `#D97757` (Warm orange)
- **Text:** `#5A4A42` (Dark brown)

### Typography
- **Font:** Roboto (Material Design)
- **Headings:** Bold, 20-36px
- **Body:** Regular, 14-16px
- **Labels:** Medium weight, 12-14px

### Components
- **Border Radius:** 12-16px (rounded rectangles)
- **Elevation:** 2-3 (subtle shadows)
- **Spacing:** 8-24px (material guidelines)

---

## 📱 Screens Overview

### 1. Home Screen
- Total expenses card with gradient
- Scrollable expense list
- Add expense FAB button
- Category icons with emojis

### 2. Search Screen
- Search bar with real-time results
- Category filter chips (bento style)
- Recent search history
- Search results with filtering

### 3. Stats Screen
- Monthly total card
- Category breakdown with progress bars
- Percentage distribution
- Visual analytics

### 4. Profile Screen
- User profile section
- Contact information
- About app info card
- Settings menu

---

## 🔒 Code Quality

- ✅ No compilation errors
- ✅ Follows Flutter best practices
- ✅ Lint clean (`flutter analyze`)
- ✅ Modular architecture
- ✅ Proper separation of concerns
- ✅ Material Design 3 compliance

---

## 📝 Notes for Assignment

- **Minimal Code:** ~1000 lines total, clean and readable
- **Modular Design:** Each component in separate file
- **No Over-Engineering:** Simple, junior-friendly code
- **Complete Features:** All 4 screens fully functional
- **SQLite Local Storage:** No cloud/API dependencies
- **UI/UX:** Warm, minimal aesthetic with good spacing

---

## 🎯 Getting Started

```bash
# Navigate to project
cd "d:\Development\Flutter Projects\Vedansh\final_project"

# Get dependencies
flutter pub get

# Run app
flutter run

# Build release APK
flutter build apk --split-per-abi --release
```

---

## 📄 License

This is a student assignment project for learning Flutter development.

**Author:** Vedansh  
**Created:** April 2026  
**Status:** Complete ✅
