# 📰 Flutter News Aggregator App

A personalized news aggregator app built using Flutter. It fetches news from the [GNews API](https://gnews.io/) and displays it by category in a beautiful, mobile-friendly UI. Built with clean architecture and best practices.

## 🚀 Features

- 📄 Latest news headlines
- 🔍 News categorized by topics (e.g., Business, Sports, Tech, etc.)
- 🌐 Opens full article in browser
- 📤 Share news articles
- 🖼️ Displays article image, title, and description
- 🔁 Pull to refresh

----

## 📸 Screenshots

| Home Screen | Detail Screen |
|-------------|---------------|
| ![Home](lib/screenshots/homescreen.png) | ![Detail](lib/screenshots/articles.png) |

## 📦 Folder Structure

lib/
├── main.dart
├── models/
│ └── article.dart
├── screens/
│ ├── home_screen.dart
│ └── detail_screen.dart
├── services/
│ └── news_api_service.dart
├── widgets/
│ └── news_card.dart


## 🔧 Getting Started

1. **Clone the repo**

```bash
git clone https://github.com/Suba-2010/news_aggregator.git
cd news_aggregator
