import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtStudentID = TextEditingController();
  final TextEditingController txtPass = TextEditingController();
  final TextEditingController txtConfirmPass = TextEditingController();

  String? _gender; // Gender selection
  String? _selectedLevel; // Level selection

  bool validateFCIEmail(String email) {
    final regex = RegExp(r'^[0-9]+@stud\.fci-cu\.edu\.eg$');
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              // Image.asset(
              //   'imges/imgsignup.jpeg', // Path to your image
              //   height: 90, // Adjust the height
              //   width: 150, // Adjust the width
              //   fit: BoxFit.cover, // Adjust how the image fits
              // ),

              const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30)),
              const SizedBox(height: 20),
              const Text('Create your account.', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
              const SizedBox(height: 20),

              // Name
              TextFormField(
                controller: txtName,
                decoration: const InputDecoration(hintText: 'Username',
                prefixIcon: Icon(Icons.person),),
                validator: (value) => value == null || value.isEmpty ? 'This is required' : null,
              ),
              const SizedBox(height: 15),

              // Email
              TextFormField(
                controller: txtEmail,
                decoration: const InputDecoration(labelText: "Email",prefixIcon: Icon(Icons.email),),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Email is required";
                  if (!validateFCIEmail(value)) return "Invalid FCI email format";
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Student ID
              TextFormField(
                controller: txtStudentID,
                decoration: const InputDecoration(labelText: "Student ID",prefixIcon: Icon(Icons.badge)),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Student ID is required";
                  if (!txtEmail.text.startsWith(value)) {
                    return "Student ID must match email";
                  }
                  return null;
                },
              ),


              // const SizedBox(height: 5), // Adds space before the line

              const SizedBox(height: 15),
              // Level Dropdown (Optional)
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Level (Optional)",prefixIcon: Icon(Icons.school),),
                items: ["1", "2", "3", "4"]
                    .map((level) => DropdownMenuItem(value: level, child: Text("Level $level")))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLevel = value;
                  });
                },
              ),
              const SizedBox(height: 15),

              // Password
              TextFormField(
                controller: txtPass,

                decoration: const InputDecoration(hintText: 'Password',prefixIcon: Icon(Icons.lock),),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 8 || !RegExp(r'\d').hasMatch(value)) {
                    return "Password must be at least 8 characters with a number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Confirm Password
              TextFormField(
                controller: txtConfirmPass,
                decoration: const InputDecoration(labelText: "Confirm Password",prefixIcon: Icon(Icons.lock_outline),),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 8) return "Confirm Password must be at least 8 characters";
                  if (value != txtPass.text) return "Passwords do not match";
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Gender Selection
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 13),
                      Icon(Icons.people,  color: Colors.grey,),
                      const SizedBox(width: 10),
                      const Text("Gender:"),
                    ],
                  ),

                  Column(
                    children: [
                      Row(
                        children: [
                          // const SizedBox(width: 20),
                          Radio<String>(
                            value: "Male",
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                          ),
                          const Text("Male"),
                        ],
                      ),
                      Row(

                        children: [
                          // const SizedBox(width: 20),
                          Radio<String>(
                            value: "Female",
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                          ),
                          const Text("Female"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),


              Container(
                height: 0.5, // Line thickness
                width: double.infinity, // Full width
                color: Colors.black, // Line color
              ),
              const SizedBox(height: 30),

              // Signup Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Signup Success")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Signup Failed")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  minimumSize: const Size(300, 60),
                ),
                child: const Text("SignUp",style: TextStyle(fontSize: 25),),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
