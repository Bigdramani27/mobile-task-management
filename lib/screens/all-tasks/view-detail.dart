import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kowri/helpers/colors.dart';
import 'package:kowri/helpers/size.dart';
import 'package:kowri/widgets/custom_appbar.dart';
import 'package:kowri/widgets/custom_snackbar.dart';
import 'package:kowri/widgets/custom_widget.dart';

class ViewDetail extends StatefulWidget {
  final String taskId;
  const ViewDetail({super.key, required this.taskId});

  @override
  State<ViewDetail> createState() => _ViewDetailState();
}

class _ViewDetailState extends State<ViewDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        leading: CustomBackButton(
          onTap: () {
            context.go("/view-tasks");
          },
        ),
        title: const CustomText(
          text: "View Task",
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
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          children: [
            FutureBuilder(
                future: FirebaseFirestore.instance.collection("Tasks").doc(widget.taskId).get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: primary),
                    );
                  }

                  var data = snapshot.data;
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(text: "Title: ", fontWeight: FontWeight.bold, size: h2),
                          Expanded(child: CustomText(text: data!['title'], size: h2)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(text: "Description: ", fontWeight: FontWeight.bold, size: h2),
                          Expanded(child: CustomText(text: data!['description'], size: h2)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const CustomText(text: "Date: ", fontWeight: FontWeight.bold, size: h2),
                          CustomText(
                            text: data!['date'],
                            size: h2,
                            color: primary,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const CustomText(text: "Status: ", fontWeight: FontWeight.bold, size: h2),
                          CustomText(
                            text: data!['status'],
                            size: h2,
                            color: error,
                          ),
                        ],
                      ),
                    ],
                  );
                }),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    context.push("/edit-task/${widget.taskId}");
                  },
                  child: const Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.pencil,
                        color: primary,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: "Edit",
                        color: primary,
                        size: h2,
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await FirebaseFirestore.instance.collection("Tasks").doc(widget.taskId).delete().then((_) {
                      context.go("/view-tasks");
                      successShowRoundedSnackBar(context, 'Task Deleted Successfully');
                    });
                  },
                  child: const Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.trash,
                        color: error,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: "Delete",
                        color: error,
                        size: h2,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
