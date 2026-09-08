import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_profile.dart';
import '../services/ai_service.dart';

class WorkoutPlanScreen extends StatefulWidget {
  const WorkoutPlanScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutPlanScreen> createState() => _WorkoutPlanScreenState();
}

class _WorkoutPlanScreenState extends State<WorkoutPlanScreen> {
  final AIService _aiService = AIService();
  WorkoutPlan? _workoutPlan;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _generateWorkoutPlan();
  }

  Future<void> _generateWorkoutPlan() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final userProfile = Provider.of<UserProfileModel>(context, listen: false).userProfile;
      final plan = await _aiService.generateWorkoutPlan(userProfile);
      
      setState(() {
        _workoutPlan = plan;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to generate workout plan: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Generating your personalized workout plan...'),
          ],
        ),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(_errorMessage),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _generateWorkoutPlan,
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    return _workoutPlan != null
        ? _buildWorkoutPlanContent()
        : const Center(child: Text('No workout plan available'));
  }

  Widget _buildWorkoutPlanContent() {
    return RefreshIndicator(
      onRefresh: _generateWorkoutPlan,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _workoutPlan!.title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _workoutPlan!.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            ..._workoutPlan!.days.map((day) => _buildWorkoutDay(day)).toList(),
            
            const SizedBox(height: 24),
            
            Center(
              child: ElevatedButton.icon(
                onPressed: _generateWorkoutPlan,
                icon: const Icon(Icons.refresh),
                label: const Text('Regenerate Plan'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutDay(WorkoutDay day) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(
          day.day,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        initiallyExpanded: true,
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: day.exercises.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final exercise = day.exercises[index];
              return _buildExerciseItem(exercise);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseItem(Exercise exercise) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: exercise.imageUrl != null
                  ? Image.network(exercise.imageUrl!)
                  : Icon(
                      Icons.fitness_center,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(exercise.description),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Chip(
                      label: Text('${exercise.sets} sets'),
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text('${exercise.reps} reps'),
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 