import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:reminder_app/controllers/task_controller.dart';
import 'package:reminder_app/models/task_model.dart';
import 'package:reminder_app/screens/add_tasks.dart';
import 'package:reminder_app/screens/home.dart';

class DisplayTask extends StatefulWidget {
  const DisplayTask({Key? key, this.id}) : super(key: key);
  final int? id;

  @override
  _DisplayTaskState createState() => _DisplayTaskState();
}

class _DisplayTaskState extends State<DisplayTask> {
  List colors = [
    0xff648e9a,
    0xFFFF80A6,
    0xFF3699EC,
    0xff648e9a,
    0xFFFFC04E,
    0xff8c0335,
    0xff103b40,
    0xff191A19
  ];
  Task? task;
  TaskController _taskController = TaskController();
  @override
  void initState() {
    print(widget.id);
    getTask();
    super.initState();
  }

  Future getTask() async {
    task = await _taskController.getTask(widget.id!.toInt());
    setState(() {});
    print('this one: ${task!.toJson()}');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(colors[int.parse(task!.color.toString())]),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color(colors[int.parse(task!.color.toString())]),
          actions: [editButton(), deleteButton()],
          leading: IconButton(
              onPressed: () {
                Get.off(() => Home());
              },
              icon: const Icon(Icons.arrow_back_ios,
                  size: 20.0, color: Colors.white)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${task!.date}",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    "${task!.startTime}",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 10,
                    width: 1.5,
                    color: Colors.white,
                  ),
                  const Icon(
                    Icons.update,
                    color: Colors.white,
                    size: 18,
                  ),
                  Text(
                    "${task!.repeat}",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 10,
                    width: 1.5,
                    color: Colors.white,
                  ),
                  const Icon(
                    Icons.access_alarms_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  Text(
                    "${task!.remind} Minutes Early",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                '${task!.title}',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text(
                '${task!.content}',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              )
            ],
          ),
        ),
      );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        Get.to(() => AddTask(
              id: widget.id,
            ));
      });

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          _taskController
              .deleteTask(task!)
              .whenComplete(() => Get.off(() => Home()));
        },
      );
}
