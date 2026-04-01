import '../models/workout.dart';

class WorkoutService {
  // This would typically come from a database or API
  static List<Workout> getWorkouts() {
    return [
      Workout(
        id: '1',
        name: 'Full Body Workout',
        description:
            'A comprehensive workout targeting all major muscle groups. Perfect for building overall strength and endurance.',
        duration: 30,
        exerciseCount: 8,
        difficulty: 'Intermediate',
        imageUrl: 'assets/images/full_body.jpg',
        exercises: [
          Exercise(
            id: '1',
            name: 'Push-ups',
            description:
                'A classic exercise that targets the chest, shoulders, and triceps.',
            sets: 3,
            reps: 12,
            duration: 45,
            imageUrl: 'assets/images/pushup.jpg',
          ),
          Exercise(
            id: '2',
            name: 'Squats',
            description:
                'A fundamental lower body exercise that works the quadriceps, hamstrings, and glutes.',
            sets: 3,
            reps: 15,
            duration: 60,
            imageUrl: 'assets/images/squat.jpg',
          ),
          Exercise(
            id: '3',
            name: 'Plank',
            description:
                'An isometric core exercise that improves stability and posture.',
            sets: 3,
            reps: 1,
            duration: 30,
            imageUrl: 'assets/images/plank.jpg',
          ),
        ],
      ),
      Workout(
        id: '2',
        name: 'Upper Body Strength',
        description:
            'Focus on building upper body strength with this targeted workout routine.',
        duration: 45,
        exerciseCount: 6,
        difficulty: 'Advanced',
        imageUrl: 'assets/images/upper_body.jpg',
        exercises: [
          Exercise(
            id: '4',
            name: 'Pull-ups',
            description:
                'An excellent exercise for back and biceps development.',
            sets: 4,
            reps: 8,
            duration: 60,
            imageUrl: 'assets/images/pullup.jpg',
          ),
          Exercise(
            id: '5',
            name: 'Dumbbell Press',
            description:
                'Build chest and shoulder strength with this compound movement.',
            sets: 4,
            reps: 10,
            duration: 45,
            imageUrl: 'assets/images/dumbbell_press.jpg',
          ),
          Exercise(
            id: '6',
            name: 'Tricep Dips',
            description:
                'Isolate and strengthen the triceps with this bodyweight exercise.',
            sets: 3,
            reps: 12,
            duration: 45,
            imageUrl: 'assets/images/dips.jpg',
          ),
        ],
      ),
      Workout(
        id: '3',
        name: 'Core Crusher',
        description:
            'Strengthen your core and improve stability with these targeted exercises.',
        duration: 20,
        exerciseCount: 5,
        difficulty: 'Beginner',
        imageUrl: 'assets/images/core.jpg',
        exercises: [
          Exercise(
            id: '7',
            name: 'Crunches',
            description:
                'A classic abdominal exercise that targets the rectus abdominis.',
            sets: 3,
            reps: 20,
            duration: 30,
            imageUrl: 'assets/images/crunch.jpg',
          ),
          Exercise(
            id: '8',
            name: 'Russian Twists',
            description: 'Work your obliques and improve rotational strength.',
            sets: 3,
            reps: 15,
            duration: 45,
            imageUrl: 'assets/images/russian_twist.jpg',
          ),
          Exercise(
            id: '9',
            name: 'Leg Raises',
            description:
                'Target lower abs and hip flexors with this challenging exercise.',
            sets: 3,
            reps: 12,
            duration: 45,
            imageUrl: 'assets/images/leg_raise.jpg',
          ),
        ],
      ),
    ];
  }

  static Workout? getWorkoutById(String id) {
    try {
      return getWorkouts().firstWhere((workout) => workout.id == id);
    } catch (e) {
      return null;
    }
  }
}
