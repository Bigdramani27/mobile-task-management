import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kowri/helpers/colors.dart';
import 'package:kowri/helpers/size.dart';
import 'package:kowri/widgets/custom_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool emptyName = false;
  bool emptyEmail = false;
  bool emptyPhone = false;
  bool emptyPhoneLength = false;
  bool emptyPassword = false;
  bool isEmpty = false;
  bool phoneExists = false;
  bool emailExists = false;
  bool registrationError = false;
  bool isLoading = false;
  bool passwordVisibility = true;
  String errorMessages = "";

  @override
  void initState() {
    super.initState();
    // Adding a listener to the TextEditingController
    fullnameController.addListener(_onFullNameTextChanged);
    phoneController.addListener(_onPhoneTextChanged);
    emailController.addListener(_onEmailTextChanged);
    passwordController.addListener(_onPasswordTextChanged);
  }

  // Function called when the text changes
  void _onFullNameTextChanged() {
    setState(() {
      emptyName = false;
    });
  }

  void _onPasswordTextChanged() {
    setState(() {
      emptyPassword = false;
    });
  }

  void _onPhoneTextChanged() {
    setState(() {
      emptyPhone = false;
      phoneExists = false;
    });
  }

  void _onEmailTextChanged() {
    setState(() {
      emptyEmail = false;
    });
  }

  @override
  void dispose() {
    // Remove the listener and dispose of the controller
    fullnameController.removeListener(_onFullNameTextChanged);
    fullnameController.dispose();
    phoneController.removeListener(_onPhoneTextChanged);
    phoneController.dispose();
    emailController.removeListener(_onEmailTextChanged);
    emailController.dispose();
    passwordController.removeListener(_onPasswordTextChanged);
    passwordController.dispose();
    super.dispose();
  }

  Future<String> createUserWithEmailAndPasswords() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      return "Account Successfully created!";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return "Email is not valid";
        case 'email-already-in-use':
          return "Email already exists";
        case 'weak-password':
          return "Password must be at least 8 characters";
        case 'too-many-requests':
          return "Too many attempts. Try again later.";
        default:
          return "Error: ${e.message}";
      }
    } catch (e) {
      return "An unknown error occurred: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Image.asset("images/logo.png"),
                        ),
                        const SizedBox(height: 20),
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
                              text: "QuickGuard",
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
                            text: "Sign up with your credentials and join the Kowri experience.",
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
                              title: 'Full Name',
                              hintText: 'eg. John Doe',
                              size: h3,
                              color: background,
                              weight: FontWeight.bold,
                              controller: fullnameController,
                              onTap: () {},
                              borderColor: !emptyName ? acrossLines : error,
                              borderRadius: 10,
                              containerPadding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              width: double.infinity,
                              prefix: FontAwesomeIcons.user,
                            ),
                            if (emptyName == true) const SizedBox(height: 10),
                            if (emptyName == true)
                              const CustomText(
                                text: "Enter Full Name",
                                color: error,
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              title: 'Phone number',
                              hintText: 'eg. 0548342821',
                              size: h3,
                              color: background,
                              weight: FontWeight.bold,
                              controller: phoneController,
                              onTap: () {},
                              borderColor: !emptyPhone ? acrossLines : error,
                              borderRadius: 10,
                              containerPadding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              width: double.infinity,
                              prefix: FontAwesomeIcons.phone,
                            ),
                            if (emptyPhone == true) const SizedBox(height: 10),
                            if (emptyPhone == true)
                              const CustomText(
                                text: "Enter Phone Number",
                                color: error,
                              ),
                            if (emptyPhoneLength == true)
                              const CustomText(
                                text: "Phone number is not complete",
                                color: error,
                              ),
                            if (phoneExists == true)
                              const CustomText(
                                text: "Phone number exists",
                                color: error,
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
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
                            if (emailExists == true)
                              const CustomText(
                                text: "Email already exists",
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
                        if (errorMessages == "Password must be at least 8 characters" || errorMessages == "Email is not valid" || errorMessages == "Email already in use" || errorMessages == "Your account is temporarily locked due to too many failed attempts. Try again shortly.") const SizedBox(height: 10),
                        if (errorMessages == "Password must be at least 8 characters" || errorMessages == "Email is not valid" || errorMessages == "Email already in use" || errorMessages == "Your account is temporarily locked due to too many failed attempts. Try again shortly")
                          Center(
                            child: CustomText(
                              text: errorMessages,
                              color: error,
                            ),
                          ),
                        const SizedBox(height: 20),
                        CustomButton(
                            text: "Sign Up",
                            isLoading: isLoading,
                            onTap: () async {
                              setState(() {
                                // Reset validation states
                                emptyName = fullnameController.text.isEmpty;
                                emptyPhone = phoneController.text.isEmpty;
                                emptyPhoneLength = phoneController.text.length != 10 && phoneController.text.isNotEmpty;
                                emptyEmail = emailController.text.isEmpty;
                                emptyPassword = passwordController.text.isEmpty;
                                phoneExists = false;
                                errorMessages = "";
                                registrationError = false;
                                isEmpty = emptyName || emptyPhone || emptyPhoneLength || emptyEmail || emptyPassword;
                              });

                              if (isEmpty) return;

                              setState(() => isLoading = true);

                              try {
                                // Check if phone number already exists in Firestore
                                final usersCollection = FirebaseFirestore.instance.collection("Users");
                                final querySnapshot = await usersCollection.where("phoneNumber", isEqualTo: phoneController.text).get();

                                if (querySnapshot.docs.isNotEmpty) {
                                  setState(() {
                                    phoneExists = true;
                                    isLoading = false;
                                  });
                                  return;
                                }
                                // Check if email already exists in Firestore
                                final querySnapshots = await usersCollection.where("email", isEqualTo: emailController.text).get();

                                if (querySnapshots.docs.isNotEmpty) {
                                  setState(() {
                                    emailExists = true;
                                    isLoading = false;
                                  });
                                  return;
                                }

                                // Create user with Firebase Auth
                                final result = await createUserWithEmailAndPasswords();

                                if (result == "Account Successfully created!") {
                                  final userId = FirebaseAuth.instance.currentUser!.uid;
                                  await usersCollection.doc(userId).set({
                                    "fullName": fullnameController.text,
                                    "phoneNumber": phoneController.text,
                                    "email": emailController.text,
                                    "dateCreated": FieldValue.serverTimestamp(),
                                  }, SetOptions(merge: true));

                                  await FirebaseAuth.instance.signOut();
                                  if (mounted) context.go("/completed_registration");
                                } else {
                                  setState(() {
                                    registrationError = true;
                                    errorMessages = result;
                                    isLoading = false;
                                  });
                                }
                              } catch (e) {
                                setState(() {
                                  errorMessages = "An unexpected error occurred.";
                                  registrationError = true;
                                  isLoading = false;
                                });
                                print("Unexpected error: $e");
                              }
                            }),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomText(text: "Already have an account?  "),
                            GestureDetector(
                              onTap: () {
                                context.go("/login");
                              },
                              child: const CustomText(
                                text: "Log in",
                                size: h4,
                                fontWeight: FontWeight.bold,
                                color: primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
