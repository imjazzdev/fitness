import 'package:fitness/view/home/finished_workout_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../../common/colo_extension.dart';


class WorkoutGuideView extends StatefulWidget {
  final List workoutSteps;

  const WorkoutGuideView({super.key, required this.workoutSteps});

  @override
  State<WorkoutGuideView> createState() => _WorkoutGuideViewState();
}

class _WorkoutGuideViewState extends State<WorkoutGuideView> {
  int currentStepIndex = 0; // Indeks langkah saat ini
  Timer? timer;
  int remainingTime = 0;

  @override
  void initState() {
    super.initState();
    if (_isTimedStep(widget.workoutSteps[currentStepIndex])) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  bool _isTimedStep(Map step) {
    return step["value"].contains(":");
  }

  void _startTimer() {
    setState(() {
      remainingTime = int.parse(widget.workoutSteps[currentStepIndex]["value"]
          .split(":")[1]); // Ambil nilai detik
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
        _goToNextStep();
      }
    });
  }

  void _goToNextStep() {
    if (currentStepIndex < widget.workoutSteps.length - 1) {
      setState(() {
        currentStepIndex++;
        timer?.cancel();
        if (_isTimedStep(widget.workoutSteps[currentStepIndex])) {
          _startTimer();
        }
      });
    } else {
      // Selesai, navigasi ke halaman selesai
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FinishedWorkoutView()),
      );
    }
  }

  void _goToPreviousStep() {
    if (currentStepIndex > 0) {
      setState(() {
        currentStepIndex--;
        timer?.cancel();
        if (_isTimedStep(widget.workoutSteps[currentStepIndex])) {
          _startTimer();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var currentStep = widget.workoutSteps[currentStepIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout Guide"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Gambar Tengah
            Image.asset(
              currentStep["imageB"],
              width: media.width * 0.8,
              height: media.width * 0.8,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),

            // Nama Gerakan
            Text(
              currentStep["title"],
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Value (Repetisi atau Timer)
            _isTimedStep(currentStep)
                ? Text(
                    "00:${remainingTime.toString().padLeft(2, '0')}",
                    style: const TextStyle(
                        fontSize: 48, fontWeight: FontWeight.bold),
                  )
                : Text(
                    currentStep["value"],
                    style: const TextStyle(
                        fontSize: 48, fontWeight: FontWeight.bold),
                  ),
            const SizedBox(height: 20),

            // Deskripsi Gerakan
            Text(
              currentStep["desc"],
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const Spacer(),

            // Tombol Navigasi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed:
                      currentStepIndex > 0 ? _goToPreviousStep : null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: TColor.secondaryColor2),
                  child: const Text("Back"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!_isTimedStep(currentStep)) {
                      _goToNextStep();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: TColor.primaryColor1),
                  child: const Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
