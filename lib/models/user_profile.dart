import 'package:flutter/foundation.dart';

enum BodyType { slim, average, overweight }
enum Goal { loseWeight, gainMuscle, stayFit }
enum Gender { male, female }

class UserProfile {
  String name;
  int age;
  double weight; // in kg
  double height; // in cm
  BodyType bodyType;
  Goal goal;
  Gender gender;
  
  UserProfile({
    this.name = '',
    this.age = 0,
    this.weight = 0.0,
    this.height = 0.0,
    this.bodyType = BodyType.average,
    this.goal = Goal.stayFit,
    this.gender = Gender.other,
  });

  double get bmi => weight / ((height / 100) * (height / 100));

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'weight': weight,
      'height': height,
      'bodyType': bodyType.toString().split('.').last,
      'goal': goal.toString().split('.').last,
      'gender': gender.toString().split('.').last,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      weight: json['weight']?.toDouble() ?? 0.0,
      height: json['height']?.toDouble() ?? 0.0,
      bodyType: BodyType.values.firstWhere(
        (e) => e.toString().split('.').last == json['bodyType'],
        orElse: () => BodyType.average,
      ),
      goal: Goal.values.firstWhere(
        (e) => e.toString().split('.').last == json['goal'],
        orElse: () => Goal.stayFit,
      ),
      gender: Gender.values.firstWhere(
        (e) => e.toString().split('.').last == json['gender'],
        orElse: () => Gender.other,
      ),
    );
  }
}

class UserProfileModel extends ChangeNotifier {
  UserProfile _userProfile = UserProfile();

  UserProfile get userProfile => _userProfile;

  void updateProfile({
    String? name,
    int? age,
    double? weight,
    double? height,
    BodyType? bodyType,
    Goal? goal,
    Gender? gender,
  }) {
    if (name != null) _userProfile.name = name;
    if (age != null) _userProfile.age = age;
    if (weight != null) _userProfile.weight = weight;
    if (height != null) _userProfile.height = height;
    if (bodyType != null) _userProfile.bodyType = bodyType;
    if (goal != null) _userProfile.goal = goal;
    if (gender != null) _userProfile.gender = gender;
    
    notifyListeners();
  }

  void setProfile(UserProfile profile) {
    _userProfile = profile;
    notifyListeners();
  }

  bool get isProfileComplete {
    return _userProfile.name.isNotEmpty && 
           _userProfile.age > 0 && 
           _userProfile.weight > 0 && 
           _userProfile.height > 0;
  }
} 