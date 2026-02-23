// import 'package:ecollege/main.dart';
// import 'package:ecollege/models/student.dart';
// import 'package:ecollege/providers/adminpro/adminpro.dart';
// import 'package:ecollege/providers/basicpro.dart';
// import 'package:ecollege/screens/adminpanel/screens/timetable/wids/dropentry.dart';
// import 'package:ecollege/screens/adminpanel/screens/timetable/wids/dropentrystrng.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:provider/provider.dart'; // Update with your correct path

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({Key? key}) : super(key: key);

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();


//   @override
//   Widget build(BuildContext context) {
//      final s=context.read<adminpro>();
// final a=context.read<Basicpro>();

//   void _registerStudent() async {
//     if (_formKey.currentState!.validate()) {
//       final student = Student(
//         name: a.nameController.text.trim(),
//         rollNo: a.rollNoController.text.trim(),
//         email: a.emailController.text.trim(),
//         password: a.passwordController.text.trim(),
//         phone: a.phoneController.text.trim(),
//         batch: a.sid,
//         className: a.sna
//       );

//      a.registerStudent();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Student Registered Successfully')),
//       );

//       // Optionally, clear the form
//       _formKey.currentState!.reset();
//       a.nameController.clear();
//       a.registernum.clear();
//       a.rollNoController.clear();
//       a.emailController.clear();
//       a.passwordController.clear();
//       a.phoneController.clear();
//     }
//     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (a)=>homemain()), (Route<dynamic> route) => false);
//   }
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Register Student'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               _buildTextField(a.nameController, 'Name', TextInputType.name),
//              _buildTextField(a.registernum, "Register number", TextInputType.text),
//               _buildTextField(a.rollNoController, 'Roll No', TextInputType.text),
//               _buildTextField(a.emailController, 'Email', TextInputType.emailAddress,
//                   validator: _validateEmail),
//               _buildTextField(a.passwordController, 'Password', TextInputType.visiblePassword,
//                   isPassword: true),
//               _buildTextField(a.phoneController, 'Phone', TextInputType.phone),
//              dropentrystrng(context.watch<adminpro>().classNames, "Subjects",(d){a.sna=d.toString();}),
//            dropentrystrng(context.watch<adminpro>().years.map((a)=>a.toString()).toList(), "Batch", (b){a.sid=b.toString();})
//               ,const SizedBox(height: 20),

//               ElevatedButton(
//                 onPressed: _registerStudent,
//                 child: const Text('Register'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//     TextEditingController controller,
//     String label,
//     TextInputType type, {
//     String? Function(String?)? validator,
//     bool isPassword = false,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: type,
//         obscureText: isPassword,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(),
//         ),
//         validator: validator ?? (value) {
//           if (value == null || value.isEmpty) {
//             return '$label is required';
//           }
//           return null;
//         },
//       ),
//     );
//   }

//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) return 'Email is required';
//     if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return 'Enter a valid email';
//     return null;
//   }
// }
import 'package:ecollege/screens/login/loginscrn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecollege/providers/adminpro/adminpro.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/screens/adminpanel/screens/timetable/wids/dropentrystrng.dart';
import 'package:ecollege/models/student.dart';
import 'package:ecollege/main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isPasswordHidden = true;

  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

    _fade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slide = Tween<Offset>(begin: Offset(0, 0.2), end: Offset.zero).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.read<adminpro>();
    final a = context.read<Basicpro>();

    void _registerStudent() async {
      if (!_formKey.currentState!.validate()) return;

      setState(() => isLoading = true);

       a.registerStudent();

      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student Registered Successfully')),
      );

      _formKey.currentState!.reset();
      a.nameController.clear();
      a.registernum.clear();
      a.rollNoController.clear();
      a.emailController.clear();
      a.passwordController.clear();
      a.phoneController.clear();

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => homemain()),
          (route) => false);
    }

    return Scaffold(
      body: Container(
       
        decoration: BoxDecoration(
         gradient: LinearGradient(
                        colors: [Colors.black, Colors.deepPurple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      )
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Icon(Icons.person_add,
                            size: 70, color: Color(0xff185a9d)),

                        SizedBox(height: 15),

                        Text(
                          "Create Account",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),

                        SizedBox(height: 25),

                        _buildTextField(a.nameController, "Name", Icons.person),
                        _buildTextField(a.registernum, "Register Number",
                            Icons.confirmation_number),
                        _buildTextField(
                            a.rollNoController, "Roll No", Icons.badge),
                        _buildTextField(a.emailController, "Email",
                            Icons.email, validator: _validateEmail),
                        _buildTextField(
                          a.passwordController,
                          "Password",
                          Icons.lock,
                          isPassword: true,
                        ),
                        _buildTextField(
                            a.phoneController, "Phone", Icons.phone),

                        SizedBox(height: 15),

                        dropentrystrng(
                            context.watch<adminpro>().classNames,
                            "Class",
                            (d) => a.sna = d.toString()),

                        SizedBox(height: 10),

                        dropentrystrng(
                            context
                                .watch<adminpro>()
                                .years
                                .map((e) => e.toString())
                                .toList(),
                            "Batch",
                            (b) => a.sid = b.toString()),

                        SizedBox(height: 25),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _registerStudent,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff185a9d),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white)
                                : Text(
                                    "Register",
                                    style: TextStyle(color: Colors.white,fontSize: 18),
                                  ),
                          ),
                        ),
                         TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => LoginScreen()),
                            );
                          },
                          child: Text(
                            "Have an existing account? Sign In",
                            style:
                                TextStyle(color: Color(0xff667eea)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    String? Function(String?)? validator,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? isPasswordHidden : false,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(isPasswordHidden
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                )
              : null,
          labelText: label,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return "$label is required";
              }
              return null;
            },
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value))
      return "Enter a valid email";
    return null;
  }
}