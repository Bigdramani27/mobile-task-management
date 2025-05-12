import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kowri/helpers/colors.dart';
import 'package:kowri/helpers/size.dart';
import 'package:kowri/widgets/custom_appbar.dart';
import 'package:kowri/widgets/custom_widget.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        leading: CustomBackButton(
          onTap: () {
            context.pop();
          },
        ),
        title: const CustomText(
          text: "Settings",
          size: h2,
          color: background,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          children: [
            CustomText(
              text: "Profile Settings",
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
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                  future: FirebaseFirestore.instance.collection("Users").doc(currentUser).get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primary,
                        ),
                      );
                    }
                    var data = snapshot.data;
                    return Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: "Full Name",
                              size: h2,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: acrossLines),
                              ),
                              child: CustomText(
                                text: data!['fullName'],
                                fontWeight: FontWeight.w500,
                                size: 18,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: "Email",
                              size: h2,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: acrossLines),
                              ),
                              child: CustomText(
                                text: data!['email'],
                                fontWeight: FontWeight.w500,
                                size: 18,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: "Phone Number",
                              size: h2,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: acrossLines),
                              ),
                              child: CustomText(
                                text: data!['phoneNumber'],
                                fontWeight: FontWeight.w500,
                                size: 18,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  }),
            ),
            const Spacer(),
            GestureDetector(
              onTap: (){
                FirebaseAuth.instance.signOut().then((_){
                context.go("/login");
                });
              },
              child: const Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.signOut,
                    color: error,
                    size: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomText(
                    text: "Log out",
                    fontWeight: FontWeight.w500,
                    size: h1,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
