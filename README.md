# WorkoutAI Planner

A Flutter app that uses AI to generate personalized workout and diet plans based on user profiles.

## Features

- User profile creation with details like body type, fitness goals, age, weight, height, and gender
- AI-generated workout plans tailored to individual needs
- Personalized diet plans with meal suggestions and nutritional tips
- Beautiful modern UI with light and dark mode support

## Screenshots

(Screenshots will be added once the app is running)

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Android Studio / VS Code with Flutter extension
- Android or iOS device/emulator

### Installation

1. Clone this repository
```
git clone https://github.com/yourusername/workout_ai_planner.git
```

2. Navigate to the project directory
```
cd workout_ai_planner
```

3. Install dependencies
```
flutter pub get
```

4. Run the app
```
flutter run
```

## Project Structure

```
lib/
  ├── models/         # Data models
  ├── screens/        # UI screens
  ├── services/       # AI and other services
  ├── utils/          # Utilities and helper functions
  ├── widgets/        # Reusable widgets
  └── main.dart       # App entry point
```

## How the AI works

The app currently simulates AI responses using predefined templates and basic logic based on the user's profile details. In a production version, you would integrate with actual AI services like:

- OpenAI API for natural language processing
- Azure AI for nutritional analysis
- TensorFlow models for exercise plan generation

## Customization

### Adding new workout types

To add new workout types, edit the `_generateMockWorkoutPlan` method in `lib/services/ai_service.dart`.

### Adding new diet plans

To add new diet options, edit the `_generateMockDietPlan` method in `lib/services/ai_service.dart`.

## Future Improvements

- Integration with real AI APIs
- Progress tracking and analytics
- Social sharing features
- Workout video demonstrations
- Shopping list generation for meal plans

## License

This project is licensed under the MIT License - see the LICENSE file for details. 