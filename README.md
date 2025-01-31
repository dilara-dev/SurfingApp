# Surfing App

Surfing App is a Swift application that lists suitable weather conditions based on the country and city selected by the user. The app calculates the best weather conditions (wind, temperature, time range, etc.) for surfing, helping users find the optimal conditions.

## Getting Started

This guide will walk you through setting up and running the project on your computer.

## Installation

1. Clone this repository to your computer:
   ```bash
   git clone https://github.com/dilara-dev/SurfingApp.git
   ```
2. Open the Xcode project:
   ```bash
   open SurfingApp.xcodeproj
   ```
3. Run the project in Xcode.

## App Features

- **Country Selection**: The user is prompted to enter a country name. As they type, the app filters and lists available countries for easy selection.
- **City Selection**: After selecting a country, the corresponding cities are displayed, and the user must choose one.
- **Weather API**: Weather data for the selected city is retrieved using the Weatherbit API.
- **Surf Conditions**: Data such as wind speed, temperature, and time range is analyzed and ranked from the best surf conditions to less ideal ones.
- **CSV Data**: Since the Weatherbit API does not provide city data by country, necessary information has been included in the project from CSV files.

## Usage

1. When the app starts, enter a country name in the **Country Selection** field.
2. A list of available countries will be displayed. Select the appropriate one.
3. After selecting a country, a list of cities within that country will appear. Choose a city.
4. Once a city is selected, the **"Search"** button will be enabled.
5. Press **"Search"**, and the app will request weather data from the Weatherbit API and calculate the best surf conditions.
6. The conditions will be displayed in order from the most suitable surf conditions to the least suitable ones.

## API and Data Structure

The app retrieves weather data from **Weatherbit API**, which includes information such as wind speed, temperature, and time range.

### Weatherbit API

Example API request to fetch weather data:

```bash
https://api.weatherbit.io/v2.0/forecast/hourly?key=<API_KEY>&city=<CITY_NAME>
```

The data retrieved from the API is processed in the background to provide the best surf conditions to the user.

