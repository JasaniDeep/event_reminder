import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/models/task_model.dart';

class CardWidget extends StatelessWidget {
  CardWidget({
    Key? key,
    required this.task,
    required this.index,
    required this.remainTime,
  }) : super(key: key);
  String? remainTime;
  final Task task;
  final int index;

  Event buildEvent({Recurrence? recurrence}) {
    return Event(
      title: 'Test event',
      description: 'example',
      location: 'Flutter app',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(minutes: 30)),
      allDay: false,
      iosParams: const IOSParams(
        reminder: Duration(minutes: 40),
        url: "http://example.com",
      ),
      androidParams: const AndroidParams(
        emailInvites: ["test@example.com"],
      ),
      recurrence: recurrence,
    );
  }

  @override
  Widget build(BuildContext context) {
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
    final minHeight = getMinHeight(index);
    final double screenH = MediaQuery.of(context).size.height;
    final double screenW = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Color(colors[int.parse(task.color.toString())]),
      child: Container(
        // constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      task.title ?? "",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius:
                    //         const BorderRadius.all(Radius.circular(10)),
                    //     color: Colors.red.shade50,
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Text(
                    //       "${remainTime}",
                    //       style: const TextStyle(
                    //           color: Colors.red,
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //   ),
                    // ),
                    CountDownText(
                      due: DateTime.parse(remainTime!),
                      finishedText: "Done",
                      showLabel: true,
                      longDateName: true,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      task.isCompleted == 1 ? "COMPLETED" : "TODO",
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: screenH * 0.005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      task.content ?? "",
                      style: TextStyle(fontSize: 15, color: Colors.grey[100]),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              textBaseline: TextBaseline.ideographic,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  color: Colors.grey[200],
                  size: 18,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: screenH * 0.02,
                  width: screenW * 0.12,
                  child: AutoSizeText(
                    "${task.startTime}",
                    minFontSize: 10,
                    style: TextStyle(fontSize: 13, color: Colors.grey[100]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenW * 0.01),
                  height: 10,
                  width: 1.5,
                  color: Colors.grey[200]!.withOpacity(0.7),
                ),
                Icon(
                  Icons.update,
                  color: Colors.grey[200],
                  size: 18,
                ),
                Container(
                  alignment: Alignment.center,
                  height: screenH * 0.02,
                  width: screenW * 0.12,
                  child: AutoSizeText(
                    " ${task.repeat}",
                    minFontSize: 10.0,
                    style: TextStyle(fontSize: 13, color: Colors.grey[100]),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Add2Calendar.addEvent2Cal(
                  buildEvent(),
                );
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      "Add this event in calendaer",
                      // maxLines: ,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 140;
      case 3:
        return 120;
      default:
        return 130;
    }
  }
}
