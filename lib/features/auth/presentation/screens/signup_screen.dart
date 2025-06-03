import 'package:easy_shop/core/constants/app_constants.dart';
import 'package:easy_shop/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
              ),
              SizedBox(height: 25.0),
              TextFieldContainer(
                size: size,
                icon: Icon(Icons.email),
                hint: "you@example.com",
              ),
              SizedBox(height: 25.0),
              TextFieldContainer(
                size: size,
                icon: Icon(Icons.password),
                hint: "Create Strong Password",
              ),
              SizedBox(height: 35.0),

              //SIGN UP BUTTON
              SizedBox(
                width: size.width * 0.86,
                height: 50.0,
                child: Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.backgroundColor,
                      ),
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
  });

  final Size size;
  final Icon icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
      child: TextField(
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
