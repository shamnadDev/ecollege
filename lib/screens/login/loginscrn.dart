// import 'package:ecollege/main.dart';
// import 'package:ecollege/providers/basicpro.dart';
// import 'package:ecollege/screens/adminpanel/adminhome.dart';
// import 'package:ecollege/screens/home/home.dart';
// import 'package:ecollege/screens/login/studentreg.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// class LoginScreen extends StatefulWidget {
//   @override
//   LoginScreenState createState() => LoginScreenState();
// }

// class LoginScreenState extends State<LoginScreen> {
//   @override
//   void dispose() {
//   final a=context.read<Basicpro>();
//   a.lgnemail.clear();
//   a.lgnpass.clear();
//     // TODO: implement dispose
//     super.dispose();
//   }
//   final formKey = GlobalKey<FormState>();


//   @override
//   Widget build(BuildContext context) {
//   //     void login() {
//   //   if (formKey.currentState!.validate()) {
//   //     String email = k.lgnemail.text;
//   //     String password = k.lgnpass.text;
//   //     print('Logging in with $email and $password');


//   //     showDialog(
//   //       context: context,
//   //       builder: (context) => AlertDialog(
//   //         title: Text("Login Successful"),
//   //         content: Text("Welcome, $email!"),
//   //       ),
//   //     );
     
//   //   }
//   // }
  
//     final a=context.read<Basicpro>();
//     a.loginstd();
//     print(a.k);
//     return Scaffold(
//       appBar: AppBar(automaticallyImplyLeading: false
//          ,
//         title: Text('Login')),
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: [
//               // Email
//               _buildTextField(a.lgnemail, "Email", TextInputType.text),
//               SizedBox(height: 16),
//               // Password
//              _buildTextField(a.lgnpass, "Password", TextInputType.text)
//              , SizedBox(height: 32),
//               // Login Button
//               ElevatedButton(
//                 onPressed: ()async{
//       a.loginstd();
//       print(a.k);
//       Future.delayed(Duration(seconds: 2), () {
//         print(a.k);
//   if(a.k==1){
//         Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context)=>homemain()), (Route<dynamic> route) => false);
//       }else if(a.k==2){
//          Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context)=>adminhome()), (Route<dynamic> route) => false);
//       }
// });
     
      
//                 },
//                 child: Text('Login'),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                 ),
//               ),
          
//           Padding(padding: EdgeInsets.all(10),
//           child: InkWell(
//             onTap: (){
//               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RegisterScreen()));
//             }
//             ,
//             child: Text("i don't have an account " ,style: TextStyle(color: Colors.blue),)),
//           )  ],
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
// }
import 'package:ecollege/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecollege/providers/basicpro.dart';
import 'package:ecollege/screens/adminpanel/adminhome.dart';
import 'package:ecollege/screens/home/home.dart';
import 'package:ecollege/screens/login/studentreg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isPasswordHidden = true;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _buttonScale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _buttonScale = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    final a = context.read<Basicpro>();
    a.lgnemail.clear();
    a.lgnpass.clear();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final a = context.read<Basicpro>();
    final b = context.watch<Basicpro>();

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
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  padding: EdgeInsets.all(25),
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
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        /// Animated Icon
                        ScaleTransition(
                          scale: _buttonScale,
                          child: Icon(Icons.school,
                              size: 75, color: Color(0xff667eea)),
                        ),

                        SizedBox(height: 15),

                        Text(
                          "Welcome Back",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),

                        SizedBox(height: 5),

                        Text(
                          "Login to continue",
                          style: TextStyle(color: Colors.grey[600]),
                        ),

                        SizedBox(height: 30),

                        _buildTextField(
                          controller: a.lgnemail,
                          label: "Email",
                          icon: Icons.email,
                        ),

                        SizedBox(height: 20),

                        _buildTextField(
                          controller: a.lgnpass,
                          label: "Password",
                          icon: Icons.lock,
                          isPassword: true,
                        ),

                        SizedBox(height: 30),

                        /// Animated Login Button
                        ScaleTransition(
                          scale: _buttonScale,
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () async {
                                      if (!formKey.currentState!.validate()) return;

                                      setState(() => isLoading = true);

                                      a.loginstd();
                                        Future.delayed(Duration(seconds: 1)).then((a){ 
                                         
                                             if (b.k == 1) {
                                           Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (_) => homemain()),
                                          (route) => false,
                                        );
                                      } else if (b.k == 2) {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (_) => adminhome()),
                                          (route) => false,
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Invalid credentials")),
                                        );
                                      }
                                       setState(() => isLoading = false);
                                        });
                                     

                                     
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff667eea),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white)
                                  : Text(
                                      "Login",
                                      style: TextStyle(color: Colors.white,fontSize: 18),
                                    ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        TextButton(
                          onPressed: () {
                           showRegisterDialog(context);
                          },
                          child: Text(
                            "Forget password",
                            style:
                                TextStyle(color: Color(0xff667eea)),
                          ),
                        ),SizedBox(height: 10),
                          TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => RegisterScreen()),
                            );
                          },
                          child: Text(
                            "Don't have an account? Register",
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
void showRegisterDialog(BuildContext context) {
  final TextEditingController regController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text(
          "Enter Details",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: regController,
              decoration: const InputDecoration(
                labelText: "Register Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      "An email was sent to your email address"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextFormField(
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$label is required";
        }
        return null;
      },
    );
  }
}