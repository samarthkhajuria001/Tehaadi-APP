import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tehaadi/constants/colors.dart';
import 'package:tehaadi/main.dart';
import 'package:tehaadi/utils/utils.dart';

import '../services/authServices/firebaseAuth_provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: MediaQuery.of(context).size.height * .25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .8,
                child: Image.asset('assets/tehaadi_logo.png'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .25,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                        onPressed: () async {
                          String res =
                              await FirebaseProvider().signInwithGoogle();
                          if (res == 'success') {
                            if (mounted) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  homeScreen, (route) => false);
                              showSnackBar(context, 'success');
                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(
                                BoxIcons.bxl_google,
                                color: Colors.green,
                                size: 34,
                              ),
                            ),
                            Text(
                              'Signin with google',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.green),
                            ),
                          ],
                        ))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do not have an account',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            signUpScreen, (route) => false);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
