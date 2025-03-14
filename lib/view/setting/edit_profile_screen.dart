import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:recipy/utils/constants.dart';
import 'package:recipy/view/setting/setting_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  List<TextInputFormatter> inputFormatters = [FilteringTextInputFormatter.deny(RegExp(r'[<>]')),];

  final List<String> genderOptions = ["Male", "Female", "Other"];
  String? selectedGender; // To store the selected value

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isLoading  = true;

  showLoading(){
    setState(() {
      isLoading = true;
    });
  }

  hideLoading(){
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setProfileData();
  }

  setProfileData() async {
    final pref = Constants.securePreferences();
    usernameController.text = await pref.read(key: Constants.name) ?? "";
    emailController.text = await pref.read(key: Constants.email) ?? "";
    genderController.text = await pref.read(key: Constants.gender) ?? "";
    selectedGender = await pref.read(key: Constants.gender) ?? "";
    phoneController.text = await pref.read(key: Constants.phoneNumber) ?? "";
    hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle('🖋️ Edit Your Details'),
            buildTextField("Username", usernameController,inputFormatters,TextInputType.name,40),
            buildTextField("Email", emailController,inputFormatters,TextInputType.emailAddress,40),
            buildGenderDropdown(),
            buildTextField("Phone Number", phoneController,[IndianMobileNumberFormatter()],TextInputType.number,10),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (!validateFields()) {
                    return;
                  }
                  final pref = Constants.securePreferences();
                  await pref.write(key: Constants.name, value: usernameController.text);
                  await pref.write(key: Constants.email, value: emailController.text);
                  await pref.write(key: Constants.gender, value: genderController.text);
                  await pref.write(key: Constants.phoneNumber, value: phoneController.text);

                  Get.offAll(() => SettingScreen());
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateFields() {
    if (usernameController.text.trim().isEmpty) {
      Constants.showSnackBar("Please enter username", Colors.red);
      return false;
    }

    if (emailController.text.trim().isEmpty) {
      Constants.showSnackBar("Please enter email address", Colors.red);
      return false;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      Constants.showSnackBar("Please enter a valid email address", Colors.red);
      return false;
    }

    if (genderController.text.trim().isEmpty) {
      Constants.showSnackBar("Please select gender", Colors.red);
      return false;
    }

    if (phoneController.text.trim().isEmpty) {
      Constants.showSnackBar("Please enter phone number", Colors.red);
      return false;
    }

    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(phoneController.text.trim())) {
      Constants.showSnackBar("Please enter a valid phone number", Colors.red);
      return false;
    }

    return true;
  }


  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, List<TextInputFormatter>? textInputFormatters,TextInputType textInputType,int maxLength) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        maxLength: maxLength,
        keyboardType: textInputType,
        controller: controller,
        inputFormatters: inputFormatters,
        textInputAction: TextInputAction.next,
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          counterText: "",
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
          ),
        ),
      ),
    );
  }

  Widget buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: selectedGender,
        items: genderOptions.map((String gender) {
          return DropdownMenuItem<String>(
            value: gender,
            child: Text(gender),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedGender = newValue;
            genderController.text = newValue ?? ''; // Update the controller
          });
        },
        decoration: InputDecoration(
          labelText: "Gender",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
          ),
        ),
      ),
    );
  }

}
