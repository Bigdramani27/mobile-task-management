import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kowri/helpers/colors.dart';
import 'package:kowri/helpers/size.dart';
import 'package:kowri/widgets/custom_appbar.dart';
import 'package:kowri/widgets/custom_snackbar.dart';
import 'package:kowri/widgets/custom_widget.dart';

class EditTask extends StatefulWidget {
  final String taskId;
  const EditTask({super.key, required this.taskId});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  bool emptyTitle = false;
  bool emptyDescription = false;
  bool emptyDate = false;
  bool isEmpty = false;
  DateTime date = DateTime.now();
  int? picked;
  var status = ["To Do", "In Progress", "Blocked", "Completed"];
  String? selectedStatus;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.addListener(_onTitleTextChanged);
    descriptionController.addListener(_onDescriptionTextChanged);
    dateController.addListener(_onDateTextChanged);
    fetchUserInfo();
  }

  void _onTitleTextChanged() {
    setState(() {
      emptyTitle = false;
    });
  }

  void _onDescriptionTextChanged() {
    setState(() {
      emptyDescription = false;
    });
  }

  void _onDateTextChanged() {
    setState(() {
      emptyDate = false;
    });
  }

  @override
  void dispose() {
    // Remove the listener and dispose of the controller
    titleController.removeListener(_onTitleTextChanged);
    titleController.dispose();
    descriptionController.removeListener(_onDescriptionTextChanged);
    descriptionController.dispose();
    dateController.removeListener(_onDateTextChanged);
    dateController.dispose();

    super.dispose();
  }

  Future<void> fetchUserInfo() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('Tasks').doc(widget.taskId).get();
    setState(() {
      titleController.text = snapshot.data()?['title'];
      descriptionController.text = snapshot.data()?['description'];
      dateController.text = snapshot.data()?['date'];
      selectedStatus = snapshot.data()?['status'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        leading: CustomBackButton(
          onTap: () {
            context.pop();
          },
        ),
        title: const CustomText(
          text: "Edit Task",
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
              ))
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CreateTaskTextField(
                                title: 'Title',
                                hintText: 'eg. My Routine',
                                size: h3,
                                color: background,
                                weight: FontWeight.bold,
                                controller: titleController,
                                onTap: () {},
                                borderColor: !emptyTitle ? acrossLines : error,
                                borderRadius: 10,
                                containerPadding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                width: double.infinity,
                              ),
                              if (emptyTitle == true) const SizedBox(height: 10),
                              if (emptyTitle == true)
                                const CustomText(
                                  text: "Enter your title",
                                  color: error,
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MessageTextField(
                                title: 'Description',
                                specialHeight: 180,
                                hintText: 'eg. My Routine needs to be.....',
                                color: background,
                                controller: descriptionController,
                                borderColor: !emptyDescription ? acrossLines : error,
                                borderRadius: 10,
                                width: double.infinity,
                              ),
                              if (emptyDescription == true) const SizedBox(height: 10),
                              if (emptyDescription == true)
                                const CustomText(
                                  text: "Enter your description",
                                  color: error,
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DatePicker(
                                title: 'Due Date',
                                hintText: '30/07/23 9:03:00PM',
                                color: background,
                                controller: dateController,
                                onTap: () async {
                                  final DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: date,
                                    firstDate: DateTime.now().toLocal().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0),
                                    lastDate: DateTime(3000),
                                  );

                                  if (pickedDate != null) {
                                    final TimeOfDay? pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );

                                    if (pickedTime != null) {
                                      setState(() {
                                        picked = DateTime(
                                          pickedDate.year,
                                          pickedDate.month,
                                          pickedDate.day,
                                          pickedTime.hour,
                                          pickedTime.minute,
                                        ).millisecondsSinceEpoch;
                                      });
                                      dateController.text = DateFormat('MMMM d, yyyy h:mm a').format(
                                        DateTime.fromMillisecondsSinceEpoch(picked!),
                                      );
                                    }
                                  }
                                },
                                borderColor: !emptyDate ? acrossLines : error,
                                borderRadius: 10,
                                width: double.infinity,
                              ),
                              if (emptyDate == true) const SizedBox(height: 10),
                              if (emptyDate == true)
                                const CustomText(
                                  text: "Pick a date",
                                  color: error,
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormDropDown(
                            Icon: Icon(FontAwesomeIcons.caretDown, size: 16, color: primary),
                            fontSize: 16,
                            dropColor: primary,
                            value: selectedStatus,
                            items: status.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: TextStyle(color: background),
                                ),
                              );
                            }).toList(),
                            selectedItemBuilder: (BuildContext context) {
                              return status.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Text(
                                      items,
                                      style: TextStyle(color: black),
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            onChanged: (newValue) {
                              setState(() {
                                selectedStatus = newValue.toString();
                              });
                            },
                            title: 'Status',
                            size: h2,
                            weight: FontWeight.w500,
                          ),
                        ]),
                      ),
                      CustomButton(
                          text: "Update Task",
                          isLoading: isLoading,
                          onTap: () async {
                            setState(() {
                              emptyTitle = titleController.text.isEmpty;
                              emptyDescription = descriptionController.text.isEmpty;
                              emptyDate = dateController.text.isEmpty;
                              isEmpty = emptyTitle || emptyDescription || emptyDate;
                            });
                            if (isEmpty) return;

                            setState(() => isLoading = true);

                            if (picked == null) {
                              await FirebaseFirestore.instance.collection("Tasks").doc(widget.taskId).update({
                                "title": titleController.text,
                                "description": descriptionController.text,
                                "date": dateController.text,
                                "status": selectedStatus,
                              }).then((_) {
                                setState(() => isLoading = false);
                                context.go("/view-detail/${widget.taskId}");
                                successShowRoundedSnackBar(context, 'Task Updated');
                              });
                            } else {
                              await FirebaseFirestore.instance.collection("Tasks").doc(widget.taskId).update({
                                "title": titleController.text,
                                "description": descriptionController.text,
                                "date": dateController.text,
                                "status": selectedStatus,
                                "order": Timestamp.fromDate(DateTime.fromMillisecondsSinceEpoch(picked!)),
                              }).then((_) {
                                setState(() => isLoading = false);
                                context.go("/view-detail/${widget.taskId}");
                                successShowRoundedSnackBar(context, 'Task Updated');
                              });
                            }
                          }),
                    ],
                  ),
                ),
              )),
        );
      }),
    );
  }
}
