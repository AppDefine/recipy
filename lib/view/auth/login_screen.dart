import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:recipy/auth_service.dart';
import 'package:recipy/controller/LoginController.dart';
import 'package:recipy/utils/constants.dart';
import 'package:recipy/view/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.find();
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Obx(() => LoadingOverlay(
        isLoading: controller.isLoading.value,
        color: kPrimaryColor.withValues(alpha: 0.2),
        progressIndicator: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Header Section
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        'Welcome to Recipy',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Discover and share amazing recipes with food lovers worldwide!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),

                // Sign-In Options
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SignInButton(
                        icon: Icons.facebook,
                        label: 'Continue with Facebook',
                        color: Colors.blue.shade800,
                        textColor: Colors.white,
                        onTap: () async {
                          print('Sign in with Facebook');
                        },
                      ),
                      SignInButton(
                        icon: Icons.email,
                        label: 'Continue with Google',
                        color: Colors.red.shade600,
                        textColor: Colors.white,
                        onTap: () async {
                          controller.showLoading();
                          final userCredential = await _auth.loginWithGoogle();

                          if (userCredential != null) {
                            final pref = Constants.securePreferences();
                            await pref.write(
                              key: Constants.uid,
                              value: userCredential.user?.email,
                            );
                            await pref.write(
                              key: Constants.email,
                              value: userCredential.user?.email,
                            );
                            await pref.write(
                              key: Constants.name,
                              value: userCredential.user?.email,
                            );
                            await pref.write(
                                key: Constants.isLogin, value: true.toString());
                            controller.hideLoading();
                            Get.offAll(() => DashboardScreen());
                          }
                          print('Sign in with Google');
                        },
                      ),
                      SignInButton(
                        icon: Icons.mail,
                        label: 'Sign up with Email',
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        onTap: () async {
                          print('Sign up with Email');
                        },
                      ),
                    ],
                  ),
                ),

                // Footer Section
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'By signing up, you agree to our',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      GestureDetector(
                        onTap: () => print('Open privacy policy'),
                        child: Text(
                          'Privacy Policy, Terms of Use, and Code of Conduct.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),);
  }
}

class SignInButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const SignInButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: onTap,
        icon: Icon(icon, color: textColor),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
