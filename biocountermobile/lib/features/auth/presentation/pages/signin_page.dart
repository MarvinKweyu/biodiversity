import 'package:biocountermobile/core/styles.dart';
import 'package:biocountermobile/core/utils/constants.dart';
import 'package:biocountermobile/core/utils/form_validators.dart';
import 'package:biocountermobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:biocountermobile/features/auth/presentation/widgets/default_button.dart';
import 'package:biocountermobile/features/auth/presentation/widgets/default_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          // navigate to the home page
          Navigator.of(context).pushReplacementNamed('/home');
        }

        if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid email or password'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
          body: Center(
              child: isSmallScreen
                  ? const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _Logo(),
                        _FormContent(),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.all(32.0),
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: const Row(
                        children: [
                          Expanded(child: _Logo()),
                          Expanded(
                            child: Center(child: _FormContent()),
                          ),
                        ],
                      ),
                    ))),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // FlutterLogo(size: isSmallScreen ? 100 : 200),
        Center(
          child: SizedBox(
            height: isSmallScreen ? 100 : 200,
            width: double.infinity,
            child: Image.asset(
              "assets/images/logo1.png",
              fit: BoxFit.contain,
              height: screenHeight(context) * 0.4,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Biodiversity!",
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.headlineSmall
                : Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent();

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextField(
              label: 'Email Address',
              hint: 'your@email.com',
              controller: email,
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
            _gap(),
            DefaultTextField(
              prefixIcon: const Icon(
                Icons.lock_outlined,
                color: Colors.grey,
              ),
              obscureText: !_isPasswordVisible,
              label: 'Password',
              hint: 'Password',
              onVisibilityChange: () {
                setState(
                  () {
                    _isPasswordVisible = !_isPasswordVisible;
                  },
                );
              },
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              controller: password,
              validator: (value) => FormValidators().passwordValidator(
                value!,
              ),
            ),
            _gap(),
            GestureDetector(
              onTap: () {
                context.go('/$signUpScreen');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Signup instead?",
                    style: Styles.custom16(
                      context,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth(context) * 0.01,
                  ),
                  Text(
                    'Sign up',
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
            DefaultButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  /// do something
                  /// call the bloc to authenticate this user
                  BlocProvider.of<AuthBloc>(context).add(
                      SignInEvent(email: email.text, password: password.text));
                }
              },
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
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
