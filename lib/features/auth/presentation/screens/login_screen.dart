import 'package:easy_shop/core/constants/app_constants.dart';
import 'package:easy_shop/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppConstants.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //WELCOME TEXT DISPLAY
            Text(
              'Welcome Back!',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.1),
            //EMAIL AND PASSWORD DISPLAY
            TextFieldContainer(
              size: size,
              hint: "Enter Email",
              icon: Icon(Icons.email, color: AppConstants.buttonColor),
            ),
            SizedBox(height: 20.0),
            TextFieldContainer(
              size: size,
              hint: "Enter Password",
              icon: Icon(Icons.password, color: AppConstants.buttonColor),
            ),

            //FORGOT PASSWORD OPTION
            const SizedBox(height: 15.0),
            Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: AppConstants.forgotPassword,
              ),
            ),

            const SizedBox(height: 30.0),
            //LOGIN BUTTON
            SizedBox(
              height: 60.0,
              width: size.width * 0.87,
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
                    'Log In',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppConstants.backgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 25.0),
            //SIGN UP OR REGISTRATION OPTION
            Text(
              'Don\'t have an account?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(
              height: 35.0,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUp()),
                  );
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.forgotPassword,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//TEXT FIELD CONTAINER PROPERTIES
class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    super.key,
    required this.size,
    required this.icon,
    required this.hint,
  });

  final Size size;
  final String hint;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.07,
        vertical: size.height * 0.01,
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hint,
          hintStyle: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w300,
            color: AppConstants.textColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),
    );
  }
}
