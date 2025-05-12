import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:manystore/connectionApi/Api.connection.dart';
import 'package:manystore/users/Auth/model/model.dart';

// class RegisterController extends GetxController {
//   var obscurePassword = true.obs;
//   var isLoading = false.obs;
//   var passwordController = TextEditingController();
//   var emailController = TextEditingController();
//   var userNameController = TextEditingController();

//   Future<bool> registerAndSaveUser() async {
//     try {
//       User userModel = User(
//         user_name: userNameController.text.trim(),
//         user_email: emailController.text.trim(),
//         user_password: passwordController.text.trim(),
//       );

//       // Debug print to verify data
//       print('Sending registration data:');
//       print(jsonEncode(userModel.toJson()));

//       var response = await http.post(
//         Uri.parse(
//             ApI.hostConnecUser), // Make sure this is your correct endpoint
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(userModel.toJson()),
//       );

//       // Debug print to see response
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         var responseData = jsonDecode(response.body);
//         return responseData['status'] == true;
//       }
//       return false;
//     } catch (e) {
//       print('Registration error: $e');
//       return false;
//     }
//   }

//   Future<void> register() async {
//     isLoading.value = true;

//     try {
//       bool registrationSuccess = await registerAndSaveUser();

//       if (registrationSuccess) {
//         Fluttertoast.showToast(
//           msg: "Registration successful",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.green,
//           textColor: Colors.white,
//         );
//         Get.back(); // Return to login screen
//       } else {
//         Fluttertoast.showToast(
//           msg: "Registration failed",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//         );
//       }
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

class RegisterController extends GetxController {
  // Controllers
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Observables
  var obscurePassword = true.obs;
  var isLoading = false.obs;

  @override
  void onClose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<bool> registerAndSaveUser() async {
    try {
      // Get current values directly from controllers
      final userName = userNameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // Debug print to verify values
      print('Registering with:');
      print('Username: $userName');
      print('Email: $email');
      print('Password: $password');

      if (userName.isEmpty || email.isEmpty || password.isEmpty) {
        throw Exception('All fields are required');
      }

      final response = await http.post(
        Uri.parse(ApI.hostConnecUser),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_name': userName,
          'user_email': email,
          'user_password': password,
        }),
      );

      print('Response: ${response.statusCode} - ${response.body}');
      return response.statusCode == 200;
    } catch (e) {
      print('Registration error: $e');
      return false;
    }
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController registerController = Get.put(RegisterController());
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
                      "data:image/jpeg;base64,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",
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
                            // Added Username field
                            // TextFormField(
                            //   decoration: InputDecoration(
                            //     labelText: 'Username',
                            //     prefixIcon: Icon(Icons.person),
                            //     hintText: 'Enter your username',
                            //     fillColor: Colors.white,
                            //     filled: true,
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(10),
                            //     ),
                            //   ),
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please enter your username';
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // SizedBox(height: 16),
                            // TextFormField(
                            //   decoration: InputDecoration(
                            //     labelText: 'Email',
                            //     prefixIcon: Icon(Icons.email),
                            //     hintText: 'Enter your email',
                            //     fillColor: Colors.white,
                            //     filled: true,
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(10),
                            //     ),
                            //   ),
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please enter your email';
                            //     }
                            //     if (!value.contains('@')) {
                            //       return 'Please enter a valid email';
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // SizedBox(height: 16),
                            // Obx(
                            //   () => TextFormField(
                            //     obscureText:
                            //         registerController.obscurePassword.value,
                            //     decoration: InputDecoration(
                            //       labelText: 'Password',
                            //       prefixIcon: Icon(Icons.lock),
                            //       suffixIcon: IconButton(
                            //         icon: Icon(
                            //           registerController.obscurePassword.value
                            //               ? Icons.visibility_off
                            //               : Icons.visibility,
                            //         ),
                            //         onPressed: () {
                            //           // registerController.obscurePassword
                            //           //     .toggle();
                            //           print("is working");
                            //         },
                            //       ),
                            //       hintText: 'Enter your password',
                            //       fillColor: Colors.white,
                            //       filled: true,
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10),
                            //       ),
                            //     ),
                            //     validator: (value) {
                            //       if (value == null || value.isEmpty) {
                            //         return 'Please enter your password';
                            //       }
                            //       if (value.length < 6) {
                            //         return 'Password must be at least 6 characters';
                            //       }
                            //       return null;
                            //     },
                            //   ),
                            // ),

                            // Obx(
                            //   () => registerController.isLoading.value
                            //       ? CircularProgressIndicator(
                            //           color: Colors.white)
                            //       : SizedBox(
                            //           width: double.infinity,
                            //           child: ElevatedButton(
                            //             style: ElevatedButton.styleFrom(
                            //               backgroundColor: Colors.white,
                            //               padding: EdgeInsets.symmetric(
                            //                   vertical: 16),
                            //               shape: RoundedRectangleBorder(
                            //                 borderRadius:
                            //                     BorderRadius.circular(10),
                            //               ),
                            //             ),
                            //             onPressed: () async {
                            //               if (_formKey.currentState!
                            //                   .validate()) {
                            //                 await registerController.register();
                            //               }
                            //             },
                            //             child: Text(
                            //               'REGISTER',
                            //               style: TextStyle(
                            //                 color: Colors.deepPurpleAccent,
                            //                 fontSize: 18,
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //),
                            //SizedBox(height: 24),
                            // Obx(
                            //   () => registerController.isLoading.value
                            //       ? CircularProgressIndicator(
                            //           color: Colors.white)
                            //       : SizedBox(
                            //           width: double.infinity,
                            //           child: ElevatedButton(
                            //             style: ElevatedButton.styleFrom(
                            //               backgroundColor: Colors.white,
                            //               padding: EdgeInsets.symmetric(
                            //                   vertical: 16),
                            //               shape: RoundedRectangleBorder(
                            //                 borderRadius:
                            //                     BorderRadius.circular(10),
                            //               ),
                            //             ),
                            //             onPressed: () {
                            //               if (_formKey.currentState!
                            //                   .validate()) {
                            //                 registerController.register();
                            //               }
                            //             },
                            //             child: Text(
                            //               'REGISTER',
                            //               style: TextStyle(
                            //                 color: Colors.deepPurpleAccent,
                            //                 fontSize: 18,
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            // ),

                            // Obx(
                            //   () => registerController.isLoading.value
                            //       ? CircularProgressIndicator(
                            //           color: Colors.white)
                            //       : SizedBox(
                            //           width: double.infinity,
                            //           child: ElevatedButton(
                            //             style: ElevatedButton.styleFrom(
                            //               backgroundColor: Colors.white,
                            //               padding: EdgeInsets.symmetric(
                            //                   vertical: 16),
                            //               shape: RoundedRectangleBorder(
                            //                 borderRadius:
                            //                     BorderRadius.circular(10),
                            //               ),
                            //             ),
                            //             onPressed: () async {
                            //               if (_formKey.currentState!
                            //                   .validate()) {
                            //                 await registerController.register();
                            //               }
                            //             },
                            //             child: Text(
                            //               'REGISTER',
                            //               style: TextStyle(
                            //                 color: Colors.deepPurpleAccent,
                            //                 fontSize: 18,
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            // ),

                            TextFormField(
                              controller: registerController.userNameController,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter username';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: registerController.emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email';
                                }
                                if (!value.contains('@')) {
                                  return 'Enter valid email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            Obx(
                              () => TextFormField(
                                controller:
                                    registerController.passwordController,
                                obscureText:
                                    registerController.obscurePassword.value,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        registerController.obscurePassword.value
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                    onPressed: () => registerController
                                        .obscurePassword
                                        .toggle(),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password too short';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            ElevatedButton(
                              onPressed: () async {
                                // Validate returns true if form is valid
                                if (_formKey.currentState!.validate()) {
                                  // Show loading indicator
                                  registerController.isLoading.value = true;

                                  // Call registration
                                  final success = await registerController
                                      .registerAndSaveUser();

                                  // Hide loading indicator
                                  registerController.isLoading.value = false;

                                  if (success) {
                                    Get.back(); // Return to login screen
                                    Get.snackbar(
                                        'Success', 'Registration successful');
                                  } else {
                                    Get.snackbar(
                                        'Error', 'Registration failed');
                                  }
                                }
                              },
                              child: Text('REGISTER'),
                            ),

                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back(); // Return to login screen
                                  },
                                  child: Text(
                                    'Login',
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
                                    // Add your navigation to admin screen here
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
