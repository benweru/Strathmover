# Strathmover Application

Strathmover is a user-friendly transport management application designed to simplify the booking and management of bus trips. Whether you're a student or staff at Strathmore University, this app makes it easy to manage your transportation needs.

## Features

- **Easy Booking**: Quickly book trips with just a few taps.
- **Transport History**: View your past bookings and manage your travel history.
- **User Profiles**: Manage your profile and keep track of your bookings.
- **Filter Options**: Filter your bookings by date or departure time to find specific trips.

## Project Setup/Installation Instructions

### Dependencies

- [Flutter](https://flutter.dev/docs/get-started/install) (version 2.0 or later)
- [Firebase](https://firebase.google.com/docs/flutter/setup) for authentication and database

### Installation Steps

1. **Clone the Repository**:
    
    git clone https://github.com/your-username/strathmover.git
    cd strathmover
    

2. **Install Flutter Dependencies**:
   
    flutter pub get
    

3. **Set Up Firebase**:
    - Follow the [Firebase setup guide](https://firebase.google.com/docs/flutter/setup) to add Firebase to your Flutter project.
    - Download the `google-services.json` file for Android and `GoogleService-Info.plist` for iOS and place them in their respective directories.

4. **Run the App**:
    
    flutter run
    

## Usage Instructions

### How to Run

1. **Login/Register**:
    - Open the Strathmover app.
    - Login with your email and password, or register for a new account if you don't have one.

2. **Book a Trip**:
    - Browse available trips on the main screen.
    - Select a trip, choose your preferred seat, and confirm your booking.

3. **View Transport History**:
    - Navigate to the profile screen.
    - Access your transport history to view past bookings.
    - Use filters to sort bookings by date or departure time.

4. **Manage Profile**:
    - Update your personal information in the profile section.
    - Keep track of your bookings and personal details.

### Examples

- **Booking a Trip**:
  - Select a trip from the list of available trips.
  - Choose a seat and confirm your booking.
  
- **Filtering Bookings**:
  - Go to the transport history screen.
  - Use the filter options to narrow down your bookings by date or departure time.

### Input/Output

- **Input**: User inputs for booking trips include trip selection, seat choice, and personal details.
- **Output**: Confirmation of bookings, updated transport history, and filtered lists of bookings.

## Project Structure

- **lib/**: Contains the main application code.
  - **features/**: Contains different features of the app such as authentication, booking, and transport history.
  - **models/**: Contains data models like `BookingModel` and `TripModel`.
  - **controllers/**: Contains controllers for managing state and business logic.

### Key Files

- **main.dart**: Entry point of the application.
- **booking_controller.dart**: Manages booking-related logic.
- **transport_history_controller.dart**: Manages transport history logic.
- **booking_model.dart**: Defines the data structure for bookings.

## Additional Sections

### Project Status

This project is currently in progress with active development.

### Known Issues

- Route on home screen not redirecting. Work in progress
- Project structure not well defined in readme.
- Bus Map implementation in Booking Screen. Investigations Ongoing.
- Cancel/ Completed not functional on home screen yet. Work in progress
- Time sensitivity on fetching bookings in home screen. Work in progress

### Screenshots

[Welcome Screen](https://github.com/benweru/Strathmover/assets/138494503/f5522c5a-093b-4c86-8b6e-5bab19634a29)

[Sign Up](https://github.com/benweru/Strathmover/assets/138494503/3bf9b414-371b-4d7e-a137-5a28db3ee087)

[Log In](https://github.com/benweru/Strathmover/assets/138494503/73f53a9f-23a1-4f9b-b3d1-375cbb3309e9)

[Home](https://github.com/benweru/Strathmover/assets/138494503/434974fc-27e6-43ae-adea-0f55603b5a64)

[Booking](https://github.com/benweru/Strathmover/assets/138494503/d21a7d09-9dc1-41bd-8781-af28793c54c6)

[Profile](https://github.com/benweru/Strathmover/assets/138494503/08f1642e-7e2c-4104-a049-f658eaaf2456)



### Acknowledgements

- [Flutter](https://flutter.dev) for the framework.
- [Firebase](https://firebase.google.com) for backend services.
- [GetX](https://pub.dev/packages/get) for state management.

## Contact Information

For support or any issues, please contact the Strathmover support team:
- [ben.maina@strathmore.edu](mailto:ben.maina@strathmore.edu)
- [christine.keni@strathmore.edu](mailto:christine.keni@strathmore.edu)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
