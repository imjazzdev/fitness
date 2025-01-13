import 'dart:io'; // Menambahkan ini untuk mendukung File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/colo_extension.dart';

class PhotoProgressView extends StatefulWidget {
  const PhotoProgressView({super.key});

  @override
  State<PhotoProgressView> createState() => _PhotoProgressViewState();
}

class _PhotoProgressViewState extends State<PhotoProgressView> {
  List photoArr = [];

  Future<void> _uploadPhoto() async {
    // Menampilkan dialog konfirmasi
    bool? confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Tolong masukkan gambar dengan benar."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Lanjutkan"),
          ),
        ],
      ),
    );

    // Jika pengguna memilih "Lanjutkan", buka galeri atau kamera
    if (confirm == true) {
      final picker = ImagePicker();
      // Pilih antara kamera atau galeri
      final pickedFile = await picker.pickImage(source: ImageSource.gallery); // Ganti dengan ImageSource.camera jika ingin menggunakan kamera

      if (pickedFile != null) {
        String currentDate = "${DateTime.now().day} ${DateTime.now().month}";

        setState(() {
          var existingEntry = photoArr.firstWhere(
            (entry) => entry["time"] == currentDate,
            orElse: () => {},
          );

          if (existingEntry.isNotEmpty) {
            existingEntry["photo"].add(pickedFile.path);
          } else {
            photoArr.add({
              "time": currentDate,
              "photo": [pickedFile.path],
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 0,
        leading: const SizedBox(),
        title:  Text(
          "Progress Photo",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColor.LightGray,
                  borderRadius: BorderRadius.circular(10)),
              
            ),
          )
        ],
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Gallery",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  
                ],
              ),
            ),
            ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: photoArr.length,
                itemBuilder: ((context, index) {
                  var pObj = photoArr[index] as Map? ?? {};
                  var imaArr = pObj["photo"] as List? ?? [];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          pObj["time"].toString(),
                          style: TextStyle(color: TColor.gray, fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemCount: imaArr.length,
                          itemBuilder: ((context, indexRow) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              width: 100,
                              decoration: BoxDecoration(
                                color: TColor.LightGray,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(imaArr[indexRow] as String? ?? ""),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  );
                }))
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: _uploadPhoto,
        child: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: TColor.secondaryG),
              borderRadius: BorderRadius.circular(27.5),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))
              ]),
          alignment: Alignment.center,
          child: Icon(
            Icons.photo_camera,
            size: 20,
            color: TColor.white,
          ),
        ),
      ),
    );
  }
}