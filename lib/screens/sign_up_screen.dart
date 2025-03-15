import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:wanted/models/model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _selectBirthdate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _birthdateController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Logo of Wanted'),
                const SizedBox(height: 20),

                const Text(
                  "Create a Wanted Account",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: "Username",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Please enter a username" : null,
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _birthdateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Birthdate",
                          prefixIcon: const Icon(Icons.cake),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: _selectBirthdate,
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Please select your birthdate" : null,
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter an email";
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return "Invalid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a password";
                          }
                          if (value.length < 6) {
                            return "Password too short";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            final appStateManager = Provider.of<AppStateManager>(context, listen: false);
                              await appStateManager.loginUser(
                                _usernameController.text,
                                _emailController.text,
                                _passwordController.text,
                              );
                            // if (_formKey.currentState!.validate()) {
                            //   setState(() {
                            //     _isLoading = true;
                            //   });

                            //   final appStateManager = Provider.of<AppStateManager>(context, listen: false);
                            //   await appStateManager.loginUser(
                            //     _usernameController.text,
                            //     _emailController.text,
                            //     _passwordController.text,
                            //   );

                            //   setState(() {
                            //     _isLoading = false;
                            //   });

                            //   // if (appStateManager.isLoggedIn) {
                            //   //   GoRouter.of(context).go('/home');
                            //   // }
                            // }
                          },
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text("Create Account"),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const Text("Or sign up with"),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(icon: Icons.abc, onPressed: () {}),
                    const SizedBox(width: 20),
                    _buildSocialButton(icon: Icons.abc, onPressed: () {}),
                    const SizedBox(width: 20),
                    _buildSocialButton(icon: Icons.abc, onPressed: () {}),
                    const SizedBox(width: 20),
                    _buildSocialButton(icon: Icons.abc, onPressed: () {}),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () => GoRouter.of(context).go('/signin'),
                      child: const Text("Sign in"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({required IconData icon, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
        ),
        child: Icon(icon, size: 30, color: Colors.black),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:go_router/go_router.dart';
// import 'package:wanted/models/model.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {

//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _birthdateController = TextEditingController();
//   bool _isPasswordVisible = false;
//   bool _isLoading = false; // Ajout d'un indicateur de chargement

//     /// ✅ Sélectionner la date de naissance
//   Future<void> _selectBirthdate() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime(2000),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         _birthdateController.text =
//             "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
//       });
//     }
//   }
  
//     @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Logo of Wanted'),
//                 const SizedBox(height: 20),

//                 const Text(
//                   "Create a Wanted Account",
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 20),

//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         controller: _usernameController,
//                         decoration: const InputDecoration(
//                           labelText: "Username",
//                           prefixIcon: Icon(Icons.person),
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) =>
//                             value!.isEmpty ? "Please enter a username" : null,
//                       ),
//                       const SizedBox(height: 16),

//                       TextFormField(
//                         controller: _birthdateController,
//                         readOnly: true,
//                         decoration: InputDecoration(
//                           labelText: "Birthdate",
//                           prefixIcon: const Icon(Icons.cake),
//                           border: const OutlineInputBorder(),
//                           suffixIcon: IconButton(
//                             icon: const Icon(Icons.calendar_today),
//                             onPressed: _selectBirthdate,
//                           ),
//                         ),
//                         validator: (value) =>
//                             value!.isEmpty ? "Please select your birthdate" : null,
//                       ),
//                       const SizedBox(height: 16),

//                       TextFormField(
//                         controller: _emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: const InputDecoration(
//                           labelText: "Email",
//                           prefixIcon: Icon(Icons.email),
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please enter an email";
//                           }
//                           if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                               .hasMatch(value)) {
//                             return "Invalid email";
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16),

//                       TextFormField(
//                         controller: _passwordController,
//                         obscureText: !_isPasswordVisible,
//                         decoration: InputDecoration(
//                           labelText: "Password",
//                           prefixIcon: const Icon(Icons.lock),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _isPasswordVisible
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _isPasswordVisible = !_isPasswordVisible;
//                               });
//                             },
//                           ),
//                           border: const OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please enter a password";
//                           }
//                           if (value.length < 6) {
//                             return "Password too short";
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),

//                       SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: () {
                            
//                           },
//                           child: _isLoading
//                               ? const CircularProgressIndicator(
//                                   color: Colors.white)
//                               : const Text("Create Account"),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 const Text("Or sign up with"),
//                 const SizedBox(height: 10),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _buildSocialButton(icon: Icons.abc, onPressed: () {}),
//                     const SizedBox(width: 20),
//                     _buildSocialButton(icon: Icons.abc, onPressed: () {}),
//                     const SizedBox(width: 20),
//                     _buildSocialButton(icon: Icons.abc, onPressed: () {}),
//                     const SizedBox(width: 20),
//                     _buildSocialButton(icon: Icons.abc, onPressed: () {}),
//                   ],
//                 ),

//                 const SizedBox(height: 20),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("Already have an account?"),
//                     TextButton(
//                       onPressed: () => GoRouter.of(context).go('/signin'),
//                       child: const Text("Sign in"),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSocialButton({required IconData icon, required VoidCallback onPressed}) {
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         width: 50,
//         height: 50,
//         decoration: const BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.white,
//           boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
//         ),
//         child: Icon(icon, size: 30, color: Colors.black),
//       ),
//     );
//   }
// }
