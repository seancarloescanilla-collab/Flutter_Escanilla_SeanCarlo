import 'package:flutter/material.dart';

void main() {
  runApp(const StudentProfileApp());
}

class StudentProfileApp extends StatelessWidget {
  const StudentProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Profile Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const StudentProfileForm(),
    );
  }
}

class StudentProfileForm extends StatefulWidget {
  const StudentProfileForm({super.key});

  @override
  State<StudentProfileForm> createState() => _StudentProfileFormState();
}

class _StudentProfileFormState extends State<StudentProfileForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();

  String? gender;

  bool submitted = false;

  void submitForm() {
    if (_formKey.currentState!.validate() && gender != null) {
      setState(() {
        submitted = true;
      });
    } else if (gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your gender.'),
        ),
      );
    }
  }

  void clearForm() {
    nameController.clear();
    ageController.clear();
    addressController.clear();
    contactController.clear();
    emailController.clear();

    setState(() {
      gender = null;
      submitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile Form'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              const Text(
                'Student Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              // FULL NAME
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Full Name is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // AGE
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  hintText: 'Enter your age',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Age is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // GENDER
              DropdownButtonFormField<String>(
                value: gender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.people),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Male',
                    child: Text('Male'),
                  ),
                  DropdownMenuItem(
                    value: 'Female',
                    child: Text('Female'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Gender is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // ADDRESS
              TextFormField(
                controller: addressController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  hintText: 'Enter your address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Address is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // CONTACT NUMBER
              TextFormField(
                controller: contactController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Contact Number',
                  hintText: 'Enter your contact number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Contact Number is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // EMAIL
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }

                  if (!value.contains('@')) {
                    return 'Enter a valid email';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 25),

              // SUBMIT BUTTON
              ElevatedButton.icon(
                onPressed: submitForm,
                icon: const Icon(Icons.send),
                label: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),

              const SizedBox(height: 10),

              // CLEAR BUTTON
              OutlinedButton.icon(
                onPressed: clearForm,
                icon: const Icon(Icons.clear),
                label: const Text('Clear / Reset'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),

              const SizedBox(height: 25),

              // DISPLAY INFORMATION
              if (submitted)
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Student Information',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Divider(),

                        Text(
                          'Full Name: ${nameController.text}',
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Age: ${ageController.text}',
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Gender: $gender',
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Address: ${addressController.text}',
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Contact Number: ${contactController.text}',
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Email: ${emailController.text}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}