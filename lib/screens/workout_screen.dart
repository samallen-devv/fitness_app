import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../services/workout_service.dart';
import 'workout_detail_screen.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSearchBar(),
          const SizedBox(height: 24),
          _buildWorkoutCategories(),
          const SizedBox(height: 24),
          _buildWorkoutList(context),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search workouts...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _buildWorkoutCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategoryChip('All', true),
          _buildCategoryChip('Strength', false),
          _buildCategoryChip('Cardio', false),
          _buildCategoryChip('Yoga', false),
          _buildCategoryChip('HIIT', false),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool value) {},
        backgroundColor: Colors.grey[200],
        selectedColor: Colors.blue[100],
        checkmarkColor: Colors.blue,
        labelStyle: TextStyle(
          color: isSelected ? Colors.blue : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildWorkoutList(BuildContext context) {
    final workouts = WorkoutService.getWorkouts();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        final workout = workouts[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkoutDetailScreen(workout: workout),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fitness_center,
                          size: 50,
                          color: Colors.blue[700],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          workout.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workout.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            '${workout.duration} min',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.fitness_center,
                              size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            workout.difficulty,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
