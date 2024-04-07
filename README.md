# Rick and Morty iOS App

This iOS app was created to learn and practice fundamental UIKit features, IOS development, MVVM design pattern while using the [Rick and Morty API](https://rickandmortyapi.com).

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
UIKit, SnapKit, Combine, and Moya for enabling the development of this iOS app.
