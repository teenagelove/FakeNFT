# FakeNFT — Technical Specification

## 🔗 Links  
[Design in Figma](https://www.figma.com/design/Uz5G39wRRCr2mRE4SbnNla/FakeNFT--YP-)

---

### 🚀 Tech Stack & Principles  

![iOS](https://img.shields.io/badge/iOS-17%2B-000000?logo=apple&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-0A84FF?logo=swift&logoColor=white)
![Swift%20Concurrency](https://img.shields.io/badge/async%2Fawait-FF9F0A?logo=swift&logoColor=white)
![MVVM](https://img.shields.io/badge/MVVM-5856D6?logo=swift&logoColor=white)

---

## 📖 Introduction  

This document defines the technical requirements, architecture, and features for the mobile app **FakeNFT**.  
FakeNFT allows users to browse and simulate purchases of NFTs (Non-Fungible Tokens) via a mock server.

<p align="center">
  <img src="Assets/CatalogPreview.gif" alt="Catalog Preview" width="220"/>
  <img src="Assets/StatisticsPreview.gif" alt="Statistics Preview" width="220"/>
  <img src="Assets/BasketPreview.gif" alt="Basket Preview" width="220"/>
</p>

---

## 🎯 Goals & Objectives  

The primary goal is to build an **iOS app** for exploring and “purchasing” NFTs (simulated).  

**Key objectives:**  
- Display and browse NFT collections 🖼️  
- View and simulate purchasing NFTs 💰  
- View user rankings and profiles 🏆  

---

## 📱 Application Features & Screens  

### 🗂 Catalog Screen  
- Shows a list of NFT collections  
- Each collection displays: cover image, name, NFT count  
- Sorting button to reorder the list  
- Loading indicator while fetching data  
- Tapping a collection opens its details  

### 💎 Collection (NFT) Screen  
- Shows: cover image, title, description, author (link opens in web view)  
- A grid (`LazyVGrid`) of NFT items  
- Each NFT cell has: image, title, rating, price (in ETH), favorite button, add-to-basket button  
- Tapping an NFT cell opens its detail screen  

### 🛒 Basket / Order Screen  
- List (`List`) of NFTs in the basket, with: image, title, rating, price, delete button  
- Confirm deletion dialog: shows NFT image, confirmation text, “Delete” / “Cancel”  
- Sorting option at top  
- Bottom panel: total count, sum, “Pay” button  
- Loading indicator while performing network actions  
- Tapping “Pay” moves to currency selection  

### 💰 Currency Selection Screen  
- Grid (`LazyVGrid`) of currencies: logo, full & short name  
- Link to terms & conditions (opens via web view)  
- “Pay” button triggers request: success → confirmation; error → retry alert  

### 👤 Profile Screen  
- Shows: user photo, name, description, website (opens in web view)  
- Table (`UITableView`) with options: “My NFTs”, “Favorite NFTs”  
- Edit profile button (name, description, photo, website)  

### 🧾 My NFTs Screen  
- List (`List`) of user’s NFTs: icon, title, author, price (ETH)  
- Sorting option; empty state message if none  

### ❤️ Favorite NFTs Screen  
- Grid (`LazyVGrid`) of favorite NFTs: icon, unfavorite button, title, rating, price  
- Empty state message if none  

### 📊 Rankings / Statistics Screen  
- List (`List`) of users: rank, avatar, name, number of NFTs  
- Sorting option; tapping a user opens profile  

### 👥 User’s Collection Screen  
- Grid (`LazyVGrid`) of a user’s NFTs: icon, favorite button, title, rating, price, basket button  

---

## ⚖️ Sorting & Preferences  

Sorting is available on: **Catalog**, **Basket**, **My NFTs**, **Rankings**.  
User preferences are stored locally (via `@AppStorage` or `UserDefaults`) and restored at app launch.

**Default sorting rules:**  
- Catalog → by NFT count  
- Basket → by name  
- My NFTs → by rating  
- Rankings → by rating  

---

## ⚙️ Non-Functional Requirements  

### 1️⃣ Project Settings  
- **Minimum iOS version:** 17.0+  
- The project must compile without errors and run on simulator  

- **UI framework:** SwiftUI  
- **Architecture pattern:** MVVM  

### 2️⃣ Architecture & Code Structure  

#### 🧩 General  
- Clear naming of classes and components  
- Proper use of SwiftUI property wrappers:

| Modifier             | Purpose                                  |
|----------------------|------------------------------------------|
| `@State`             | Local view state                         |
| `@Binding`           | Data binding between views               |
| `@StateObject`       | Instantiate & own a ViewModel            |
| `@ObservedObject`    | Observe an existing ViewModel            |
| `@EnvironmentObject` | Shared data across many views            |

#### 🌐 Networking  
- Use `actor`-based services  
- Data models conform to `Sendable`  
- Requests use `async/await`  

### 3️⃣ Concurrency & Threading  
- **Do not use** GCD or callback-based APIs  
- **UI updates only** from `@MainActor`  
- Use Swift Concurrency: `async/await`, `async let`, `withTaskGroup`, etc.  

---

✅ *End of specification.*
