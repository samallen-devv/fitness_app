import 'package:flutter/material.dart';
import '../models/workout.dart';

class WorkoutTimerScreen extends StatefulWidget {
  final Workout workout;

  const WorkoutTimerScreen({
    super.key,
    required this.workout,
  });

  @override
  State<WorkoutTimerScreen> createState() => _WorkoutTimerScreenState();
}

class _WorkoutTimerScreenState extends State<WorkoutTimerScreen>
    with SingleTickerProviderStateMixin {
  late int _currentExerciseIndex;
  late int _remainingSeconds;
  late bool _isResting;
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _currentExerciseIndex = 0;
    _remainingSeconds = widget.workout.exercises[0].duration;
    _isResting = false;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _startTimer();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
          _animationController.forward(from: 0.0);
        } else {
          if (_isResting) {
            _isResting = false;
            _currentExerciseIndex++;
            if (_currentExerciseIndex < widget.workout.exercises.length) {
              _remainingSeconds =
                  widget.workout.exercises[_currentExerciseIndex].duration;
            } else {
              // Workout completed
              Navigator.pop(context);
              return;
            }
          } else {
            _isResting = true;
            _remainingSeconds = 30; // 30 seconds rest
          }
        }
      });

      _startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentExercise = widget.workout.exercises[_currentExerciseIndex];
    final progress =
        _remainingSeconds / (_isResting ? 30 : currentExercise.duration);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildProgressBar(progress),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isResting ? 'Rest Time' : currentExercise.name,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 1.0 + (_progressAnimation.value * 0.1),
                          child: Text(
                            '$_remainingSeconds',
                            style: const TextStyle(
                              fontSize: 72,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _isResting
                          ? 'Take a breather'
                          : '${currentExercise.sets} sets × ${currentExercise.reps} reps',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 48),
                    _buildNextExercise(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Container(
      height: 4,
      width: double.infinity,
      color: Colors.grey[200],
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildNextExercise() {
    if (_currentExerciseIndex + 1 >= widget.workout.exercises.length) {
      return const Text(
        'Last exercise!',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    final nextExercise = widget.workout.exercises[_currentExerciseIndex + 1];
    return Column(
      children: [
        const Text(
          'Next Exercise',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          nextExercise.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            onPressed: () {
              setState(() {
                if (_isResting) {
                  _isResting = false;
                  _currentExerciseIndex++;
                  if (_currentExerciseIndex < widget.workout.exercises.length) {
                    _remainingSeconds = widget
                        .workout.exercises[_currentExerciseIndex].duration;
                  } else {
                    Navigator.pop(context);
                  }
                } else {
                  _remainingSeconds = 0;
                }
              });
            },
            icon: const Icon(Icons.skip_next),
            label: const Text('Skip'),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.stop),
            label: const Text('End Workout'),
          ),
        ],
      ),
    );
  }
}
