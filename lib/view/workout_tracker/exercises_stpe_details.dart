import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ExercisesStepDetails extends StatefulWidget {
  final Map eObj;
  const ExercisesStepDetails({super.key, required this.eObj});

  @override
  State<ExercisesStepDetails> createState() => _ExercisesStepDetailsState();
}

class _ExercisesStepDetailsState extends State<ExercisesStepDetails> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    // Ambil data dari eObj
    var imageB = widget.eObj["imageB"] ?? "";
    var title = widget.eObj["title"] ?? "No Title";
    var value = widget.eObj["value"] ?? "No Value";
    var desc = widget.eObj["desc"] ?? "No Description";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise Details"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hanya tampilkan imageB
              if (imageB.isNotEmpty)
                Image.asset(
                  imageB,
                  width: media.width,
                  height: media.width * 0.5,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 16),

              // Title
              Text(
                title,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Repetitions
              Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                "Description:",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                desc,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
