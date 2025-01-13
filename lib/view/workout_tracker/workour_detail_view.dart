import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/view/workout_tracker/exercises_stpe_details.dart';
import 'package:fitness/view/workout_tracker/workout_guide_view.dart';
import 'package:flutter/material.dart';

import '../../common_widget/exercises_set_section.dart';

class WorkoutDetailView extends StatefulWidget {
  final Map dObj;
  const WorkoutDetailView({super.key, required this.dObj});

  @override
  State<WorkoutDetailView> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<WorkoutDetailView> {
  List fullbodyExercisesArr = [
    {
      "name": "Set 1",
      "set": [
        {
          "image": "assets/img/burpees-K.jpg",
          "imageB": "assets/img/burpees-B.jpeg",
          "title": "Burpees",
          "value": "12x",
          "desc":
              "Berdiri tegak, lalu turun ke posisi squat dengan tangan di lantai. Lompat ke posisi plank, lakukan push-up, kembali ke squat, dan lompat setinggi mungkin."
        },
        {
          "image": "assets/img/pushup-shouldertap.jpg",
          "imageB": "assets/img/shouldertap-B.png",
          "title": "Push Up to Shoulder Tap",
          "value": "12x",
          "desc":
              "Mulai dari posisi push-up. Turunkan tubuh hingga hampir menyentuh lantai, lalu dorong ke atas. Setelah itu, sentuh bahu kanan dengan tangan kiri, dan bahu kiri dengan tangan kanan."
        },
        {
          "image": "assets/img/bodyweightsquat-K.jpg",
          "imageB": "assets/img/Bodyweight-squat-B.png",
          "title": "Bodyweight Squat",
          "value": "15x",
          "desc":
              "Berdiri dengan kaki selebar bahu, turunkan pinggul seperti ingin duduk di kursi hingga paha sejajar lantai, lalu dorong kembali ke posisi berdiri."
        },
        {
          "image": "assets/img/mountainclimbers-K.jpg",
          "imageB": "assets/img/mountain-climbers-B.jpg",
          "title": "Mountain Climbers",
          "value": "20x",
          "desc":
              "Mulai dari posisi plank, tarik lutut kanan ke arah dada, lalu kembali ke posisi awal dan ulangi dengan kaki kiri secara bergantian dengan cepat."
        },
        {
          "image": "assets/img/plankwitharm-K.jpg",
          "imageB": "assets/img/plankwitharm-B.png",
          "title": "Plank with Arm Lift",
          "value": "00:30",
          "desc":
              "Mulai dari posisi plank, angkat tangan kanan lurus ke depan, tahan selama 2 detik, lalu turunkan dan ganti dengan tangan kiri."
        },
      ],
    },
    {
      "name": "Set 2",
      "set": [
        {
          "image": "assets/img/burpees-K.jpg",
          "imageB": "assets/img/burpees-B.jpeg",
          "title": "Burpees",
          "value": "12x",
          "desc":
              "Berdiri tegak, lalu turun ke posisi squat dengan tangan di lantai. Lompat ke posisi plank, lakukan push-up, kembali ke squat, dan lompat setinggi mungkin."
        },
        {
          "image": "assets/img/pushup-shouldertap.jpg",
          "imageB": "assets/img/shouldertap-B.png",
          "title": "Push Up to Shoulder Tap",
          "value": "12x",
          "desc":
              "Mulai dari posisi push-up. Turunkan tubuh hingga hampir menyentuh lantai, lalu dorong ke atas. Setelah itu, sentuh bahu kanan dengan tangan kiri, dan bahu kiri dengan tangan kanan."
        },
        {
          "image": "assets/img/bodyweightsquat-K.jpg",
          "imageB": "assets/img/Bodyweight-squat-B.png",
          "title": "Bodyweight Squat",
          "value": "15x",
          "desc":
              "Berdiri dengan kaki selebar bahu, turunkan pinggul seperti ingin duduk di kursi hingga paha sejajar lantai, lalu dorong kembali ke posisi berdiri."
        },
        {
          "image": "assets/img/mountainclimbers-K.jpg",
          "imageB": "assets/img/mountain-climbers-B.jpg",
          "title": "Mountain Climbers",
          "value": "20x",
          "desc":
              "Mulai dari posisi plank, tarik lutut kanan ke arah dada, lalu kembali ke posisi awal dan ulangi dengan kaki kiri secara bergantian dengan cepat."
        },
        {
          "image": "assets/img/plankwitharm-K.jpg",
          "imageB": "assets/img/plankwitharm-B.png",
          "title": "Plank with Arm Lift",
          "value": "00:30",
          "desc":
              "Mulai dari posisi plank, angkat tangan kanan lurus ke depan, tahan selama 2 detik, lalu turunkan dan ganti dengan tangan kiri."
        },
      ],
    }
  ];

  List lowerbodyExercisesArr = [
    {
      "name": "Set 1",
      "set": [
        {
          "image": "assets/img/lunges-K.jpeg",
          "imageB": "assets/img/lunges-B.jpg",
          "title": "Lunges",
          "value": "10x",
          "desc":
              "Berdiri tegak, melangkah maju dengan satu kaki, turunkan tubuh hingga kedua lutut membentuk sudut 90 derajat, lalu dorong kembali ke posisi awal. Ulangi dengan kaki lainnya."
        },
        {
          "image": "assets/img/glutebridge-K.jpg",
          "imageB": "assets/img/glutebridge-B.png",
          "title": "Glute Bridge",
          "value": "15x",
          "desc":
              "Berbaring telentang dengan lutut ditekuk dan telapak kaki menempel di lantai. Angkat pinggul setinggi mungkin, tahan selama 2 detik, lalu turunkan perlahan."
        },
        {
          "image": "assets/img/stepup-K.jpg",
          "imageB": "assets/img/step up-B.jpeg",
          "title": "Step-Ups",
          "value": "10x",
          "desc":
              "Berdiri di depan bangku atau tangga. Naikkan satu kaki ke atas bangku, dorong tubuh hingga berdiri tegak, lalu turunkan perlahan. Ulangi dengan kaki lainnya."
        },
        {
          "image": "assets/img/bulgariansquat-K.jpeg",
          "imageB": "assets/img/bulgariansquat-B.jpeg",
          "title": "Bulgarian Squats",
          "value": "20x",
          "desc":
              "Letakkan satu kaki di kursi atau bangku di belakang Anda. Turunkan tubuh hingga lutut depan membentuk sudut 90 derajat, lalu dorong kembali ke posisi berdiri."
        },
        {
          "image": "assets/img/Wallsit.jpeg",
          "imageB": "assets/img/Wallsit.jpeg",
          "title": "Wall Sit",
          "value": "00:30",
          "desc":
              "Bersandar pada dinding dengan lutut ditekuk membentuk sudut 90 derajat, tahan posisi ini selama durasi yang ditentukan."
        },
      ],
    },
    {
      "name": "Set 2",
      "set": [
        {
          "image": "assets/img/lunges-K.jpeg",
          "imageB": "assets/img/lunges-B.jpg",
          "title": "Lunges",
          "value": "10x",
          "desc":
              "Berdiri tegak, melangkah maju dengan satu kaki, turunkan tubuh hingga kedua lutut membentuk sudut 90 derajat, lalu dorong kembali ke posisi awal. Ulangi dengan kaki lainnya."
        },
        {
          "image": "assets/img/glutebridge-K.jpg",
          "imageB": "assets/img/glutebridge-B.png",
          "title": "Glute Bridge",
          "value": "15x",
          "desc":
              "Berbaring telentang dengan lutut ditekuk dan telapak kaki menempel di lantai. Angkat pinggul setinggi mungkin, tahan selama 2 detik, lalu turunkan perlahan."
        },
        {
          "image": "assets/img/stepup-K.jpg",
          "imageB": "assets/img/step up-B.jpeg",
          "title": "Step-Ups",
          "value": "10x",
          "desc":
              "Berdiri di depan bangku atau tangga. Naikkan satu kaki ke atas bangku, dorong tubuh hingga berdiri tegak, lalu turunkan perlahan. Ulangi dengan kaki lainnya."
        },
        {
          "image": "assets/img/bulgariansquat-K.jpeg",
          "imageB": "assets/img/bulgariansquat-B.jpeg",
          "title": "Bulgarian Squats",
          "value": "20x",
          "desc":
              "Letakkan satu kaki di kursi atau bangku di belakang Anda. Turunkan tubuh hingga lutut depan membentuk sudut 90 derajat, lalu dorong kembali ke posisi berdiri."
        },
        {
          "image": "assets/img/Wallsit.jpeg",
          "imageB": "assets/img/Wallsit.jpeg",
          "title": "Wall Sit",
          "value": "00:30",
          "desc":
              "Bersandar pada dinding dengan lutut ditekuk membentuk sudut 90 derajat, tahan posisi ini selama durasi yang ditentukan."
        },
      ],
    }
  ];

  List abExercisesArr = [
    {
      "name": "Set 1",
      "set": [
        {
          "image": "assets/img/crunches-B.jpeg",
          "imageB": "assets/img/burpees-K.jpg",
          "title": "Crunches",
          "value": "15x",
          "desc":
              "Berbaring telentang dengan lutut ditekuk. Angkat kepala dan bahu dari lantai dengan mengencangkan otot perut, lalu turunkan kembali."
        },
        {
          "image": "assets/img/legraises-B.jpg",
          "imageB": "assets/img/burpees-K.jpg",
          "title": "Leg Raises",
          "value": "15x",
          "desc":
              "Berbaring telentang, angkat kedua kaki lurus ke atas hingga membentuk sudut 90 derajat, lalu turunkan perlahan tanpa menyentuh lantai."
        },
        {
          "image": "assets/img/Bicyclecrunches-K.jpeg",
          "imageB": "assets/img/burpees-B.jpg",
          "title": "Bicycle Crunches",
          "value": "20x",
          "desc":
              "Berbaring telentang, angkat kepala dan bahu, lalu gerakkan siku kanan ke arah lutut kiri sambil meluruskan kaki kanan. Ulangi bergantian."
        },
        {
          "image": "assets/img/plank.jpg",
          "imageB": "assets/img/plank.jpg",
          "title": "Plank",
          "value": "00:30",
          "desc":
              "Mulai dari posisi plank (siku di lantai), tahan posisi dengan tubuh lurus dari kepala hingga kaki."
        },
        {
          "image": "assets/img/russiantwist.jpeg",
          "imageB": "assets/img/russiantwist.jpeg",
          "title": "Russian Twists",
          "value": "20x",
          "desc":
              "Duduk dengan lutut ditekuk, angkat kaki sedikit dari lantai, dan putar tubuh ke kanan dan kiri secara bergantian."
        },
      ],
    },
    {
      "name": "Set 2",
      "set": [
        {
          "image": "assets/img/crunches-B.jpeg",
          "imageB": "assets/img/burpees-K.jpg",
          "title": "Crunches",
          "value": "15x",
          "desc":
              "Berbaring telentang dengan lutut ditekuk. Angkat kepala dan bahu dari lantai dengan mengencangkan otot perut, lalu turunkan kembali."
        },
        {
          "image": "assets/img/legraises-B.jpg",
          "imageB": "assets/img/burpees-K.jpg",
          "title": "Leg Raises",
          "value": "15x",
          "desc":
              "Berbaring telentang, angkat kedua kaki lurus ke atas hingga membentuk sudut 90 derajat, lalu turunkan perlahan tanpa menyentuh lantai."
        },
        {
          "image": "assets/img/Bicyclecrunches-K.jpeg",
          "imageB": "assets/img/burpees-B.jpg",
          "title": "Bicycle Crunches",
          "value": "20x",
          "desc":
              "Berbaring telentang, angkat kepala dan bahu, lalu gerakkan siku kanan ke arah lutut kiri sambil meluruskan kaki kanan. Ulangi bergantian."
        },
        {
          "image": "assets/img/plank.jpg",
          "imageB": "assets/img/plank.jpg",
          "title": "Plank",
          "value": "00:30",
          "desc":
              "Mulai dari posisi plank (siku di lantai), tahan posisi dengan tubuh lurus dari kepala hingga kaki."
        },
        {
          "image": "assets/img/russiantwist.jpeg",
          "imageB": "assets/img/russiantwist.jpeg",
          "title": "Russian Twists",
          "value": "20x",
          "desc":
              "Duduk dengan lutut ditekuk, angkat kaki sedikit dari lantai, dan putar tubuh ke kanan dan kiri secara bergantian."
        },
      ],
    }
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    // Pilih list exercises berdasarkan dObj["title"]
    List exercisesArr = [];
    if (widget.dObj["title"] == "Fullbody Workout") {
      exercisesArr = fullbodyExercisesArr;
    } else if (widget.dObj["title"] == "Lowebody Workout") {
      exercisesArr = lowerbodyExercisesArr;
    } else if (widget.dObj["title"] == "AB Workout") {
      exercisesArr = abExercisesArr;
    }

    return Container(
      decoration:
          BoxDecoration(gradient: LinearGradient(colors: TColor.primaryG)),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: TColor.LightGray,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                    "assets/img/black_btn.png",
                    width: 15,
                    height: 15,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              leadingWidth: 0,
              leading: Container(),
              expandedHeight: media.width * 0.5,
              flexibleSpace: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/img/detail_top.png",
                  width: media.width * 0.75,
                  height: media.width * 0.8,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: TColor.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 50,
                        height: 4,
                        decoration: BoxDecoration(
                            color: TColor.gray.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(3)),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.dObj["title"].toString(),
                                  style: TextStyle(
                                      color: TColor.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Exercises",
                            style: TextStyle(
                                color: TColor.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: exercisesArr.length,
                        itemBuilder: (context, index) {
                          var sObj = exercisesArr[index] as Map? ?? {};
                          return ExercisesSetSection(
                            sObj: sObj,
                            onPressed: (obj) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExercisesStepDetails(
                                    eObj: obj,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: media.width * 0.1,
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundButton(
                        title: "Start Workout",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkoutGuideView(
                                workoutSteps: exercisesArr
                                    .expand((set) => set["set"])
                                    .toList(), // Gabungkan semua langkah dari setiap set
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
