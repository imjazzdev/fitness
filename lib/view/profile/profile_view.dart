import 'package:fitness/helpers/database_helper.dart';
import 'package:fitness/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/colo_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/title_subtitle_cell.dart';
import 'dart:io';

class ProfileView extends StatefulWidget {
  final String username;
  const ProfileView({super.key, required this.username});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  @override
void initState() {
  super.initState();
  _loadProfile();
}

Future<void> _loadProfile() async {
  // Ambil data profil dari SQLite
  Profile? profile = await DatabaseHelper().getProfile(1);
  if (profile != null) {
    setState(() {
      height = profile.height;
      weight = profile.weight;
      age = profile.age;
      _profileImage = profile.profileImagePath != null ? File(profile.profileImagePath!) : null;
    });
  } else {
    // Jika tidak ada data, buat entri kosong default
    final defaultProfile = Profile(
      id: 1,
      username: widget.username,
      height: 0,
      weight: 0,
      age: 0,
      profileImagePath: null,
    );
    await DatabaseHelper().insertProfile(defaultProfile);
    setState(() {
      height = 0;
      weight = 0;
      age = 0;
      _profileImage = null;
    });
  }
}


  int height = 0;
  int weight = 0;
  int age = 0;
  File? _profileImage;

  Future<void> _pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    setState(() {
      _profileImage = File(pickedFile.path);
    });

    // Perbarui hanya path gambar di database
    await DatabaseHelper().updateProfilePicture(1, pickedFile.path);
  }
}


  void _editProfile() async {
  final updatedValues = await showDialog<Map<String, int>>(
    context: context,
    builder: (BuildContext context) {
      int tempHeight = height;
      int tempWeight = weight;
      int tempAge = age;

      return AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Height (cm)"),
              onChanged: (value) {
                tempHeight = int.tryParse(value) ?? tempHeight;
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Weight (kg)"),
              onChanged: (value) {
                tempWeight = int.tryParse(value) ?? tempWeight;
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Age (years)"),
              onChanged: (value) {
                tempAge = int.tryParse(value) ?? tempAge;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(null);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop({
                "height": tempHeight,
                "weight": tempWeight,
                "age": tempAge,
              });
            },
            child: const Text("Save"),
          ),
        ],
      );
    },
  );

  if (updatedValues != null) {
    setState(() {
      height = updatedValues["height"]!;
      weight = updatedValues["weight"]!;
      age = updatedValues["age"]!;
    });

    // Simpan ke database
    final profile = Profile(
      id: 1,
      username: widget.username,
      height: height,
      weight: weight,
      age: age,
      profileImagePath: _profileImage?.path,
    );
    await DatabaseHelper().updateProfile(profile);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: Text(
                    "Profile",
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: _profileImage != null
                          ? Image.file(
                              _profileImage!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/img/u2.png",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.username,
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    height: 35,
                    child: RoundButton(
                      title: "Edit",
                      type: RoundButtonType.bgGradient,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      onPressed: _editProfile,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TitleSubtitleCell(
                      title: "$height cm",
                      subtitle: "Height",
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TitleSubtitleCell(
                      title: "$weight kg",
                      subtitle: "Weight",
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TitleSubtitleCell(
                      title: "$age yo",
                      subtitle: "Age",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
