import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends StatefulWidget {
  final String username;
  final Map<String, dynamic>? newWorkout; // Menambahkan workout baru

  const HomeView({super.key, required this.username, this.newWorkout});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int activeIndex = 0;
  List<Map<String, dynamic>> lastWorkoutArr = []; // Menyimpan riwayat workout
  final CarouselSliderController controller = CarouselSliderController();

  final List<String> urlImages = [
    'assets/img/gym1.jpg',
    'assets/img/gym2.jpg',
    'assets/img/gym3.jpg'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.newWorkout != null) {
      addWorkoutToHistory(widget.newWorkout!);
    }
  }

  void addWorkoutToHistory(Map<String, dynamic> workout) {
    setState(() {
      lastWorkoutArr.insert(0, workout);
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeSection(),
                SizedBox(height: media.width * 0.1),
                _buildCarouselSlider(),
                SizedBox(height: media.width * 0.1),
                // Tambahkan Quotes Section
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Pusatkan konten
                  children: [
                    // Title Quotes
                    const Text(
                      'Quotes', // Title Quotes
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10), // Spasi antara title dan gambar
                    // Gambar untuk Quotes
                    Image.asset(
                      'assets/img/cbum.jpg', // Ganti dengan path gambar Anda
                      width: media.width * 0.9,
                      height: media.width * 0.5,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                        height: 10), // Spasi antara gambar dan teks Quotes
                    // Teks Quotes
                    const Text(
                      '“Three days on, one day off. Three days on, one day off. Repeat.”', // Quotes Anda
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '- Chris Bumstead (CBum)', // Nama Pengarang
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 10),
                    Image.asset(
                      'assets/img/ronnie2.jpg', // Ganti dengan path gambar Anda
                      width: media.width * 0.9,
                      height: media.width * 0.5,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                        height: 10), // Spasi antara gambar dan teks Quotes
                    // Teks Quotes
                    const Text(
                      '"The real workout starts when you want to stop"', // Quotes Anda
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '- Ronnie Coleman', // Nama Pengarang
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: media.width * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back",
              style: TextStyle(color: TColor.gray, fontSize: 15),
            ),
            Text(
              widget.username,
              style: TextStyle(
                  color: TColor.black,
                  fontSize: 23,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCarouselSlider() {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: controller,
          itemCount: urlImages.length,
          itemBuilder: (context, index, realIndex) {
            final urlImage = urlImages[index];
            return _buildImage(urlImage, index);
          },
          options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enableInfiniteScroll: false,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              enlargeCenterPage: true,
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index)),
        ),
        const SizedBox(height: 12),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildImage(String urlImage, int index) {
    return Container(
      child: Image.asset(urlImage, fit: BoxFit.cover),
    );
  }

  Widget _buildIndicator() {
    return AnimatedSmoothIndicator(
      onDotClicked: animateToSlide,
      effect:
          const ExpandingDotsEffect(dotWidth: 15, activeDotColor: Colors.blue),
      activeIndex: activeIndex,
      count: urlImages.length,
    );
  }

  void animateToSlide(int index) => controller.animateToPage(index);
}
