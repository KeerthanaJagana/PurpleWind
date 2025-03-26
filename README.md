# 🌸 PurpleWind

**PurpleWind** is an iOS mobile app inspired by Instagram and Pinterest aesthetics, designed for customers to shop based on style, and for small businesses/vendors to showcase their handmade or curated products. The platform supports aesthetic-based discovery, role-based user experiences, and admin-managed approvals.

---

### ✨ Overview

- 💅 Shop by **aesthetic**: vintage, goth, floral, coquette, and more  
- 🛍️ **Customers** can browse, like, comment, and buy products  
- 🧵 **Vendors** can upload products and edit their profile  
- 🛡️ **Admins** can approve or reject vendor submissions  
- 🔐 Secure login with role-based dashboard navigation

---

### 🛠️ Tech Stack & Architecture

#### **Frontend**
- **SwiftUI** – Declarative UI for modern iOS development  
- **MVVM Architecture** – Separation of concerns for modular design  
- **Combine Framework** – Reactive state management  
- **Reusable Components** – Shared `HeaderView`, `BottomNavView`, `ProductFeedCard`, etc.  

#### **Backend & Database**
- **Firebase Authentication** – Email/Password & Google Sign-In  
- **Firestore** – NoSQL cloud database for user & product data  
- **Firebase Storage** – Upload and retrieve product images  

#### **Authentication & User Roles**
- **Customers** → Browse feeds, like/comment/buy products  
- **Vendors** → Manage profile, submit products  
- **Admins** → Review and approve vendor submissions  
- **Google Sign-In** → Auth via Firebase for easy access  

#### **Security & Access Control**
- **Role-Based Access Control (RBAC)** – Vendor, Customer, Admin  
- **Firestore Security Rules** – Granular control by role  
- **OAuth 2.0** – Used for Google authentication  
- **@DocumentID** – To enable secure and accurate document updates  

#### **Package Management**
- **Swift Package Manager (SPM)** – Used for all Firebase & Google SDKs  

#### **Version Control**
- **Git & GitHub** – Collaborative codebase management  

---

### 📌 Key Features Implemented

 **Custom Splash Screen** – Loads before login for brand intro  
 **Login & Sign-Up** – With role selection and Firebase integration  
 **Vendor Profile Setup** – Upload name, age, brand, and profile picture  
 **Add Product (Instagram-style)** – Upload multiple images and submit  
 **Admin Product Approval** – Review pending submissions with Approve/Reject buttons  
 **Toast Notification** – Shows temporary confirmation after admin actions  
 **Firestore Integration** – Real-time product status updates  
 **Customer Feed** – Scrollable feed of approved products with like/comment/buy buttons  
 **Bottom Tab Navigation** – Separate views for each role  
 **My Submissions** – Vendors can track status of all their products  
 **Reusable Components** – Navigation bar, feed cards, tab views  

---

### 📂 App Structure

