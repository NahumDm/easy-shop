import 'package:easy_shop/core/constants/app_constants.dart';
import 'package:easy_shop/features/auth/presentation/screens/login_screen.dart';
import 'package:easy_shop/features/auth/presentation/widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthServices();
  bool _isLoading = false;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final user = await _authService.registerWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _nameController.text.trim(),
        );

        if (user != null && mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                e.message ?? 'An error occurred during registration',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('An unexpected error occurred'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //ACCOUNT CREATION TEXT INSTRUCTION
                Text(
                  'Create Your Account',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Join ShopEasy today and explore amazing deals!',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),

                //Sign Up Form
                SizedBox(height: 30.0),
                TextFieldContainer(
                  size: size,
                  icon: Icon(Icons.person),
                  hint: "John Doe",
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 25.0),
                TextFieldContainer(
                  size: size,
                  icon: Icon(Icons.email),
                  hint: "you@example.com",
                  controller: _emailController,
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
                SizedBox(height: 25.0),
                TextFieldContainer(
                  size: size,
                  icon: Icon(Icons.password),
                  hint: "Create Strong Password",
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 35.0),

                //SIGN UP BUTTON
                SizedBox(
                  width: size.width * 0.86,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child:
                        _isLoading
                            ? CircularProgressIndicator(
                              color: AppConstants.backgroundColor,
                            )
                            : Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.backgroundColor,
                              ),
                            ),
                  ),
                ),

                SizedBox(height: 15.0),
                //TERMS AND POLICY
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    'By tapping create account, you accept our Terms of Services and Privacy Policy.',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 50.0),

                Text(
                  'Already have an account?',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.forgotPassword,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//SIGN UP TEXT FIELD FORM
class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    super.key,
    required this.hint,
    required this.icon,
    required this.size,
    this.controller,
    this.validator,
    this.obscureText = false,
  });

  final Size size;
  final Icon icon;
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: icon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
