import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:recipy/core/constants/constants.dart';
import 'package:recipy/core/services/auth_service.dart';
import 'package:recipy/presentation/controller/login_controller.dart';
import 'package:recipy/presentation/pages/dashboard_screen.dart';
import 'package:recipy/presentation/pages/setting/privacy_policy.dart';

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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SignInButton(
                        icon: Icons.email,
                        label: 'Continue with Google',
                        color: Colors.red.shade600,
                        textColor: Colors.white,
                        onTap: () async {
                          controller.showLoading();
                          final userCredential = await _auth.loginWithGoogle();

                          if (userCredential != null) {
                            print("---------------------------- eeeeeeeeeee ${userCredential.user}");
                            await _auth.saveUserData(userCredential.user);

                            final pref = Constants.securePreferences();
                            await pref.write(
                              key: Constants.uid,
                              value: userCredential.user?.uid,
                            );
                            await pref.write(
                              key: Constants.email,
                              value: userCredential.user?.email,
                            );
                            await pref.write(
                              key: Constants.name,
                              value: userCredential.user?.displayName,
                            );
                            await pref.write(
                              key: Constants.profilePic,
                              value: userCredential.user?.photoURL,
                            );
                            await pref.write(
                                key: Constants.isLogin, value: true.toString());
                            controller.hideLoading();
                            Get.offAll(() => DashboardScreen());
                          }
                          print('Sign in with Google');
                        },
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'By setting up an account, you accept our ',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            height: 1.6,
                          ),
                          children: [
                            TextSpan(
                              text: 'privacy policy',
                              style: TextStyle(
                                fontSize: 15,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(() => PrivacyPolicy());
                                },
                            ),
                            TextSpan(
                              text: ' and agree to follow all applicable laws.', // Replaced " and our terms of service." with a period
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )


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
