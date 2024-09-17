import 'package:biocountermobile/core/routes.dart';
import 'package:biocountermobile/core/styles.dart';
import 'package:biocountermobile/core/utils/form_validators.dart';
import 'package:biocountermobile/features/auth/presentation/widgets/app_loader.dart';
import 'package:biocountermobile/features/auth/presentation/widgets/default_button.dart';
import 'package:biocountermobile/features/auth/presentation/widgets/default_textfield.dart';
import 'package:biocountermobile/features/auth/providers/auth_provider.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:biocountermobile/core/utils/constants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obsecure = true;
  bool obsecureConfirm = true;
  bool isChecked = false;

  bool isSigningUp = false;

  Future registerFnc() async {
    if (isSigningUp || !signupFormKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isSigningUp = true;
    });
    try {
      await authProvider.register(
        email: emailController.text,
        name: nameController.text,
        password: passwordController.text,
      );
    } catch (e) {
      if (kDebugMode) {
        print("error occurred while Sign up $e");
      }
    } finally {
      setState(() {
        isSigningUp = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DoubleBackToCloseApp(
          snackBar: SnackBar(
            content: Text(
              'Tap back again to exit.',
              style: Styles.custom16(
                context,
                fontWeight: FontWeight.w400,
                fontColor: Colors.white,
              ),
            ),
            backgroundColor: Styles.primaryColor,
          ),
          child: Consumer<AuthProvider>(
            builder: (context, value, child) {
              if (isSigningUp == true) {
                return const AppLoader();
              } else {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context) * 0.0384,
                  ),
                  width: screenWidth(context),
                  height: double.infinity,
                  child: Form(
                    key: signupFormKey,
                    child: ListView(
                      children: [
                        SizedBox(
                          height: screenHeight(context) * 0.032,
                        ),
                        Center(
                          child: SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Image.asset(
                              "assets/images/logo1.png",
                              fit: BoxFit.contain,
                              height: screenHeight(context) * 0.4,
                            ),
                          ),
                        ),
                        Text(
                          "Let's get started",
                          style: Styles.heading1(
                            context,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight(context) * 0.01,
                        ),
                        Text(
                          "Create a new account to continue.",
                          style: Styles.normal(
                            context,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: screenHeight(context) * 0.012),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: DefaultTextField(
                                label: 'Your Name',
                                hint: 'John',
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                validator: (value) =>
                                    FormValidators().nameValidator(
                                  value!,
                                ),
                                prefixIcon: const Icon(
                                  Icons.perm_identity,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight(context) * 0.03),
                        DefaultTextField(
                          label: 'Email Address',
                          hint: 'your@email.com',
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) => FormValidators().emailValidator(
                            value!,
                          ),
                          prefixIcon: const Icon(
                            Icons.mail_outline,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: screenHeight(context) * 0.01),
                        DefaultTextField(
                          prefixIcon: const Icon(
                            Icons.lock_outlined,
                            color: Colors.grey,
                          ),
                          obscureText: obsecure,
                          label: 'Password',
                          hint: 'Password',
                          onVisibilityChange: () {
                            setState(
                              () {
                                obsecure = !obsecure;
                              },
                            );
                          },
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          controller: passwordController,
                          validator: (value) =>
                              FormValidators().passwordValidator(
                            value!,
                          ),
                        ),
                        SizedBox(height: screenHeight(context) * 0.02),
                        DefaultButton(
                          onPressed: registerFnc,
                          btnColor: Styles.primaryColor,
                          borderColor: Styles.primaryColor,
                          child: Text(
                            "Sign up",
                            style: Styles.heading3(
                              context,
                              fontColor: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight(context) * 0.03),
                        GestureDetector(
                          onTap: () {
                            context.go('/');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: Styles.custom16(
                                  context,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: screenWidth(context) * 0.01,
                              ),
                              Text(
                                'Sign in',
                                style: Styles.custom16(
                                  context,
                                  fontWeight: FontWeight.w600,
                                  fontColor: Styles.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight(context) * 0.02),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
