import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manystore/users/Auth/HOME.dart';
import 'package:manystore/users/Auth/Register_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Create a controller for login
class LoginController extends GetxController {
  var obscurePassword = true.obs;
  var isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool> login() async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.22/php/Api/users/Login.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_email': emailController.text.trim(),
          'user_password': passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == true) {
          Get.snackbar('Success', 'Login successful',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green);
          return true;
        } else {
          Get.snackbar('Error', responseData['message'],
              snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
          return false;
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Connection failed: $e',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: LayoutBuilder(
        builder: (context, cons) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: cons.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT51I5MbUHfP3UB8_5wMIK_-PQK_0ZnCPOhrg&s",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 7,
                            color: Colors.white10,
                            offset: Offset(0, -3),
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: loginController.emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                                hintText: 'Enter your email',
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!value.contains('@')) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            Obx(
                              () => TextFormField(
                                controller: loginController.passwordController,
                                obscureText:
                                    loginController.obscurePassword.value,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      loginController.obscurePassword.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      loginController.obscurePassword.toggle();
                                    },
                                  ),
                                  hintText: 'Enter your password',
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Please enter your password';
                                //   }
                                //   if (value.length < 6) {
                                //     return 'Password must be at least 6 characters';
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                            SizedBox(height: 24),
                            Obx(
                              () => loginController.isLoading.value
                                  ? CircularProgressIndicator(
                                      color: Colors.white)
                                  : SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            bool success =
                                                await loginController.login();
                                            if (success) {
                                              // Navigate to home screen after successful login
                                              Get.offAll(() => Home());
                                            }
                                          }
                                        },
                                        child: Text(
                                          'LOGIN',
                                          style: TextStyle(
                                            color: Colors.deepPurpleAccent,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.to(() => RegisterScreen());
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 243, 8, 8),
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "OR",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Are you Admin? ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Add admin login navigation here
                                  },
                                  child: Text(
                                    'Record',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 175, 2, 2),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
