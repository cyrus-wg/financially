# Financially!
This app is built by Flutter, so please make sure you have installed and configured Flutter and Dart properly before launching it. Also, the intent is to develop a mobile app originally, mobile phone simulator (Xcode Simulator/Android Studio) should be used. This app was tested on iPhone 14 Pro Max, and you are recommanded to run the app on this machine.

## Running Steps
### Step 1: `cd` to this directory if you are not at.
```
cd {location you stored this folder}/financially 
```
### Step 2: install relevant packages
```
flutter pub get
```
### Step 3: open a simulator
For testing on ios, you can open the Xcode Simulator by the following command in terminal or mannually.
```
open -a Simulator.app
```
### Step 4: run the app
```
flutter run
```
This step may take a little bit of time for first running.

## App structure
### Financially
- Authentication Page
  - Sign in
  - Sign up
  - OTP verification
- Welcome Page
  - Welcome message
  - Hot stock cards
  - Redirection to Search Page
- Search Page
  - Search bar
  - Search results
  - Redirection to a specific Asset Page
- Hot Stock Page
  - Hot stock cards with real time price
- Asset Page
  - Real time price
  - 1-day and 52-week price ranges
  - Charts of price trends for different periods
  - Current related news cards
  - Redirection to News Page
  - Redirection to Historical Data Page
- News Page
  - Most previous 200 related news of an asset
- Historical Data Page
  - Daily price data of an asset from its listed date
- Home Page
  - Dashboard
    - Indices real time price
      - NASDAQ
      - DJIA
      - S&P 500
  - Portfoio
    - Watchlist with real time price
    - Log out function
