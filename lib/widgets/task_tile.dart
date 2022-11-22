import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_task/widgets/popup_menu.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../pages/edit_task_screen.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
        : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: EditTaskScreen(
                  oldTask: task,
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          decoration:
                              task.isDone! ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      Text(
                        DateFormat()
                            .add_yMMMEd()
                            .add_Hms()
                            .format(DateTime.parse(task.date)),
                        //DateTime.parse(task.date)
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted == false
                    ? (value) {
                        context.read<TasksBloc>().add(UpdateTask(task: task));
                      }
                    : null,
              ),
              PopupMenu(
                task: task,
                cancelOrDeleteCallback: () {
                  _removeOrDeleteTask(context, task);
                  _showToast(
                      context,
                      'You`ve deleted  task.\n' +
                          task.title +
                          ' can be restored in Bin');
                },
                editTaskCallback: () {
                  Navigator.of(context).pop();
                  _editTask(context);
                },
                restoreTaskCallback: () {
                  context.read<TasksBloc>().add(RestoreTask(task: task));
                  _showToast(context, 'You`ve restored  task');
                },
              ),
            ],
          )
        ],
      ),
    );
  }

// Toast
  void _showToast(
    BuildContext context,
    String text,
  ) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
            label: 'Hide', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
