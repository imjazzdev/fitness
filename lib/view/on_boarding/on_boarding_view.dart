import 'package:fitness/common_widget/on_boarding_page.dart';
import 'package:fitness/view/login/signup_view.dart';
import 'package:flutter/material.dart';
import '../../common/colo_extension.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int selectPage = 0;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      selectPage = controller.page?.round() ?? 0;
      setState(() {});
    });
  }

  List pageArr = [
    {
      "title": "Selamat datang di Bugarraga",
      "subtitle":
          "Mulai perjalanan sehatmu dengan panduan yang praktis dan mudah diikuti.",
      "image": "assets/img/on_1.png"
    },
    {
      "title": "Bergerak Lebih Aktif",
      "subtitle":
          "Lari kecil setiap hari dapat meningkatkan kesehatan jantungmu.",
      "image": "assets/img/on_2.png"
    },
    {
      "title": "Nutrisi untuk Hidup Sehat",
      "subtitle":
          "Masak makanan sehat untuk mendukung gaya hidup aktifmu.",
      "image": "assets/img/on_3.png"
    },
    {
      "title": "Berikan Tubuhmu Waktu Istirahat",
      "subtitle":
          "Pemulihan adalah bagian penting dari kebugaran yang optimal.",
      "image": "assets/img/on_4.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PageView.builder(
            controller: controller,
            itemCount: pageArr.length,
            itemBuilder: (context, index) {
              var p0bj = pageArr[index] as Map? ?? {};
              return OnBoardingPage(p0bj: p0bj);
            },
          ),
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    color: TColor.primaryColor1,
                    value: (selectPage + 1) / 4,
                    strokeWidth: 2,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: TColor.primaryColor1,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      color: TColor.white,
                    ),
                    onPressed: () {
                      if (selectPage < 3) {
                        // Open next page smoothly
                        controller.animateToPage(
                          selectPage + 1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Navigate to SignUpView
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpView(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
