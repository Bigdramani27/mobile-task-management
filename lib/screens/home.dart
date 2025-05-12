import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kowri/helpers/size.dart';
import 'package:kowri/widgets/custom_widget.dart';
import '../helpers/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  String firstName = '';

  Future<void> getName() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("Users").doc(currentUser).get();
    setState(() {
      var name = snapshot.data()?['fullName'];
      firstName = name.split(" ")[0];
    });
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        title: CustomText(
          text: "Hello, $firstName!",
          size: h2,
          color: background,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push("/settings");
            },
            icon: const FaIcon(
              FontAwesomeIcons.cogs,
              size: 20,
              color: background,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "images/logo.png",
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomText(
                      text: "Manage Your Schedule",
                      size: emergency,
                      color: primary,
                      fontWeight: FontWeight.w900,
                      shadow: [
                        Shadow(
                          offset: const Offset(2.0, 2.0),
                          blurRadius: 3.0,
                          color: black.withOpacity(0.7),
                        ),
                        Shadow(
                          offset: const Offset(-2.0, -2.0),
                          blurRadius: 3.0,
                          color: background.withOpacity(0.4),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.push("/create-task");
                          },
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  "images/create.png",
                                  width: 120,
                                  height: 120,
                                ),
                              ),
                              const CustomText(
                                text: "Create Task",
                                size: h2,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.push("/view-tasks");
                          },
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  "images/track.jpg",
                                  width: 120,
                                  height: 120,
                                ),
                              ),
                              const CustomText(
                                text: "View Task",
                                size: h2,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push("/update-delete-task");
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              "images/task.jpg",
                              width: 120,
                              height: 120,
                            ),
                          ),
                          const CustomText(
                            text: "Update & Delete Task",
                            size: h2,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Align the chat button at the bottom right
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
              child: GestureDetector(
                onTap: () {
                  context.push("/chat-page");
                },
                child: Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.robot,
                      color: primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
