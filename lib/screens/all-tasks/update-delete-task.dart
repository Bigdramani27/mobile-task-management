import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kowri/helpers/colors.dart';
import 'package:kowri/helpers/size.dart';
import 'package:kowri/widgets/custom_appbar.dart';
import 'package:kowri/widgets/custom_snackbar.dart';
import 'package:kowri/widgets/custom_widget.dart';

class UpdateAndDeleteTasks extends StatefulWidget {
  const UpdateAndDeleteTasks({super.key});

  @override
  State<UpdateAndDeleteTasks> createState() => _UpdateAndDeleteTasksState();
}

class _UpdateAndDeleteTasksState extends State<UpdateAndDeleteTasks> {
  final String currentUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        leading: CustomBackButton(
          onTap: () {
            context.go("/home");
          },
        ),
        title: const CustomText(
          text: "Update And Delete Task",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CustomText(
                text: "Track All Tasks",
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
            ),
            const SizedBox(height: 15),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Tasks").orderBy("order", descending: false).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: primary),
                    );
                  }

                  final tasks = snapshot.data!.docs.where((doc) => doc['userId'] == currentUser).toList();

                  if (tasks.isEmpty) {
                    return const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "No Tasks Created",
                            size: h2,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(width: 10),
                          FaIcon(
                            FontAwesomeIcons.tasks,
                            color: primary,
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      final title = task['title'] ?? 'Untitled Task';
                      final dueDate = task['date'] ?? 'No Date';

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 2,
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: primary,
                            child: FaIcon(FontAwesomeIcons.tasks, color: background),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomText(
                                    text: title,
                                    size: h3,
                                    fontWeight: FontWeight.bold,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await FirebaseFirestore.instance.collection("Tasks").doc(tasks[index].id).delete().then((_) {
                                      successShowRoundedSnackBar(context, 'Task Deleted Successfully');
                                    });
                                  },
                                  child: const Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.trash,
                                        color: error,
                                        size: 14,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      CustomText(
                                        text: "Delete",
                                        color: error,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CustomText(
                                    text: "Due Date: ",
                                    size: h4,
                                  ),
                                  CustomText(
                                    text: dueDate,
                                    size: h4,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.push("/edit-task/${task.id}");
                                },
                                child: const Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.pencil,
                                      color: primary,
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                      text: "Edit",
                                      color: primary,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            context.push("/view-detail/${task.id}");
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
