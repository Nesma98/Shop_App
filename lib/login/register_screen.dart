import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:onboarding_project/components/TestFiled.dart';
import 'package:onboarding_project/components/defaultButton.dart';
import 'package:onboarding_project/login/login_Screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Register',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 15),
            defaultTextFormFiled(
              controller: nameController,
              prefixIcon: Icons.person_outline,
              type: TextInputType.text,
              label: 'Email Address',
              validate: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Your name';
                }
              },
            ),
            SizedBox(height: 15),
            defaultTextFormFiled(
              controller: emailController,
              SuffixData: Icons.visibility_outlined,
              type: TextInputType.emailAddress,
              label: 'Email Address',
              prefixIcon: Icons.email_outlined,
              validate: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Your Email';
                }
              },
            ),
            SizedBox(height: 15),
            defaultTextFormFiled(
              controller: passwordController,
              type: TextInputType.visiblePassword,
              label: 'Password ',
              prefixIcon: Icons.lock_outline,
              validate: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Your Password';
                }
              },
            ),
            SizedBox(height: 15),
            ConditionalBuilder(
              condition: true,
              builder: (context) =>
                  defaultButton(text: 'login', function: () {}, isUpper: true),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don/t have a account?'),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ));
                    },
                    child: Text('Login'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
