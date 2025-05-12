import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kowri/helpers/colors.dart';
import 'package:kowri/helpers/size.dart';
import 'package:kowri/widgets/custom_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool emptyEmail = false;
  bool emptyPassword = false;
  bool isEmpty = false;
  bool userNotExisting = false;
  bool isLoading = false;
  bool passwordVisibility = true;
  String loginErrorMessage = "";
  @override
  void initState() {
    super.initState();
    // Adding a listener to the TextEditingController
    emailController.addListener(_onEmailTextChanged);
    passwordController.addListener(_onPasswordTextChanged);
  }

  void _onEmailTextChanged() {
    setState(() {
      emptyEmail = false;
      userNotExisting = false;
    });
  }

  void _onPasswordTextChanged() {
    setState(() {
      emptyPassword = false;
      userNotExisting = false;
    });
  }

  @override
  void dispose() {
    // Remove the listener and dispose of the controller
    emailController.removeListener(_onEmailTextChanged);
    emailController.dispose();
    passwordController.removeListener(_onPasswordTextChanged);
    passwordController.dispose();
    super.dispose();
  }

  Future<String> signInWithEmailAndPasswords() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      return "Login successful";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return "Email is not valid";
        case 'invalid-credential':
          return "Incorrect Email or Password";
        case 'too-many-requests':
          return "Your account is temporarily locked due to too many failed attempts. Try again shortly";
        default:
          return "Error: ${e.message}";
      }
    } catch (e) {
      return "An unexpected error occurred: $e";
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Image.asset(
                            "images/logo.png",
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Welcome to ",
                              fontWeight: FontWeight.w900,
                              size: header,
                              color: primary,
                            ),
                            CustomText(
                              text: "Kowri",
                              fontWeight: FontWeight.w900,
                              size: header,
                              color: black,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: CustomText(
                            text: "Join the Kowri experience by logging in to your account, or create a new one to get started. ",
                            size: h3,
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              title: 'Email',
                              hintText: 'eg. a.dramani96@gmail.com',
                              size: h3,
                              color: background,
                              weight: FontWeight.bold,
                              controller: emailController,
                              onTap: () {},
                              borderColor: !emptyEmail ? acrossLines : error,
                              borderRadius: 10,
                              containerPadding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              width: double.infinity,
                              prefix: FontAwesomeIcons.envelope,
                            ),
                            if (emptyEmail == true) const SizedBox(height: 10),
                            if (emptyEmail == true)
                              const CustomText(
                                text: "Enter your email",
                                color: error,
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PasswordCustomTextField(
                              title: 'Password',
                              hintText: '*******',
                              size: h3,
                              color: background,
                              weight: FontWeight.bold,
                              controller: passwordController,
                              onTap: () {},
                              borderColor: !emptyEmail ? acrossLines : error,
                              borderRadius: 10,
                              containerPadding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              width: double.infinity,
                              prefix: FontAwesomeIcons.lock,
                              obscureText: passwordVisibility,
                              suffix: passwordVisibility ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                              iconOnTap: () {
                                setState(() {
                                  passwordVisibility = !passwordVisibility;
                                });
                              },
                            ),
                            if (emptyPassword == true) const SizedBox(height: 10),
                            if (emptyPassword == true)
                              const CustomText(
                                text: "Enter your password",
                                color: error,
                              ),
                          ],
                        ),
                        if (userNotExisting == true) const SizedBox(height: 10),
                        if (userNotExisting == true)
                          Center(
                            child: CustomText(
                              text: loginErrorMessage,
                              color: error,
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                            text: "Login",
                            isLoading: isLoading,
                            onTap: () async {
                              setState(() {
                                emptyEmail = emailController.text.isEmpty;
                                emptyPassword = passwordController.text.isEmpty;
                                userNotExisting = false;
                                loginErrorMessage = "";
                                isEmpty = emptyEmail || emptyPassword;
                              });

                              if (isEmpty) return;

                              setState(() => isLoading = true);

                              final result = await signInWithEmailAndPasswords();

                              if (result == "Login successful") {
                                if (mounted) context.go("/home");
                              } else {
                                setState(() {
                                  loginErrorMessage = result;
                                  userNotExisting = true;
                                  isLoading = false;
                                });
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        TransparentCustomButton(
                          text: "Sign Up",
                          onTap: () {
                            context.push("/register");
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomText(
                              text: "Already have an account?  ",
                              fontWeight: FontWeight.bold,
                            ),
                            GestureDetector(
                                onTap: () {
                                  context.go("/service_login");
                                },
                                child: const CustomText(
                                  text: "Click here to Log in",
                                  size: h4,
                                  fontWeight: FontWeight.bold,
                                  color: primary,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
