import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback restoreTaskCallback;
  final VoidCallback editTaskCallback;

  const PopupMenu({
    Key? key,
    required this.task,
    required this.cancelOrDeleteCallback,
    required this.restoreTaskCallback,
    required this.editTaskCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDeleted == false
          ? ((context) => [
                PopupMenuItem(
                  onTap: null,
                  child: TextButton.icon(
                    icon: const Icon(CupertinoIcons.pencil_ellipsis_rectangle),
                    label: const Text('Edit'),
                    onPressed: editTaskCallback,
                  ),
                ),
                PopupMenuItem(
                    onTap: cancelOrDeleteCallback,
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(CupertinoIcons.delete),
                      label: const Text('Delete'),
                    )),
              ])
          : (context) => [
                PopupMenuItem(
                    onTap: restoreTaskCallback,
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(CupertinoIcons.return_icon),
                      label: const Text('Restore'),
                    )),
              ],
    );
  }
}
// PopupMenuItem(
                //     child: TextButton.icon(
                //       onPressed: null,
                //       icon: const Icon(Icons.delete_forever),
                //       label: const Text('Delete forever'),
                //     ),
                //     onTap: cancelOrDeleteCallback),