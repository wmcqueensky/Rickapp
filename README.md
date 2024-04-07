# Rickapp

This iOS app was created to learn and practice fundamental UIKit features, IOS development, MVVM design pattern while using the [Rick and Morty API](https://rickandmortyapi.com).

## Photos
<img src="https://github.com/wmcqueensky/Rickapp/assets/79480681/171bad50-e5d0-4e77-ae4b-ce8868114779" width="200" alt="Simulator Screenshot - iPhone 14 - 2023-09-24 at 22 50 28">
<img src="https://github.com/wmcqueensky/Rickapp/assets/79480681/aa015326-aa43-4dbb-ac4a-8603ec7e8daa" width="200" alt="Simulator Screenshot - iPhone 14 - 2023-09-24 at 22 50 24">
<img src="https://github.com/wmcqueensky/Rickapp/assets/79480681/a718bc0f-c361-4921-bd3d-c5e3ca36c50d" width="200" alt="Simulator Screenshot - iPhone 14 - 2023-09-24 at 22 50 24">
<img src="https://github.com/wmcqueensky/Rickapp/assets/79480681/5ba23f9a-6f93-48de-acc0-a802426cf72d" width="200" alt="Simulator Screenshot - iPhone 14 - 2023-09-24 at 22 50 24">
<img src="https://github.com/wmcqueensky/Rickapp/assets/79480681/a0632cbd-cbdc-40d7-9b37-5a1b3438501b" width="200" alt="Simulator Screenshot - iPhone 14 - 2023-09-24 at 22 50 24">
<img src="https://github.com/wmcqueensky/Rickapp/assets/79480681/a374e700-ed12-427a-975c-85d085a409c8" width="200" alt="Simulator Screenshot - iPhone 14 - 2023-09-24 at 22 50 50">

## Features


## Features

- Display a list of Rick and Morty characters.
- Load more characters when scrolling to the end of the list.
- View character details by tapping on a character in the list.
- Mark characters as favorites.
- Search for characters

## Prerequisites

Before running the app, make sure you have the following:

- Xcode (recommended version: Xcode 12+)
- macOS (recommended version: macOS Catalina+)
- Internet connection to fetch data from the Rick and Morty API.

## Getting Started

Follow these steps to run the Rick and Morty iOS app:

1. Clone the GitHub repository for the project:

   ```bash
   git clone <repository_url>
2. Open the project in Xcode by double-clicking the .xcodeproj file.
3. Configure the Base URL:
Open the Info.plist file in your Xcode project and add a new key-value pair for "Base URL" with the value https://rickandmortyapi.com/api. This URL is used for API requests.
4. Build and run the app on the iOS Simulator or a physical iOS device. You can choose the target device from the dropdown menu in Xcode.

## How to Use

- Launch the app on the simulator or your iOS device.
- You'll see a list of Rick and Morty characters.
- Scroll down to load more characters.
- Tap on a character to view more details.
- Use the search bar to search for characters.
- Mark characters as favorites by tapping the heart icon.

## Code Structure

The app is structured into a MVVM design pattern.
   
## Dependencies

This project uses the following dependencies:

UIKit: For building the user interface.
SnapKit: For creating Auto Layout constraints programmatically.
Combine: For reactive programming and handling asynchronous tasks.
Moya: For simplifying network requests.
Kingfisher: For image loading and caching.
Make sure to install these dependencies using CocoaPods or Swift Package Manager if they are not already installed.

## Acknowledgments

The Rick and Morty API (https://rickandmortyapi.com) for providing the data used in this app.
