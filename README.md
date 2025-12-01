# News App — README

A simple and modern News App built with the following features and technologies:

## Technologies Used

* **News API** (Fetching News Data)
* **Provider** (State Management)
* **Search Functionality** (Using API search queries)
* **Pagination** (Load more news pages)
* **Theming** (Dark & Light Mode)
* **Localization** (Arabic & English)

---

## Features

### 🔍 Search

Users can search for any topic. The app sends the search query to **NewsAPI** and displays the filtered results.

### 📄 Pagination

The app supports pagination to load articles page by page for better performance.

### 🎨 Theming

Two themes:

* **Light Mode**
* **Dark Mode**

Users can toggle between them, and the preference can be saved.

### 🌍 Localization

The app supports **two languages**:

* Arabic
* English

All UI text changes automatically based on the selected language.

###  Fetch News

The app uses **Fetch API** (or axios) to load the latest news based on category, query, or pagination state.

###  Provider

Used for managing app-wide states such as:

* Theme
* Language
* Pagination
* Search query
* News list

---

## Setup Instructions

1. Install project dependencies:

   ```bash
   npm install
   ```

2. Add your **News API key** in your environment file:

   ```env
   NEWS_API_KEY=your_api_key_here
   ```

3. Run the project:

   ```bash
   npm start
   ```

---

## API Usage Example

Basic request structure used in the app:

https://newsapi.org/v2/everything?q=SEARCH_QUERY&page=PAGE_NUMBER&apiKey=YOUR_API_KEY


## Summary

This News App demonstrates how to integrate NewsAPI, implement search, pagination, theming, localization, and state management using Provider in a clean, simple, and scalable way.

If you want, I can also generate the folder structure or example code files for Provider, themes, localization, or the API service.
