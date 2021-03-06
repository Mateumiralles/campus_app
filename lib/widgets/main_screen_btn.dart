import 'package:campus_app/screens/mails_screen.dart';
import 'package:campus_app/screens/tasks_screen.dart';
import 'package:flutter/material.dart';

class MainScreenBtn extends StatelessWidget {
  final IconData icon;
  final String text;
  final double iconSize;

  const MainScreenBtn(this.text, this.icon, {Key? key, this.iconSize = 50.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              if (text == 'MISSATGES') {
                return const MailsScreen();
              } else {
                return const TasksScreen();
              }
            },
          ),
        );
      },
      label: Text(
        text,
        style: const TextStyle(
          fontSize: 25,
          color: Colors.white,
        ),
      ),
      icon: Icon(
        icon,
        size: iconSize,
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}


