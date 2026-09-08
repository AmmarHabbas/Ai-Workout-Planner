import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_profile.dart';
import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  BodyType _bodyType = BodyType.average;
  Goal _goal = Goal.stayFit;
  Gender _gender = Gender.other;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final userProfileModel = Provider.of<UserProfileModel>(context, listen: false);
      
      userProfileModel.updateProfile(
        name: _nameController.text,
        age: int.tryParse(_ageController.text) ?? 0,
        weight: double.tryParse(_weightController.text) ?? 0.0,
        height: double.tryParse(_heightController.text) ?? 0.0,
        bodyType: _bodyType,
        goal: _goal,
        gender: _gender,
      );
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Let\'s get to know you better to create personalized plans',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                
                const SizedBox(height: 24),
                
                // Name field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Age field
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age <= 0 || age > 120) {
                      return 'Please enter a valid age';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Weight field
                TextFormField(
                  controller: _weightController,
                  decoration: const InputDecoration(
                    labelText: 'Weight (kg)',
                    prefixIcon: Icon(Icons.fitness_center),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your weight';
                    }
                    final weight = double.tryParse(value);
                    if (weight == null || weight <= 0) {
                      return 'Please enter a valid weight';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Height field
                TextFormField(
                  controller: _heightController,
                  decoration: const InputDecoration(
                    labelText: 'Height (cm)',
                    prefixIcon: Icon(Icons.height),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your height';
                    }
                    final height = double.tryParse(value);
                    if (height == null || height <= 0) {
                      return 'Please enter a valid height';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 24),
                
                // Body Type Selection
                Text(
                  'How would you describe your body type?',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                
                const SizedBox(height: 8),
                
                _buildBodyTypeSelector(),
                
                const SizedBox(height: 24),
                
                // Goal Selection
                Text(
                  'What is your fitness goal?',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                
                const SizedBox(height: 8),
                
                _buildGoalSelector(),
                
                const SizedBox(height: 24),
                
                // Gender Selection
                Text(
                  'Gender',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                
                const SizedBox(height: 8),
                
                _buildGenderSelector(),
                
                const SizedBox(height: 32),
                
                // Save Button
                ElevatedButton(
                  onPressed: _saveProfile,
                  child: const Text('Create Profile & Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBodyTypeSelector() {
    return Column(
      children: [
        RadioListTile<BodyType>(
          title: const Text('Slim'),
          value: BodyType.slim,
          groupValue: _bodyType,
          onChanged: (BodyType? value) {
            if (value != null) {
              setState(() {
                _bodyType = value;
              });
            }
          },
        ),
        RadioListTile<BodyType>(
          title: const Text('Average'),
          value: BodyType.average,
          groupValue: _bodyType,
          onChanged: (BodyType? value) {
            if (value != null) {
              setState(() {
                _bodyType = value;
              });
            }
          },
        ),
        RadioListTile<BodyType>(
          title: const Text('Overweight'),
          value: BodyType.overweight,
          groupValue: _bodyType,
          onChanged: (BodyType? value) {
            if (value != null) {
              setState(() {
                _bodyType = value;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildGoalSelector() {
    return Column(
      children: [
        RadioListTile<Goal>(
          title: const Text('Lose Weight'),
          value: Goal.loseWeight,
          groupValue: _goal,
          onChanged: (Goal? value) {
            if (value != null) {
              setState(() {
                _goal = value;
              });
            }
          },
        ),
        RadioListTile<Goal>(
          title: const Text('Gain Muscle'),
          value: Goal.gainMuscle,
          groupValue: _goal,
          onChanged: (Goal? value) {
            if (value != null) {
              setState(() {
                _goal = value;
              });
            }
          },
        ),
        RadioListTile<Goal>(
          title: const Text('Stay Fit'),
          value: Goal.stayFit,
          groupValue: _goal,
          onChanged: (Goal? value) {
            if (value != null) {
              setState(() {
                _goal = value;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildGenderSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: RadioListTile<Gender>(
            title: const Text('Male'),
            value: Gender.male,
            groupValue: _gender,
            onChanged: (Gender? value) {
              if (value != null) {
                setState(() {
                  _gender = value;
                });
              }
            },
          ),
        ),
        Expanded(
          child: RadioListTile<Gender>(
            title: const Text('Female'),
            value: Gender.female,
            groupValue: _gender,
            onChanged: (Gender? value) {
              if (value != null) {
                setState(() {
                  _gender = value;
                });
              }
            },
          ),
        ),
        Expanded(
          child: RadioListTile<Gender>(
            title: const Text('Other'),
            value: Gender.other,
            groupValue: _gender,
            onChanged: (Gender? value) {
              if (value != null) {
                setState(() {
                  _gender = value;
                });
              }
            },
          ),
        ),
      ],
    );
  }
} 