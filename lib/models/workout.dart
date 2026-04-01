class Workout {
  final String id;
  final String name;
  final String description;
  final int duration; // in minutes
  final int exerciseCount;
  final List<Exercise> exercises;
  final String difficulty;
  final String imageUrl;

  Workout({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.exerciseCount,
    required this.exercises,
    required this.difficulty,
    required this.imageUrl,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      duration: json['duration'],
      exerciseCount: json['exerciseCount'],
      exercises:
          (json['exercises'] as List).map((e) => Exercise.fromJson(e)).toList(),
      difficulty: json['difficulty'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'duration': duration,
      'exerciseCount': exerciseCount,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'difficulty': difficulty,
      'imageUrl': imageUrl,
    };
  }
}

class Exercise {
  final String id;
  final String name;
  final String description;
  final int sets;
  final int reps;
  final String imageUrl;
  final int duration; // in seconds

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.sets,
    required this.reps,
    required this.imageUrl,
    required this.duration,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      sets: json['sets'],
      reps: json['reps'],
      imageUrl: json['imageUrl'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'sets': sets,
      'reps': reps,
      'imageUrl': imageUrl,
      'duration': duration,
    };
  }
}
