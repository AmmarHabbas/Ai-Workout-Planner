import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_profile.dart';

class WorkoutPlan {
  final String title;
  final String description;
  final List<WorkoutDay> days;

  WorkoutPlan({
    required this.title,
    required this.description,
    required this.days,
  });

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
    return WorkoutPlan(
      title: json['title'] ?? 'Custom Workout Plan',
      description: json['description'] ?? 'AI generated workout plan',
      days: (json['days'] as List?)
              ?.map((day) => WorkoutDay.fromJson(day))
              .toList() ??
          [],
    );
  }
}

class WorkoutDay {
  final String day;
  final List<Exercise> exercises;

  WorkoutDay({
    required this.day,
    required this.exercises,
  });

  factory WorkoutDay.fromJson(Map<String, dynamic> json) {
    return WorkoutDay(
      day: json['day'] ?? '',
      exercises: (json['exercises'] as List?)
              ?.map((exercise) => Exercise.fromJson(exercise))
              .toList() ??
          [],
    );
  }
}

class Exercise {
  final String name;
  final String description;
  final int sets;
  final int reps;
  final String? imageUrl;

  Exercise({
    required this.name,
    required this.description,
    required this.sets,
    required this.reps,
    this.imageUrl,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      sets: json['sets'] ?? 3,
      reps: json['reps'] ?? 10,
      imageUrl: json['imageUrl'],
    );
  }
}

class DietPlan {
  final String title;
  final String description;
  final List<MealPlan> meals;
  final List<String> nutritionTips;

  DietPlan({
    required this.title,
    required this.description,
    required this.meals,
    required this.nutritionTips,
  });

  factory DietPlan.fromJson(Map<String, dynamic> json) {
    return DietPlan(
      title: json['title'] ?? 'Custom Diet Plan',
      description: json['description'] ?? 'AI generated diet plan',
      meals: (json['meals'] as List?)
              ?.map((meal) => MealPlan.fromJson(meal))
              .toList() ??
          [],
      nutritionTips: (json['nutritionTips'] as List?)
              ?.map((tip) => tip.toString())
              .toList() ??
          [],
    );
  }
}

class MealPlan {
  final String type;
  final String name;
  final String description;
  final List<String> ingredients;
  final int calories;
  final String? imageUrl;

  MealPlan({
    required this.type,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.calories,
    this.imageUrl,
  });

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    return MealPlan(
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      ingredients: (json['ingredients'] as List?)
              ?.map((ingredient) => ingredient.toString())
              .toList() ??
          [],
      calories: json['calories'] ?? 0,
      imageUrl: json['imageUrl'],
    );
  }
}

class AIService {
  static const String _baseUrl = "YOUR_AI_API_URL";  // Replace with actual API URL
  static const String _apiKey = "YOUR_API_KEY";      // Replace with actual API key

  // In a real app, you would connect to an actual AI service API
  // For now, we'll simulate the AI response with hardcoded data

  Future<WorkoutPlan> generateWorkoutPlan(UserProfile profile) async {
    // In a real app, this would be an API call
    // http.Response response = await http.post(
    //   Uri.parse('$_baseUrl/generate-workout'),
    //   headers: {'Authorization': 'Bearer $_apiKey'},
    //   body: jsonEncode(profile.toJson()),
    // );
    // 
    // if (response.statusCode == 200) {
    //   return WorkoutPlan.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to generate workout plan');
    // }

    // Simulated response based on user profile
    await Future.delayed(const Duration(seconds: 2)); // Simulate API delay

    return _generateMockWorkoutPlan(profile);
  }

  Future<DietPlan> generateDietPlan(UserProfile profile) async {
    // In a real app, this would be an API call
    // http.Response response = await http.post(
    //   Uri.parse('$_baseUrl/generate-diet'),
    //   headers: {'Authorization': 'Bearer $_apiKey'},
    //   body: jsonEncode(profile.toJson()),
    // );
    // 
    // if (response.statusCode == 200) {
    //   return DietPlan.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to generate diet plan');
    // }

    // Simulated response based on user profile
    await Future.delayed(const Duration(seconds: 2)); // Simulate API delay

    return _generateMockDietPlan(profile);
  }

  WorkoutPlan _generateMockWorkoutPlan(UserProfile profile) {
    final String planTitle;
    final String planDescription;
    final List<WorkoutDay> days = [];

    // Customize plan based on user goal and body type
    if (profile.goal == Goal.loseWeight) {
      planTitle = "Weight Loss Workout Plan";
      planDescription = "A high-intensity workout plan designed to help you burn calories and lose weight.";
      
      days.add(WorkoutDay(
        day: "Day 1 - Cardio",
        exercises: [
          Exercise(
            name: "Jumping Jacks",
            description: "Full body exercise to get your heart rate up",
            sets: 3,
            reps: 30,
          ),
          Exercise(
            name: "Mountain Climbers",
            description: "Dynamic exercise targeting core and cardiovascular system",
            sets: 3,
            reps: 20,
          ),
          Exercise(
            name: "Burpees",
            description: "Full body exercise for strength and cardio",
            sets: 3,
            reps: 15,
          ),
          Exercise(
            name: "High Knees",
            description: "Running in place with high knees",
            sets: 3,
            reps: 30,
          ),
        ],
      ));
      
      days.add(WorkoutDay(
        day: "Day 2 - Lower Body",
        exercises: [
          Exercise(
            name: "Squats",
            description: "Basic lower body exercise targeting quads and glutes",
            sets: 4,
            reps: 15,
          ),
          Exercise(
            name: "Lunges",
            description: "Single leg exercise for balance and strength",
            sets: 3,
            reps: 12,
          ),
          Exercise(
            name: "Calf Raises",
            description: "Exercise targeting the calves",
            sets: 3,
            reps: 20,
          ),
          Exercise(
            name: "Glute Bridges",
            description: "Exercise focusing on glute activation",
            sets: 3,
            reps: 15,
          ),
        ],
      ));
      
      days.add(WorkoutDay(
        day: "Day 3 - Rest",
        exercises: [
          Exercise(
            name: "Light Walking",
            description: "30-minute walk at a comfortable pace",
            sets: 1,
            reps: 1,
          ),
          Exercise(
            name: "Stretching",
            description: "Full body stretching routine",
            sets: 1,
            reps: 1,
          ),
        ],
      ));
      
    } else if (profile.goal == Goal.gainMuscle) {
      planTitle = "Muscle Building Workout Plan";
      planDescription = "A progressive overload plan designed to help you build muscle and strength.";
      
      days.add(WorkoutDay(
        day: "Day 1 - Chest & Triceps",
        exercises: [
          Exercise(
            name: "Push-ups",
            description: "Basic chest and tricep exercise",
            sets: 4,
            reps: 12,
          ),
          Exercise(
            name: "Dumbbell Chest Press",
            description: "Chest exercise with dumbbells",
            sets: 3,
            reps: 10,
          ),
          Exercise(
            name: "Tricep Dips",
            description: "Body weight exercise for triceps",
            sets: 3,
            reps: 12,
          ),
          Exercise(
            name: "Tricep Extensions",
            description: "Isolation exercise for triceps",
            sets: 3,
            reps: 12,
          ),
        ],
      ));
      
      days.add(WorkoutDay(
        day: "Day 2 - Back & Biceps",
        exercises: [
          Exercise(
            name: "Pull-ups/Assisted Pull-ups",
            description: "Upper body pulling exercise",
            sets: 3,
            reps: 8,
          ),
          Exercise(
            name: "Dumbbell Rows",
            description: "Back exercise with dumbbells",
            sets: 3,
            reps: 12,
          ),
          Exercise(
            name: "Bicep Curls",
            description: "Basic bicep isolation exercise",
            sets: 3,
            reps: 12,
          ),
          Exercise(
            name: "Hammer Curls",
            description: "Bicep exercise targeting brachialis",
            sets: 3,
            reps: 12,
          ),
        ],
      ));
      
      days.add(WorkoutDay(
        day: "Day 3 - Legs & Shoulders",
        exercises: [
          Exercise(
            name: "Squats",
            description: "Compound lower body exercise",
            sets: 4,
            reps: 10,
          ),
          Exercise(
            name: "Deadlifts",
            description: "Full body pulling exercise",
            sets: 3,
            reps: 8,
          ),
          Exercise(
            name: "Shoulder Press",
            description: "Overhead pressing for shoulders",
            sets: 3,
            reps: 10,
          ),
          Exercise(
            name: "Lateral Raises",
            description: "Isolation for lateral deltoids",
            sets: 3,
            reps: 12,
          ),
        ],
      ));
      
    } else {
      planTitle = "General Fitness Workout Plan";
      planDescription = "A balanced workout plan to maintain fitness and health.";
      
      days.add(WorkoutDay(
        day: "Day 1 - Full Body",
        exercises: [
          Exercise(
            name: "Bodyweight Squats",
            description: "Lower body exercise",
            sets: 3,
            reps: 15,
          ),
          Exercise(
            name: "Push-ups",
            description: "Upper body pushing exercise",
            sets: 3,
            reps: 10,
          ),
          Exercise(
            name: "Plank",
            description: "Core stability exercise",
            sets: 3,
            reps: 30, // seconds
          ),
          Exercise(
            name: "Walking Lunges",
            description: "Lower body exercise",
            sets: 2,
            reps: 10,
          ),
        ],
      ));
      
      days.add(WorkoutDay(
        day: "Day 2 - Cardio",
        exercises: [
          Exercise(
            name: "Jogging/Brisk Walking",
            description: "20-30 minutes of steady-state cardio",
            sets: 1,
            reps: 1,
          ),
          Exercise(
            name: "Jumping Jacks",
            description: "Full body cardio exercise",
            sets: 3,
            reps: 20,
          ),
        ],
      ));
      
      days.add(WorkoutDay(
        day: "Day 3 - Flexibility & Recovery",
        exercises: [
          Exercise(
            name: "Yoga Flow",
            description: "15-20 minutes of basic yoga poses",
            sets: 1,
            reps: 1,
          ),
          Exercise(
            name: "Foam Rolling",
            description: "Self-myofascial release for recovery",
            sets: 1,
            reps: 1,
          ),
        ],
      ));
    }

    return WorkoutPlan(
      title: planTitle,
      description: planDescription,
      days: days,
    );
  }

  DietPlan _generateMockDietPlan(UserProfile profile) {
    final String planTitle;
    final String planDescription;
    final List<MealPlan> meals = [];
    final List<String> nutritionTips = [];

    // Base calorie needs (very simplified BMR calculation)
    double bmr;
    if (profile.gender == Gender.male) {
      bmr = 88.362 + (13.397 * profile.weight) + (4.799 * profile.height) - (5.677 * profile.age);
    } else {
      bmr = 447.593 + (9.247 * profile.weight) + (3.098 * profile.height) - (4.330 * profile.age);
    }

    // Adjust based on goal
    double dailyCalories;
    if (profile.goal == Goal.loseWeight) {
      dailyCalories = bmr * 0.85; // 15% deficit
      planTitle = "Weight Loss Diet Plan";
      planDescription = "A calorie-controlled diet plan to help you lose weight healthily.";
      
      nutritionTips.add("Focus on eating protein with every meal to stay full longer");
      nutritionTips.add("Drink water before meals to help control portion sizes");
      nutritionTips.add("Avoid sugary drinks and opt for water, tea, or black coffee");
      nutritionTips.add("Include vegetables with every meal to increase fiber intake");
      
    } else if (profile.goal == Goal.gainMuscle) {
      dailyCalories = bmr * 1.15; // 15% surplus
      planTitle = "Muscle Building Diet Plan";
      planDescription = "A high-protein diet plan to support muscle growth and recovery.";
      
      nutritionTips.add("Consume 1.6-2.2g of protein per kg of bodyweight");
      nutritionTips.add("Eat a meal with protein and carbs within 2 hours after workout");
      nutritionTips.add("Include healthy fats to support hormone production");
      nutritionTips.add("Stay hydrated throughout the day for optimal performance");
      
    } else {
      dailyCalories = bmr; // maintenance
      planTitle = "Balanced Diet Plan";
      planDescription = "A nutritionally balanced diet plan to maintain overall health.";
      
      nutritionTips.add("Aim for a colorful plate with a variety of fruits and vegetables");
      nutritionTips.add("Stay hydrated by drinking at least 8 glasses of water daily");
      nutritionTips.add("Limit processed foods and focus on whole food sources");
      nutritionTips.add("Practice mindful eating by eating slowly and without distractions");
    }

    // Create sample meals based on calculated calories
    double breakfastCal = dailyCalories * 0.25;
    double lunchCal = dailyCalories * 0.35;
    double dinnerCal = dailyCalories * 0.3;
    double snackCal = dailyCalories * 0.1;

    // Create meal plans based on goal
    if (profile.goal == Goal.loseWeight) {
      meals.add(MealPlan(
        type: "Breakfast",
        name: "Greek Yogurt with Berries",
        description: "High protein breakfast with antioxidant-rich berries",
        ingredients: ["1 cup Greek yogurt", "1/2 cup mixed berries", "1 tbsp honey", "1 tbsp chia seeds"],
        calories: breakfastCal.round(),
      ));
      
      meals.add(MealPlan(
        type: "Lunch",
        name: "Grilled Chicken Salad",
        description: "Lean protein with lots of vegetables for a filling lunch",
        ingredients: ["4 oz grilled chicken breast", "2 cups mixed greens", "1/4 cup cherry tomatoes", "1/4 cucumber", "2 tbsp light vinaigrette"],
        calories: lunchCal.round(),
      ));
      
      meals.add(MealPlan(
        type: "Dinner",
        name: "Baked Salmon with Vegetables",
        description: "Omega-3 rich salmon with roasted vegetables",
        ingredients: ["4 oz salmon fillet", "1 cup broccoli", "1 cup cauliflower", "1 tbsp olive oil", "Lemon and herbs to taste"],
        calories: dinnerCal.round(),
      ));
      
      meals.add(MealPlan(
        type: "Snack",
        name: "Apple with Almond Butter",
        description: "Balanced snack with fiber and healthy fats",
        ingredients: ["1 medium apple", "1 tbsp almond butter"],
        calories: snackCal.round(),
      ));
      
    } else if (profile.goal == Goal.gainMuscle) {
      meals.add(MealPlan(
        type: "Breakfast",
        name: "Protein Oatmeal",
        description: "Carb and protein rich breakfast to fuel muscles",
        ingredients: ["1 cup oats", "1 scoop protein powder", "1 banana", "1 tbsp peanut butter", "1 cup milk"],
        calories: breakfastCal.round(),
      ));
      
      meals.add(MealPlan(
        type: "Lunch",
        name: "Chicken and Rice Bowl",
        description: "Classic bodybuilding meal with lean protein and complex carbs",
        ingredients: ["6 oz grilled chicken breast", "1 cup brown rice", "1 cup mixed vegetables", "1 tbsp olive oil", "Spices to taste"],
        calories: lunchCal.round(),
      ));
      
      meals.add(MealPlan(
        type: "Dinner",
        name: "Steak with Sweet Potato",
        description: "Iron-rich red meat with nutrient-dense carbs",
        ingredients: ["5 oz lean steak", "1 medium sweet potato", "1 cup green beans", "1 tbsp butter"],
        calories: dinnerCal.round(),
      ));
      
      meals.add(MealPlan(
        type: "Snack",
        name: "Protein Shake with Nuts",
        description: "Quick protein and healthy fats",
        ingredients: ["1 scoop protein powder", "1 cup milk", "1/4 cup mixed nuts"],
        calories: snackCal.round(),
      ));
      
    } else {
      meals.add(MealPlan(
        type: "Breakfast",
        name: "Avocado Toast with Egg",
        description: "Balanced breakfast with whole grains, healthy fats, and protein",
        ingredients: ["2 slices whole grain bread", "1/2 avocado", "2 eggs", "Salt and pepper to taste"],
        calories: breakfastCal.round(),
      ));
      
      meals.add(MealPlan(
        type: "Lunch",
        name: "Quinoa Bowl",
        description: "Nutrient-dense lunch with complete protein",
        ingredients: ["1 cup cooked quinoa", "3 oz grilled chicken or tofu", "1/2 cup roasted vegetables", "1/4 avocado", "2 tbsp vinaigrette"],
        calories: lunchCal.round(),
      ));
      
      meals.add(MealPlan(
        type: "Dinner",
        name: "Mediterranean Plate",
        description: "Heart-healthy dinner inspired by the Mediterranean diet",
        ingredients: ["4 oz grilled fish", "1/2 cup hummus", "1 cup Greek salad", "1 whole wheat pita"],
        calories: dinnerCal.round(),
      ));
      
      meals.add(MealPlan(
        type: "Snack",
        name: "Fruit and Yogurt",
        description: "Balanced snack with protein and natural sugars",
        ingredients: ["1/2 cup Greek yogurt", "1 piece of fruit", "1 tbsp honey"],
        calories: snackCal.round(),
      ));
    }

    return DietPlan(
      title: planTitle,
      description: planDescription,
      meals: meals,
      nutritionTips: nutritionTips,
    );
  }
} 