import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool? won;
  final Function() onReset;

  ResultWidget({required this.won, required this.onReset});

  Color _getColor() {
    if (won == null) {
      return Colors.yellow;
    } else if (won == true) {
      return Colors.green.shade300;
    } else {
      return Colors.red.shade300;
    }
  }

  IconData _getIcon() {
    if (won == null) {
      return Icons.sentiment_satisfied;
    } else if (won == true) {
      return Icons.sentiment_very_satisfied;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
          child: Container(
        padding: EdgeInsets.all(10),
        child: CircleAvatar(
          backgroundColor: _getColor(),
          child: IconButton(
            padding: EdgeInsets.all(0),
            onPressed: onReset,
            icon: Icon(
              _getIcon(),
              color: Colors.black,
              size: 35,
            ),
          ),
        ),
      )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
