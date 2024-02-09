import 'dart:async';
import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/app_themes.dart';
import 'package:reminder_app/controllers/task_controller.dart';
import 'package:reminder_app/models/task_model.dart';
import 'package:reminder_app/screens/add_tasks.dart';
import 'package:reminder_app/screens/display_task.dart';
import 'package:reminder_app/services/dark_theme_service.dart';
import 'package:reminder_app/services/notification_helper.dart';
import 'package:reminder_app/widgets/custom_button.dart';
import 'package:reminder_app/widgets/custom_textfield.dart';
import 'package:reminder_app/widgets/input_field.dart';
import 'package:reminder_app/widgets/task.dart';

class Home extends StatefulWidget {
  Home({
    Key? key,
  }) : super(key: key);
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TaskController _taskController = Get.put(TaskController());

  DateTime _selectedDate = DateTime.now();
  final controller = TextEditingController();
  String searchController = "";
  var notifyHelper;
  @override
  void initState() {
    // notifyHelper.initNotification();
    // notifyHelper.requestIOSPermission();
    _taskController.getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenH = MediaQuery.of(context).size.height;
    final double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: context.theme.backgroundColor,
          leading: IconButton(
              onPressed: () {
                ThemeService().switchTheme();
              },
              icon: Get.isDarkMode
                  ? const FaIcon(FontAwesomeIcons.lightbulb,
                      size: 20.0, color: Colors.white)
                  : const FaIcon(FontAwesomeIcons.lightbulb,
                      size: 20.0, color: Colors.yellow)),
          actions: [],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(
                      DateTime.now(),
                    ),
                    style: AppThemes().subtitleStyle,
                  ),
                  CustomButton(
                    color: Colors.green,
                    onTap: () async {
                      await Get.to(() => AddTask(
                          /*flutterLocalNotificationsPlugin: widget.flutterLocalNotificationsPlugin,*/));
                    },
                    label: 'Add Task',
                  )
                ],
              ),
              Text(
                'Today',
                style: AppThemes().titleStyle,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: DatePicker(
                  DateTime.now(),
                  height: screenH * 0.127,
                  width: screenW * 0.18,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.green,
                  selectedTextColor: Colors.white,
                  dayTextStyle: AppThemes().dayStyle,
                  monthTextStyle: AppThemes().monthStyle,
                  dateTextStyle: AppThemes().dateStyle,
                  onDateChange: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
              ),
              CustomTextField(
                width: double.maxFinite,
                // readOnly: true,
                height: 40,
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.green,
                ),
                controller: controller,
                hintText: 'Search',
                onChanged: (p0) {
                  searchController = p0;
                  setState(() {});
                },
              ),
              SizedBox(
                height: 10,
              ),
              _showTasks()
            ],
          ),
        ));
  }

  _showTasks() {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
            itemCount: _taskController.tasksList.length,
            itemBuilder: (context, index) {
              Task task = _taskController.tasksList[index];

              DateTime dateTime = DateFormat('M/d/yyyy h:mm a')
                  .parse("${task.date} ${task.startTime}");

              String timestamp =
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

              if (searchController.isEmpty ||
                  (searchController.isNotEmpty &&
                      task.title!.startsWith(searchController))) {
                return _showAnimationConfig(
                    id: int.parse(task.id.toString()),
                    index: index,
                    remainTime: "$timestamp",
                    onLongPressed: () {
                      _showBottomSheets(
                          _taskController.tasksList[index], context);
                    });
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }

  _showBottomSheets(Task task, BuildContext context) async {
    Get.bottomSheet(Container(
      height: MediaQuery.of(context).size.height * 0.1,
      color: Get.isDarkMode ? const Color(0xff1f1f21) : Colors.white,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(3.0),
            width: MediaQuery.of(context).size.width * 0.4,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey.shade600,
                borderRadius: BorderRadius.circular(50.0)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              task.isCompleted == 1
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10.0),
                      child: CustomButton(
                          height: 50,
                          width: 150,
                          color: Colors.green,
                          label: 'Completed',
                          onTap: () {
                            _taskController.updateTaskStatus(task.id!);
                            Get.back();
                          }),
                    ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                child: CustomButton(
                    height: 50,
                    width: 150,
                    color: Colors.red,
                    label: 'Delete',
                    onTap: () {
                      _taskController.deleteTask(task);
                      Get.back();
                    }),
              )
            ],
          )
        ],
      ),
    ));
  }

  _showAnimationConfig(
      {required int id,
      required int index,
      required Function onLongPressed,
      String? remainTime}) {
    return AnimationConfiguration.staggeredList(
        position: index,
        child: SlideAnimation(
          child: FadeInAnimation(
            child: GestureDetector(
              onLongPress: () {
                onLongPressed();
              },
              onTap: () {
                Get.to(() => DisplayTask(
                      id: id,
                    ));
              },
              child: CardWidget(
                task: _taskController.tasksList[index],
                index: index,
                remainTime: remainTime!,
              ),
            ),
          ),
        ));
  }
}
