import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/common_widget/round_textfield.dart';
import 'package:fitness/view/login/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:fitness/view/api_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool isLoading = false;

  void dispose() {
      _usernameController.dispose();
      _passwordController.dispose();
      super.dispose();
    }

  void _handleLogin() async {
    setState(() {
      isLoading = true;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Username dan password tidak boleh kosong.")),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    final response = await _apiService.login(username, password);
    setState(() {
      isLoading = false;
    });

    if (response != null && response['status'] != null && response['status'] is bool) {
      if (response['status'] == true) {
        // Jika login berhasil, arahkan ke HomeView
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeView(
                  username: username,
                )),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login gagal: ${response['message']}")),
        );
      }
    } else {
      // Jika response atau response['success'] adalah null
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan, coba lagi.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: media.height,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Hey there,", style: TextStyle(color: TColor.gray, fontSize: 16)),
                Text("Welcome Back",
                    style: TextStyle(color: TColor.black, fontSize: 20, fontWeight: FontWeight.w700)),
                SizedBox(height: media.width * 0.05),
                RoundTextField(
                  hitText: "Name",
                  icon: "assets/img/profile_tab.png",
                  controller: _usernameController,
                ),
                SizedBox(height: media.width * 0.04),
                RoundTextField(
                  hitText: "Password",
                  icon: "assets/img/lock.png",
                  obscureText: true,
                  controller: _passwordController,
                ),
                Spacer(),
                isLoading
                    ? CircularProgressIndicator()
                    : RoundButton(title: "Login", onPressed: _handleLogin),
                SizedBox(height: media.width * 0.15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
